package main

import (
	"github.com/gin-gonic/gin"
	"lesson-2/controllers"
)

func main() {
	// Create a router
	router := NewRouter()

	// Listen and serve on 0.0.0.0:8080
	router.Run()
}

func NewRouter() *gin.Engine {
	// Default router
	router := gin.Default()

	// Create a Ping Controller
	ping := new(controllers.PingController)
	// Setup route
	router.GET("/ping", ping.Index)

	return router
}