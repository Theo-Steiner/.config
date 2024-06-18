package main

import (
	"fmt"
	"os/exec"
)

func main() {
	cmd := exec.Command("nvim peke")
	err := cmd.Run()
	if err != nil {
		fmt.Printf("err %s", err)
		return
	}
	fmt.Println("success")
}
