package dao

import (
	"fmt"
	"logic_app_backend/entity"
)

func GetAllQuestionsInfo() []entity.QuestionsDI {

	var questions []entity.Question
	DB.Find(&questions)
	var questionDI []entity.QuestionsDI

	for i := 0; i < len(questions); i++ {
		if questions[i].TotalTryNum == 0 {
			questionDI = append(questionDI, entity.QuestionsDI{questions[i],
				0.25,
				0})
		} else {
			questionDI = append(questionDI, entity.QuestionsDI{questions[i],
				float32(questions[i].CorrectTryNum) / float32(questions[i].TotalTryNum),
				float32(questions[i].ConsumingTime) / float32(questions[i].TotalTryNum),
			})
		}
	}

	return questionDI
}

func CreateQuestion(question entity.Question) string {
	result := DB.Create(&question)
	if result.Error != nil {
		fmt.Println(result.Error.Error())
		return result.Error.Error()
	} else {
		return "successfully created"
	}
}

func DeleteQuestion(id string) string {
	// Must Hard Delete here!
	DB.Unscoped().Delete(&entity.Question{}, id)
	//DB.Delete(&entity.Question{}, id)
	return "The question id=" + id + " has been success deleted!" //空格？
}
