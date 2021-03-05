package main

import (
	"io/ioutil"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	gin.SetMode(gin.ReleaseMode)
	engine := gin.New()
	engine.Use(
		gin.LoggerWithWriter(gin.DefaultWriter, "/"),
		gin.Recovery(),
	)

	gin.DefaultWriter = ioutil.Discard
	engine.GET("/", func(context *gin.Context) {
		context.String(http.StatusOK, "Hello world")
	})
	engine.Run(":8082")
}
