package entity

import "gorm.io/gorm"

type User struct {
	gorm.Model
	Username string `gorm:"varchar(20);not null;unique"`
	Password string `gorm:"varchar(20);not null"`

	TotalAttemptsE      int `gorm:"column:total_attempts_E"`
	TotalConsumingTimeE int `gorm:"column:total_consuming_time_E"`
	TotalScoresE        int `gorm:"column:total_scores_E"`

	TotalAttemptsM      int `gorm:"column:total_attempts_M"`
	TotalConsumingTimeM int `gorm:"column:total_consuming_time_M"`
	TotalScoresM        int `gorm:"column:total_scores_M"`

	TotalAttemptsH      int `gorm:"column:total_attempts_H"`
	TotalConsumingTimeH int `gorm:"column:total_consuming_time_H"`
	TotalScoresH        int `gorm:"column:total_scores_H"`
}
