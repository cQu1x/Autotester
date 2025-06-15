package domain
// TestR// TestResult represents the result of a single test
type TestResult struct {
	Test   string `json:"test"`   // Name of the test performed
	Result string `json:"result"` // Result of the test (true/false)
}

// ScanResult represents array of test results
type ScanResult struct {
	Results []TestResult `json:"results"`
}lt represents the result of a single test
type TestResult struct {
    Test   string `json:"test"`   // Name of the test performed
    Result string `json:"result"` // Result of the test (true/false)
}

// ScanResult represents array of test results
type ScanResult struct {
    Results []TestResult `json:"results"`
} UrlRequest represents the payload for URL scanning requests.
type UrlRequest struct {
	Url    string   `json:"url"`
	Tests  []string `json:"tests"` // Array of test names to be performed
}

// APIResponse represents a standard response structure for API endpoints.
type APIResponse struct {
	Status string      `json:"status"`
	Data   interface{} `json:"data,omitempty"`
	Error  string      `json:"error,omitempty"`
}

type TestResult struct {
	test string `json:"test"` // Name of the test performed
}
