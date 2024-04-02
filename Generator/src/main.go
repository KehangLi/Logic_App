package main

import (
	"controller"
	"dao"
)

func main() {

	dao.InitMySQL()

	controller.GeneratorMedium(dao.GetNumMedium())
	controller.GeneratorHard(dao.GetNumHard())

}
