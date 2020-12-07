package main

import (
	"fmt"
	"time"
)

func main() {
	for {
		fmt.Println(time.Now().UnixNano() / 1000)
	}
}
