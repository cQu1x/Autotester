package handlers

import (
	"Autotester/configs"
	"Autotester/internal/domain"
	"Autotester/internal/util"
	"Autotester/pkg/res"
	"encoding/json"
	"log"
	"net/http"
)

// ResultHandler handles /api/results requests.
type ResultPDFHandler struct {
	*configs.Config
}

// NewResultPDFHandler returns a new ResultPDFHandler.
func NewResultPDFHandler(config *configs.Config) *ResultPDFHandler {
	return &ResultPDFHandler{Config: config}
}

// ResultsPDF handles the /api/resultsPDF endpoint.
func (h *ResultPDFHandler) ResultsPDF(w http.ResponseWriter, req *http.Request) {
	var results domain.TestResult
	err := json.NewDecoder(req.Body).Decode(&results)
	if err != nil {
		log.Println("Failed to decode results:", err)
		res.ErrorResponce(w, "Failed to decode results: "+err.Error(), http.StatusBadRequest)
		return
	}
	pdf, err := util.GeneratePDF(results.Results)
	if err != nil {
		log.Println("Failed to generate PDF:", err)
		res.ErrorResponce(w, "Failed to generate PDF: "+err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Disposition", "attachment; filename=results.pdf")
	w.Write(pdf)
}
