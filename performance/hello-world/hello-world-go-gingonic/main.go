package main

import (
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	gin.SetMode(gin.ReleaseMode)
	engine := gin.New()
	gin.DefaultWriter = ioutil.Discard
	engine.Use(
		gin.LoggerWithWriter(gin.DefaultWriter, "/"),
		gin.Recovery(),
	)

	engine.GET("/", func(context *gin.Context) {
		context.String(http.StatusOK, "Hello world")
	})
	engine.Run(":8080")
	fmt.Println("Server started on port 8080")
}
