package util

import (
	"errors"
	"net/url"
	"strings"
)

func ValidateUrl(link *string) error {
	if !strings.HasPrefix(*link, "http://") && !strings.HasPrefix(*link, "https://") {
		*link = "https://" + *link
	}
	parsed, err := url.ParseRequestURI(*link)
	if err != nil {
		return errors.New("wrong url format")
	}
	if parsed.Scheme != "http" && parsed.Scheme != "https" {
		return errors.New("url must start with http:// or https://")
	}
	if parsed.Host == "" {
		return errors.New("url must have a hostname")
	}
	if !strings.Contains(parsed.Host, ".") {
		return errors.New("url must have a hostname")
	}
	return nil
}

//Написать проверку, существует ли сайт
