package commands

import (
	"encoding/csv"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/Gileno29/etl_startup/utils"
	"github.com/spf13/cobra"
)

var (
	GITHUB_PATH = "GITHUB_REPOSITORY"
)

var comands []*cobra.Command

var projectPath string
var outputfile string
var delimiter string
var directory string

func LoadComands() []*cobra.Command {
	setupMkauth()
	setupTopsapp()
	setupReceitanet()
	setupIXC()
	setupProvap()
	setupVigo()
	setupQuazar()
	setupLFAdmin()
	setupISPfy()
	setupISPcloud()
	updateRepo()
	convertFiles()

	return comands
}

func setupMkauth() {
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
			err = utils.CopyFile(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Mkauth/step.sh", projectPath+"/step.sh")
			if err != nil {
				fmt.Println("erro ao copiar arquivo de step ", err)
				return
			}
			err = utils.CopyFile(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Mkauth/import_mkauth.py", projectPath+"/import_mkauth.py")
			if err != nil {
				fmt.Println("erro ao copiar arquivo de importacao ")
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)

}

func setupTopsapp() {
	var cmd = &cobra.Command{
		Use:   "topsapp",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do topsapp",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("You must supply a project path.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/TopSapp/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do topsapp ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupReceitanet() {
	var cmd = &cobra.Command{
		Use:   "receitanet",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do receitanet",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Receitanet/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do Receitanet ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}
func setupIXC() {
	var cmd = &cobra.Command{
		Use:   "ixc",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do IXC",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/IXCSoft/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do IXC ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupProvap() {
	var cmd = &cobra.Command{
		Use:   "provap",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do IXC",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Provap/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do provapp ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupVigo() {
	var cmd = &cobra.Command{
		Use:   "vigo",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do Vigo",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Vigo/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do vigo ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupQuazar() {
	var cmd = &cobra.Command{
		Use:   "quazar",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do Quazar",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Quazar/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do quazar ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupLFAdmin() {
	var cmd = &cobra.Command{
		Use:   "lfadmin",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do LFAdmin",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/LFAdmin/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do ispfy ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupISPfy() {
	var cmd = &cobra.Command{
		Use:   "ispfy",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do ispFy",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/Ispfy/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do ispfy ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func setupISPcloud() {
	var cmd = &cobra.Command{
		Use:   "ispcloud",
		Short: "Cria a estrutura de diretorios e os arquivos para o ETL do IspCloud",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if projectPath == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}

			fmt.Println("Criando estruturas de diretorio")
			err := utils.CopyAllFiles(os.Getenv(GITHUB_PATH)+"/Sistemas_Comerciais/IspCloud/", projectPath)
			if err != nil {
				fmt.Println("erro ao copiar arquivos do IspCloud ", err)
				return
			}
			os.Chmod(projectPath+"/step.sh", 0755)

		},
	}
	cmd.Flags().StringVarP(&projectPath, "path", "p", "", "caminho para o diretorios de criação")
	comands = append(comands, cmd)
}

func updateRepo() {
	var cmd = &cobra.Command{
		Use:   "update-repo",
		Short: "Atualiza repositorio",
		Run: func(cmd *cobra.Command, args []string) {

			utils.UpdateRepository(os.Getenv(GITHUB_PATH))

		},
	}
	comands = append(comands, cmd)
}

func convertFiles() {
	var cmd = &cobra.Command{
		Use:   "convert-file",
		Short: "Conver um ou vários arquivos para csv com delimitador",
		Run: func(cmd *cobra.Command, args []string) {
			// validations
			if directory == "" {
				fmt.Println("É necessário passar o path para o ambiente.")
				return
			}
			if outputfile == "" {
				fmt.Println("É necessário passar o nome do arquivo de saida.")
				return
			}

			outFile, err := os.Create(outputfile)
			if err != nil {
				log.Fatalf("Erro ao criar o arquivo de saída: %v", err)
			}
			defer outFile.Close()

			// Criar o writer para o arquivo CSV com delimitador personalizado
			writer := csv.NewWriter(outFile)
			writer.Comma = rune(delimiter[0])
			defer writer.Flush()

			// Processar os arquivos no diretório
			err = filepath.Walk(directory, func(path string, info os.FileInfo, err error) error {
				if err != nil {
					return err
				}

				// Ignorar subdiretórios
				if info.IsDir() {
					return nil
				}
				
				ext := strings.ToLower(filepath.Ext(info.Name()))
				
				switch ext {
				case ".xls", ".xlsx":
					err := utils.ProcessExcelFile(path, write, outFile)
					if err != nil {
						log.Printf("Erro ao processar o arquivo Excel %s: %v", path, err)
					}
				case ".csv":
					err := utils.ProcessCSVFile(path, writer, outFile)
					if err != nil {
						log.Printf("Erro ao processar o arquivo CSV %s: %v", path, err)
					}
				case strings.ToLower(filePath.Base())==strings.ToLower(outputfile):
					log.Printf("Arquivo é o mesmo do output: %s", filePath)

				default:
					log.Printf("Arquivo ignorado (extensão não suportada): %s", path)
				}
				return nil
			})

			if err != nil {
				log.Fatalf("Erro ao percorrer o diretório: %v", err)
			}

			fmt.Println("Processamento concluído. Arquivo de saída gerado:", outputfile)

		},
	}
	cmd.Flags().StringVarP(&directory, "path-directory", "p", "", "caminho para o diretorios de criação")
	cmd.Flags().StringVarP(&outputfile, "output-file", "o", "", "arquivo de saida")
	cmd.Flags().StringVarP(&delimiter, "delimiter", "d", "", "Delimitador do arquivo")
	comands = append(comands, cmd)
}
