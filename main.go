package main

import (
	"log"
	"os"

	"github.com/Gileno29/etl_startup/utils"
	"github.com/joho/godotenv"
)

var (
	GITHUB_PATH = "PATH_TO_REPOSITORY"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	err = utils.UpdateRepository(os.Getenv(GITHUB_PATH))
	if err != nil {
		log.Fatal("Erro ao atualizar repositorio")

	}

}
