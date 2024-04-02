package entity

import "gorm.io/gorm"

type Question struct {
	gorm.Model
	Id              int    `gorm:"column:id; PRIMARY_KEY; unique"`
	Text            string `gorm:"column:text"`
	A               string `gorm:"column:A"`
	B               string `gorm:"column:B"`
	C               string `gorm:"column:C"`
	D               string `gorm:"column:D"`
	Answer          string `gorm:"column:answer"`
	DifficultyLevel string `gorm:"column:difficulty_level"`
	TotalTryNum     int    `gorm:"column:total_try_num"`
	CorrectTryNum   int    `gorm:"column:correct_try_num"`
	ConsumingTime   int    `gorm:"column:consuming_time"`
}

type SelectedQuestionInfo struct {
	Id            int    `json:"Id"`
	Text          string `json:"Text"`
	A             string `json:"A"`
	B             string `json:"B"`
	C             string `json:"C"`
	D             string `json:"D"`
	Answer        string `json:"Answer"`
	ConsumingTime int    `json:"ConsumingTime"`
}
