package utils

import (
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
)

func UpdateRepository(gitRepo string) error {
	err := os.Chdir(gitRepo)
	if err != nil {
		fmt.Printf("Failed to change directory: %v\n", err)
		return err
	}

	// Execute the 'git pull' command
	cmd := exec.Command("git", "pull", "origin", "main")
	cmd.Stdout = os.Stdout // Redirect the command's output to the terminal
	cmd.Stderr = os.Stderr // Redirect errors to the terminal

	// Run the command
	err = cmd.Run()
	if err != nil {
		fmt.Printf("Failed to execute git pull: %v\n", err)
		return err

	}

	return nil

}

func CopyFile(src, dst string) error {
	// Abrir o arquivo de origem
	sourceFile, err := os.Open(src)
	if err != nil {
		return fmt.Errorf("erro ao abrir o arquivo de origem: %w", err)
	}
	defer sourceFile.Close()

	// Criar o arquivo de destino
	destinationFile, err := os.Create(dst)
	if err != nil {
		return fmt.Errorf("erro ao criar o arquivo de destino: %w", err)
	}
	defer destinationFile.Close()

	// Copiar os dados do arquivo de origem para o destino
	_, err = io.Copy(destinationFile, sourceFile)
	if err != nil {
		return fmt.Errorf("erro ao copiar os dados: %w", err)
	}

	// Sincronizar os dados para garantir que tudo foi gravado no disco
	err = destinationFile.Sync()
	if err != nil {
		return fmt.Errorf("erro ao sincronizar o arquivo: %w", err)
	}

	return nil
}

func CopyAllFiles(srcDir, dstDir string) error {
	// Listar todos os arquivos no diretório de origem
	files, err := os.ReadDir(srcDir)
	if err != nil {
		return fmt.Errorf("erro ao ler o diretório de origem: %w", err)
	}

	// Garantir que o diretório de destino exista
	err = os.MkdirAll(dstDir, 0755)
	if err != nil {
		return fmt.Errorf("erro ao criar o diretório de destino: %w", err)
	}

	// Iterar sobre os arquivos e copiá-los
	fmt.Printf("Copiando arquivos...")
	for _, file := range files {
		if !file.IsDir() { // Ignorar subdiretórios
			srcPath := filepath.Join(srcDir, file.Name())
			dstPath := filepath.Join(dstDir, file.Name())

			err = CopyFile(srcPath, dstPath)
			if err != nil {
				return fmt.Errorf("erro ao copiar o arquivo %s: %w", file.Name(), err)
			}
		}
	}
	fmt.Printf("Finalizado setup!!")

	return nil
}
