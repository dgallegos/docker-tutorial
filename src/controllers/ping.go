package controllers

import (
	"github.com/gin-gonic/gin"
)

type PingController struct{}

func (p PingController) Index(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
		})
}
