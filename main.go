package main

import (
	"fmt"
	"os"

	"github.com/dgollings/sqlboiler-crdb/v4/driver" // forked from glerchundi
	"github.com/volatiletech/sqlboiler/v4/drivers"
)

func main() {
	if len(os.Args) == 1 {
		fmt.Fprintf(os.Stderr, "Version: v4")
		return
	}
	drivers.DriverMain(&driver.CockroachDBDriver{})
}
