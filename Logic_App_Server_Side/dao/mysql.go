package dao

import (
	"fmt"
	"gopkg.in/yaml.v3"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"io/ioutil"
	"logic_app_backend/entity"
)

var (
	DB *gorm.DB
)

func InitMySQL() {

	// ref:https://blog.csdn.net/weixin_34315189/article/details/91568929?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-1-91568929-blog-132699348.235^v43^pc_blog_bottom_relevance_base2&spm=1001.2101.3001.4242.2&utm_relevant_index=2
	configFile, err := ioutil.ReadFile("conf.yaml")
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

	exist := DB.Migrator().HasTable("users")
	if !exist {
		DB.AutoMigrate(&entity.User{})
	}

}

func GetPort() string {

	configFile, err := ioutil.ReadFile("conf.yaml")
	if err != nil {
		fmt.Println(err.Error())
	}
	var configuration map[string]map[string]interface{}
	err = yaml.Unmarshal(configFile, &configuration)
	port := ":" + fmt.Sprintf("%v", configuration["Serverside"]["Port"])
	return port

}
