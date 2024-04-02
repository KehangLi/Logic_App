package main

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"logic_app_backend/controller"
	"logic_app_backend/dao"
)

func main() {

	r := gin.Default()

	_ = r.SetTrustedProxies([]string{"127.0.0.1"})

	r.Use(cors.Default()) //middleware to enable Cross-Origin Request

	//load the html templates
	r.LoadHTMLGlob("templates/*")
	//define the path
	r.Static("/static", "./static")

	dao.InitMySQL()

	controller.Registration(r)
	controller.Login(r)

	controller.GetQuestions(r)
	controller.CheckAnswers(r)
	controller.SendConsumingTime(r)
	controller.GetScoreTable(r)

	controller.ManageQuestions(r)
	controller.CreateQuestion(r)
	controller.DeleteQuestion(r)

	controller.ManegeUsers(r)
	controller.DeleteUsers(r)
	controller.ResetPassword(r)

	r.Run(dao.GetPort())

}
