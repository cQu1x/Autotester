package internal

import (
	"net/url"
	"strings"
)

func ValidateUrl(link *string) error {
	if !strings.HasPrefix(*link, "http://") && !strings.HasPrefix(*link, "https://") {
		*link = "https://" + *link
	}
	parsed, err := url.ParseRequestURI(*link)
	if err != nil {

	}
	if parsed.Scheme != "http" && parsed.Scheme != "https" {

	}
	if parsed.Host == "" {

	}
	return nil
}
