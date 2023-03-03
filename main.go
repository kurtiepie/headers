package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
)

type EnvVars struct {
	Port string
}

func GetEnv() EnvVars {
	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("ENVIORMENT VARIABLE 'PORT' Missing")
	}

	return EnvVars{
		Port: port,
	}
}

func HomeHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("Got a connection")
	for k, v := range r.Header {
		fmt.Fprintf(w, "%v: %v\n", k, v)
	}

}

func main() {
	envVars := GetEnv()
	port := fmt.Sprintf(":%v", envVars.Port)

	log.Println("Starting on PORT: ", port)
	r := mux.NewRouter()
	r.HandleFunc("/", HomeHandler)
	http.ListenAndServe(port, r)
}
