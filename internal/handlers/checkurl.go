package handlers

import (
	"Autotester/configs"
	"Autotester/internal/domain"
	"Autotester/internal/util"
	"Autotester/pkg/res"
	"encoding/json"
	"net/http"
)

type ScanHandler struct {
	*configs.Config
}

func NewScanHandler(config *configs.Config) *ScanHandler {
	return &ScanHandler{Config: config}
}

func (h *ScanHandler) Scan(w http.ResponseWriter, req *http.Request) {
	var payload domain.UrlRequest
	err := json.NewDecoder(req.Body).Decode(&payload)
	if err != nil {
		res.ErrorResponce(w, err.Error(), http.StatusBadRequest)
		return
	}
	if err := util.ValidateUrl(&payload.Url); err != nil {
		res.ErrorResponce(w, err.Error(), http.StatusBadRequest)
		return
	}
	if _, err := util.NewAvailabilityClient(h.Config.Timeout).CheckSite(payload.Url); err != nil {
		res.ErrorResponce(w, "Site is not available or returned an invalid status code: "+err.Error(), http.StatusBadRequest)
		return
	}
	resp := domain.APIResponse{
		Status: "success",
		Data: map[string]string{
			"message": "URL is valid and accepted for scanning",
			"url":     payload.Url,
		},
	}
	res.JSONResponce(w, resp, http.StatusOK)
	return
}
