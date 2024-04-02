package dao

import (
	"logic_app_backend/entity"
)

func GetAllUsers() []entity.User {
	var users []entity.User
	DB.Find(&users)
	return users
}

func DeleteUser(user string) string {
	//Hard Delete!
	DB.Unscoped().Delete(&entity.User{}, "username = ?", user)
	return "The User:" + user + "has been deleted!"
}

func ResetPassword(user string, password string) string {

	DB.Model(&entity.User{}).Where("username = ?", user).Update("password", password)
	return "The Password of" + user + "has been rested!"

}
