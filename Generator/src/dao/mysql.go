package dao

import (
	"entity"
	"fmt"
	"gopkg.in/yaml.v3"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"io/ioutil"
)

var (
	DB *gorm.DB
)

func InitMySQL() {

	configFile, err := ioutil.ReadFile("src/conf.yaml")
	if err != nil {
		fmt.Println(err.Error())
	}

	var config map[string]map[string]interface{}
	err = yaml.Unmarshal(configFile, &config)
	fmt.Println(config["Database"])

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		config["Database"]["Username"], config["Database"]["Password"], config["Database"]["Host"],
		config["Database"]["Port"], config["Database"]["DBName"])
	DB, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("Error:" + err.Error())
	}

	DB.AutoMigrate(&entity.Question{})
	DB.Create(&entity.InitialQuestions)

	//exist := DB.Migrator().HasTable("questions")
	//if exist {
	//	fmt.Println("This table already exist/n")
	//} else {
	//	DB.AutoMigrate(&entity.Question{})
	//	DB.Create(&entity.InitialQuestions)
	//}

}

func GetLastId() int {
	question := new(entity.Question)
	DB.Last(&question)
	lastID := question.Id
	return lastID
}

func GetNumMedium() int {

	configFile, err := ioutil.ReadFile("src/conf.yaml")
	if err != nil {
		fmt.Println(err.Error())
	}
	var configuration map[string]map[string]interface{}
	err = yaml.Unmarshal(configFile, &configuration)
	num := configuration["Generator"]["NumberOfMedium"].(int)
	return num

}

func GetNumHard() int {

	configFile, err := ioutil.ReadFile("src/conf.yaml")
	if err != nil {
		fmt.Println(err.Error())
	}
	var configuration map[string]map[string]interface{}
	err = yaml.Unmarshal(configFile, &configuration)
	num := configuration["Generator"]["NumberOfHard"].(int)
	return num

}
