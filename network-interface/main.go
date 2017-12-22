package main

import (
	"errors"
	"os"

	"github.com/docker/libcontainer/netlink"
)

func main() {
	interfaceName, err := getDefaultGatewayIfaceName()
	checkError(err)

	logToConsole(false, interfaceName)
	os.Exit(0)
}

func getDefaultGatewayIfaceName() (string, error) {
	routes, err := netlink.NetworkGetRoutes()
	if err != nil {
		return "", err
	}
	for _, route := range routes {
		if route.Default {
			if route.Iface == nil {
				return "", errors.New("found default route but could not determine interface")
			}
			return route.Iface.Name, nil
		}
	}
	return "", errors.New("unable to find default route")
}

func checkError(errorToCheck error) {
	if errorToCheck != nil {
		logToConsole(true, errorToCheck.Error())
		os.Exit(1)
	}
}

func logToConsole(logAsError bool, txt string) {
	var err error
	if logAsError {
		_, err = os.Stderr.WriteString(txt)
	} else {
		_, err = os.Stdout.WriteString(txt)
	}
	if err != nil {
		panic(err)
	}
}
