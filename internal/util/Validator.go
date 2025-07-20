package util

import (
	"Autotester/internal/domain"
	"errors"
	"log"

	"github.com/go-playground/validator/v10"
)

// ValidateUrl validates the given URL string pointer.
func ValidateUrl(payload *domain.UrlRequest) error {
	// if link == nil || *link == "" {
	// 	return errors.New("url cannot be empty")
	// }
	// if !strings.HasPrefix(*link, "http://") && !strings.HasPrefix(*link, "https://") {
	// 	return errors.New("url does not start with http:// or https://")
	// }
	// parsed, err := url.ParseRequestURI(*link)
	// if err != nil {
	// 	return errors.New("wrong url format")
	// }
	// if parsed.Host == "" || !strings.Contains(parsed.Host, ".") {
	// 	return errors.New("url must have a hostname")
	// }
	validate := validator.New()
	err := validate.Struct(*payload)
	if err != nil {
		log.Println("Validation error:", err)
		return errors.New("Validator error: " + err.Error())
	}
	return nil
}
