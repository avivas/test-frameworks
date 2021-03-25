package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"

	_ "github.com/go-sql-driver/mysql"

	"github.com/gin-gonic/gin"
)

type User struct {
	ID          int64  `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
}

var db *sql.DB

func main() {
	var err error
	db, err = sql.Open("mysql", "user:password@tcp(127.0.0.1:43306)/crud")

	if err != nil {
		log.Println(err.Error())
		return
	}
	db.SetMaxOpenConns(100)
	db.SetMaxIdleConns(100)

	gin.SetMode(gin.ReleaseMode)
	engine := gin.New()
	gin.DefaultWriter = ioutil.Discard

	engine.POST("/", Post)
	engine.GET("/:id", Get)
	engine.PUT("/:id", Put)
	engine.DELETE("/:id", Delete)
	err = engine.Run(":8086")
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	fmt.Println("Server started on port 8086")
}

func Get(context *gin.Context) {
	id := context.Param("id")
	results, err := db.Query("SELECT id,name,description FROM user WHERE id=?", id)

	if err != nil {
		context.String(http.StatusInternalServerError, err.Error())
		return
	}
	defer results.Close()

	for results.Next() {
		var user User
		err = results.Scan(&user.ID, &user.Name, &user.Description)
		if err != nil {
			context.String(http.StatusInternalServerError, err.Error())
			return
		}
		context.JSON(http.StatusOK, user)
		break
	}
}

func Post(context *gin.Context) {
	user := User{}
	context.BindJSON(&user)
	insert, err := db.Query("INSERT INTO user (name,description) VALUES(?,?)", user.Name, user.Description)
	if err != nil {
		fmt.Println(err.Error())
		context.String(http.StatusInternalServerError, err.Error())
		return
	}
	defer insert.Close()
	context.JSON(http.StatusOK, user)
}

func Delete(context *gin.Context) {
	id := context.Param("id")
	delete, err := db.Query("DELETE FROM user WHERE id=?", id)
	if err != nil {
		fmt.Println(err.Error())
		context.String(http.StatusInternalServerError, err.Error())
		return
	}
	defer delete.Close()
	context.String(http.StatusOK, "")
}

func Put(context *gin.Context) {
	id := context.Param("id")
	user := User{}
	context.BindJSON(&user)
	insert, err := db.Query("UPDATE user SET name=?,description=? WHERE id=?", user.Name, user.Description, id)
	if err != nil {
		fmt.Println(err.Error())
		context.String(http.StatusInternalServerError, err.Error())
		return
	}
	defer insert.Close()
	context.JSON(http.StatusOK, user)
}
