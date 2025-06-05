package res

import (
	"encoding/json"
	"log"
	"net/http"
)

func JSONResponce(w http.ResponseWriter, data any, statusCode int) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(statusCode)
	err := json.NewEncoder(w).Encode(data)
	if err != nil {
		log.Println("Error in process of encoding")
		return
	}
}

func ErrorResponce(w http.ResponseWriter, data string, statusCode int) {
	JSONResponce(w, map[string]string{"error": data}, statusCode)
}
