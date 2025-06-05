package main

import (
	"Autotester/configs"
	"Autotester/internal"
	"fmt"
	"net/http"
)

func main() {
	config := configs.LoadConfig()
	router := http.NewServeMux()
	internal.NewScanHandler(router, internal.ScanHandlerDeps{
		Config: config,
	})
	server := http.Server{
		Addr:    ":8081",
		Handler: router}
	fmt.Println("The server is listening on 8081")
	err := server.ListenAndServe()
	if err != nil {
		return
	}
}
