package handlers

import (
	"Autotester/configs"
	"net/http"
)

type RoutesHandlerDeps struct {
	Config *configs.Config
}

func RegisterRoutes(router *http.ServeMux, config *configs.Config) {
	scanHandler := NewScanHandler(config)
	testsHandler := NewTestsHandler(config)
	resultsHandler := NewResultHandler(config)

	router.HandleFunc("POST /scan", scanHandler.Scan)
	router.HandleFunc("POST /tests", testsHandler.Tests)
	router.HandleFunc("POST /results", resultsHandler.HandleResults)
}
