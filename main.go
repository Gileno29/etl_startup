package main

import (
	"log"

	"github.com/Gileno29/etl_startup/commands"
	"github.com/joho/godotenv"
	"github.com/spf13/cobra"
)

var (
	GITHUB_PATH = "PATH_TO_REPOSITORY"
)

var rootCommand = &cobra.Command{
	Use:   "etl",
	Short: "Uma aplicação CLI para criação de projetos ETL",
}

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	/*err = utils.UpdateRepository(os.Getenv(GITHUB_PATH))
	if err != nil {
		log.Fatal("Erro ao atualizar repositorio")

	}*/
	comands := commands.LoadComands()
	for i := 0; i < len(comands); i++ {
		rootCommand.AddCommand(comands[i])

	}

	rootCommand.Execute()

}
