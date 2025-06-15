package configs

import (
	"github.com/joho/godotenv"
	"log"
	"os"
	"strconv"
	"time"
)

type Config struct {
	Rights  string
	Timeout time.Duration
}

func LoadConfig() *Config {
	err := godotenv.Load("configs/.env")
	if err != nil {
		log.Println("Error loading .env file, using default config", err.Error())
	}
	return &Config{
		Rights: os.Getenv("RIGHTS"),
		Timeout: func() time.Duration {
			timeout := os.Getenv("TIMEOUT")
			intTimeout, _ := strconv.Atoi(timeout)
			return time.Duration(intTimeout) * time.Second
		}(),
	}
}
