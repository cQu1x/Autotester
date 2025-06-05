package internal

import (
	"Autotester/configs"
	"Autotester/pkg/res"
	"encoding/json"
	"net/http"
)

type ScanHandlerDeps struct {
	*configs.Config
}
type ScanHandler struct {
	*configs.Config
}

func NewScanHandler(router *http.ServeMux, deps ScanHandlerDeps) {
	handler := &ScanHandler{
		Config: deps.Config,
	}
	router.HandleFunc("POST /scan", handler.scan())
}

func (handler *ScanHandler) scan() http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		var payload UrlRequest
		err := json.NewDecoder(req.Body).Decode(&payload)
		if err != nil {
			res.ErrorResponce(w, err.Error(), http.StatusBadRequest)
			return
		}
		if err := ValidateUrl(&payload.Url); err != nil {
			res.ErrorResponce(w, err.Error(), http.StatusBadRequest)
			return
		}
		res.JSONResponce(w, map[string]string{
			"message": "URL принят и валиден",
			"url":     payload.Url},
			http.StatusOK)
	}
}
