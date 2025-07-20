import pytest
from fastapi.testclient import TestClient
from unittest.mock import patch, MagicMock
from main import app, ask_ai, WebTestRunner

client = TestClient(app)

@patch("main.client.chat.completions.create")
def test_ask_ai_success(mock_create):
    mock_create.return_value.choices = [MagicMock(message=MagicMock(content="Yes"))]
    from main import ask_ai
    response = ask_ai("Does logo exist?")
    assert response == "Yes"

@patch("playwright.sync_api.sync_playwright")
def test_fetch_page(mock_playwright):
    mock_browser = MagicMock()
    mock_context = MagicMock()
    mock_page = MagicMock()
    mock_page.content.return_value = "<html><body>Test Page</body></html>"

    mock_context.new_page.return_value = mock_page
    mock_browser.new_context.return_value = mock_context
    mock_playwright.return_value.__enter__.return_value.chromium.launch.return_value = mock_browser

    runner = WebTestRunner("http://example.com")
    html = runner.fetch_page("http://example.com")
    assert "<body>" in html

@patch("main.ask_ai")
@patch.object(WebTestRunner, "fetch_page")
def test_check_page_success(mock_fetch, mock_ai):
    mock_fetch.return_value = "<html><body><div>Logo</div></body></html>"
    mock_ai.return_value = "Yes"
    
    runner = WebTestRunner("http://example.com")
    result = runner.check_page("http://example.com", ["Does logo exist?"])
    assert result == [True]

@patch("main.ask_ai")
@patch("playwright.sync_api.sync_playwright")
def test_integration_test_success(mock_playwright, mock_ai):
    # LLM returns successful result immediately
    mock_ai.return_value = '<json>{"status": "success", "message": "Done"}</json>'
    
    mock_browser = MagicMock()
    mock_context = MagicMock()
    mock_page = MagicMock()
    mock_page.content.return_value = "<html><body>OK</body></html>"
    
    mock_context.new_page.return_value = mock_page
    mock_browser.new_context.return_value = mock_context
    mock_playwright.return_value.__enter__.return_value.chromium.launch.return_value = mock_browser

    runner = WebTestRunner("http://example.com")
    runner.current_url = "http://example.com"
    
    result, message = runner.integration_test("Login test")
    assert result is True
    assert message == "Done"

@patch("main.WebTestRunner.fetch_page")
@patch("main.ask_ai")
@patch("main.requests.post")
def test_run_endpoint(mock_post, mock_ai, mock_fetch):
    mock_ai.return_value = "Yes"
    mock_fetch.return_value = "<html><body>Test</body></html>"
    mock_post.return_value.status_code = 200

    response = client.post("/run", json={
        "url": "http://example.com",
        "tests": ["Does logo exist?", "Login with username and password"]
    })
    assert response.status_code == 200
    assert isinstance(response.json()["data"], list)

