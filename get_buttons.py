import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin


def get_buttons(base_url, html):
    soup = BeautifulSoup(html, 'lxml')
    forms = []

    for form in soup.find_all('form'):
        form_info = {
            'action': urljoin(base_url, form.get('action', '')),
            'method': form.get('method', 'GET').upper(),
            'inputs': [],
            'button_texts': []
        }

        for tag in form.find_all(['input', 'textarea', 'select']):
            if tag.get('type') in ['submit', 'button']:
                continue

            input_info = {
                'name': tag.get('name'),
                'type': tag.get('type', 'text'),
                'value': tag.get('value', '')
            }
            form_info['inputs'].append(input_info)

        # Собираем текст кнопок
        for button in form.find_all(['button', 'input']):
            if button.get('type') in ['submit', 'button']:
                text = button.text.strip()
                if not text and button.get('value'):
                    text = button.get('value').strip()
                if text:
                    form_info['button_texts'].append(text)

        forms.append(form_info)

    return forms
