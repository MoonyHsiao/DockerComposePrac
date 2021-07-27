package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/goombaio/namegenerator"
)

var serverName string
var askcount int

func main() {

	seed := time.Now().UTC().UnixNano()
	nameGenerator := namegenerator.NewNameGenerator(seed)

	name := nameGenerator.Generate()
	serverName = name
	askcount = 0

	port := ":18086"

	router := gin.Default()
	v1 := router.Group("/apiV2/")
	v1.GET("/welcome", hello)
	router.Run(port)
}

func hello(ctx *gin.Context) {
	askcount++
	res := fmt.Sprintf("Hello,This is server : %v!, you have been visited %v times. V2", serverName, askcount)

	ctx.JSON(http.StatusOK, res)
}
