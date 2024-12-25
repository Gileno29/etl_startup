package commands

import (
	"fmt"
	"os"

	"github.com/Gileno29/etl_startup/utils"
	"github.com/spf13/cobra"
)

var (
	GITHUB_PATH = "PATH_TO_REPOSITORY"
)

var projectPath string

func SetupMkauth() (*cobra.Command, error) {
	var mkauth string
	var cmd = &cobra.Command{
		Use:   "mkauth",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do mkauth",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("You must supply a project path.")
				return
			}
			err := os.Mkdir("sql", 0755)
			if err != nil {
				fmt.Printf("Erro ao criar o diretório: %v\n", err)
				return
			}
			if mkauth != "" {
				fmt.Println("Criando estruturas de diretorio")
				err = utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comercais/Mkauth/sql/", projectPath)
				if err != nil {
					fmt.Println("erro ao copiar arquivos de SQL ")
					return
				}
				err = utils.CopyFile(os.Getenv(GITHUB_PATH)+"/Sistemas_Comercais/Mkauth/new_step.sh", projectPath)
				if err != nil {
					fmt.Println("erro ao copiar arquivo de step ")
					return
				}
				err = utils.CopyFile(os.Getenv(GITHUB_PATH)+"/Sistemas_Comercais/Mkauth/import_mkauth.py", projectPath)
				if err != nil {
					fmt.Println("erro ao copiar arquivo de importacao ")
					return
				}
				os.Chmod(".new_step.sh", 0755)
			}
		},
	}
	cmd.Flags().StringVarP(&mkauth, "--mkauth", "", "", "cria estrutura do mkauth")
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")

	return cmd, nil

}
