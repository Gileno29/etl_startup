package commands

import (
	"fmt"
	"os"

	"github.com/Gileno29/etl_startup/utils"
	"github.com/spf13/cobra"
)

var (
	GITHUB_PATH = "GITHUB_REPOSITORY"
)

var projectPath string

func SetupMkauth() (*cobra.Command, error) {
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
				if os.IsExist(err) {
					fmt.Println("O diretório já existe, nada a fazer.")
				} else {
					fmt.Printf("Erro ao criar o diretório: %v\n", err)
					return
				}
			}

			fmt.Println("Criando estruturas de diretorio")
			err = utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Mkauth/sql/", projectPath+"/sql")
			if err != nil {
				fmt.Println("erro ao copiar arquivos de SQL ", err)
				return
			}
			err = utils.CopyFile(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Mkauth/new_step.sh", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivo de step ", err)
				return
			}
			err = utils.CopyFile(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Mkauth/import_mkauth.py", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivo de importacao ")
				return
			}
			os.Chmod(".new_step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")

	return cmd, nil

}
