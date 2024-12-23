package utils

import (
	"fmt"
	"os"
	"os/exec"
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
