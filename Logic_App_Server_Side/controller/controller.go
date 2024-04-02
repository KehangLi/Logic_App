package controller

import (
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"logic_app_backend/dao"
	"logic_app_backend/entity"
	"logic_app_backend/util"
	"math/rand"
	"net/http"
	"strconv"
	"strings"
	"sync"
	"time"
)

func Registration(r *gin.Engine) {
	r.POST("/registration", func(context *gin.Context) {
		var newUser entity.User

		// Bind the JSON data from the request body
		if err := context.BindJSON(&newUser); err != nil {
			context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		// Check if the username already exists in the database
		var existingUser entity.User
		result := dao.DB.Where("username = ?", newUser.Username).First(&existingUser)
		if result.RowsAffected > 0 {
			context.JSON(http.StatusConflict, gin.H{"message": "Username already exists,please change or go to login"})
			fmt.Println("already exists")
			return
		}

		// Encrypt
		key := "1999082772809991"
		newUserPassword, err := util.Encrypt(key, newUser.Password)
		if err != nil {
			fmt.Println("Encryption error:", err)
			return
		}
		newUser.Password = newUserPassword

		//if the userName is unique, save it to database
		dao.DB.Create(&newUser)
		fmt.Printf("Username: %s, Password: %s\n", newUser.Username, newUser.Password)

		context.JSON(http.StatusOK, gin.H{"message": "User registered successfully"})
	})

}

func Login(r *gin.Engine) {
	r.POST("/login", func(context *gin.Context) {
		var loginUser entity.User

		if err := context.BindJSON(&loginUser); err != nil {
			context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		var registeredUser entity.User
		// Check if the username exists in the database
		result := dao.DB.Where("username = ?", loginUser.Username).First(&registeredUser)
		if result.RowsAffected == 0 {
			context.JSON(http.StatusNotFound, gin.H{"message": "User not found, please register"})
			return
		}

		// decryption
		key := "1999082772809991"
		deCryptPassword, err := util.Decrypt(key, registeredUser.Password)
		if err != nil {
			fmt.Println("Decryption error:", err)
			return
		}
		registeredUser.Password = deCryptPassword

		// check if the passwords match?
		if registeredUser.Password != loginUser.Password {
			context.JSON(http.StatusUnauthorized, gin.H{"message": "Invalid password"})
			return
		}

		context.JSON(http.StatusOK, gin.H{"message": "Login successful"})

	})
}

// get corresponding Questions
func GetQuestions(r *gin.Engine) {

	r.GET("/getQuestion/:difficulty", func(context *gin.Context) {

		level := context.Param("difficulty")
		var questions []entity.Question
		rand.Seed(time.Now().UnixNano())

		//  Easy, Medium or Difficulty?
		if level == "Easy" {
			dao.DB.Raw("SELECT * FROM questions WHERE difficulty_level = 'Easy' ORDER BY RAND() LIMIT 10").Scan(&questions)
		} else if level == "Medium" {
			dao.DB.Raw("SELECT * FROM questions WHERE difficulty_level = 'Medium' ORDER BY RAND() LIMIT 10").Scan(&questions)
		} else {
			dao.DB.Raw("SELECT * FROM questions WHERE difficulty_level = 'Hard' ORDER BY RAND() LIMIT 10").Scan(&questions)
		}

		var selectedQuestions []entity.SelectedQuestionInfo
		for _, q := range questions {
			selectedInfo := entity.SelectedQuestionInfo{
				Id:            q.Id,
				Text:          q.Text,
				A:             q.A,
				B:             q.B,
				C:             q.C,
				D:             q.D,
				Answer:        q.Answer,
				ConsumingTime: q.ConsumingTime,
			}
			selectedQuestions = append(selectedQuestions, selectedInfo)
		}
		data, _ := json.Marshal(selectedQuestions)
		fmt.Println(string(data))
		context.JSON(http.StatusOK, gin.H{
			"code":    http.StatusOK,
			"message": string(data),
		})
	})
}

// because my two post requests, operate same data table and same column at the same time
// so, i choose MutexLock to solve this problem.
var (
	mutex sync.Mutex
)

// check answer and also write it into corresponding user
func CheckAnswers(r *gin.Engine) {
	r.POST("/sendAnswer/:Username/:Level", func(context *gin.Context) {

		Username := context.Param("Username")
		Level := context.Param("Level")

		// Acquire lock
		mutex.Lock()
		defer mutex.Unlock()

		type Answers struct {
			ID             int    `json:"Id"`
			SelectedAnswer string `json:"SelectedAnswer"`
			//ConsumingTime  int    `json:"ConsumingTime"`
		}

		var answers []Answers
		var user entity.User

		// Find the user in the database
		if err := dao.DB.Where("username = ?", Username).First(&user).Error; err != nil {
			context.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
			return
		}

		if err := context.BindJSON(&answers); err != nil {
			// Handle error if any
			context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		for _, ans := range answers {
			//fmt.Printf("ID: %d, Selected Answer: %s\n", ans.ID, ans.SelectedAnswer)
			var question entity.Question

			if err := dao.DB.Where("id = ?", ans.ID).First(&question).Error; err != nil {
				context.JSON(http.StatusNotFound, gin.H{"error": "Question not found"})
				return
			}
			if ans.SelectedAnswer == question.Answer {

				question.TotalTryNum++
				question.CorrectTryNum++

				if Level == "Easy" {
					user.TotalAttemptsE++
					user.TotalScoresE++
				} else if Level == "Medium" {
					user.TotalAttemptsM++
					user.TotalScoresM++
				} else {
					user.TotalAttemptsH++
					user.TotalScoresH++
				}

			} else {
				question.TotalTryNum++

				if Level == "Easy" {
					user.TotalAttemptsE++
				} else if Level == "Medium" {
					user.TotalAttemptsM++
				} else {
					user.TotalAttemptsH++
				}

			}

			if err := dao.DB.Save(&question).Error; err != nil {
				context.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update Info in question DB"})
				return
			}

		}

		if err := dao.DB.Save(&user).Error; err != nil {
			context.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update Info in user DB"})
			return
		}

		context.JSON(http.StatusOK, gin.H{"message": "Answers received successfully"})
	})
}

func SendConsumingTime(r *gin.Engine) {
	r.POST("/sendConsumingTime/:Username/:Level", func(context *gin.Context) {

		Username := context.Param("Username")
		Level := context.Param("Level")

		// Acquire lock
		mutex.Lock()
		defer mutex.Unlock()

		type CTime struct {
			ID            int `json:"Id"`
			ConsumingTime int `json:"ConsumingTime"`
		}

		var user = entity.User{}

		// Find the user in the database
		if err := dao.DB.Where("username = ?", Username).First(&user).Error; err != nil {
			context.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
			return
		}

		//creat slice
		var consumingTime []CTime

		if err := context.BindJSON(&consumingTime); err != nil {
			context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		for _, t := range consumingTime {
			//fmt.Printf("ID: %d, Selected Answer: %s\n", ans.ID, ans.SelectedAnswer)
			var question entity.Question

			if err := dao.DB.Where("id = ?", t.ID).First(&question).Error; err != nil {
				context.JSON(http.StatusNotFound, gin.H{"error": "Question not found"})
				return
			}
			question.ConsumingTime = question.ConsumingTime + t.ConsumingTime

			if Level == "Easy" {
				user.TotalConsumingTimeE = user.TotalConsumingTimeE + t.ConsumingTime
			} else if Level == "Medium" {
				user.TotalConsumingTimeM = user.TotalConsumingTimeM + t.ConsumingTime
			} else {
				user.TotalConsumingTimeH = user.TotalConsumingTimeH + t.ConsumingTime
			}

			//Update the question in the database
			if err := dao.DB.Save(&question).Error; err != nil {
				context.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update Info in DB"})
				return
			}
		}

		//fmt.Println(user.TotalConsumingTimeM)

		if err := dao.DB.Save(&user).Error; err != nil {
			context.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update Info in User DB"})
			return
		}

		//response
		context.JSON(http.StatusOK, gin.H{"message": "Info received successfully"})
	})
}

// get high score table
func GetScoreTable(r *gin.Engine) {
	r.GET("/getHighScoreTable", func(context *gin.Context) {

		type ScoreTable struct {
			Username            string `json:"Username"`
			TotalAttemptsE      int    `json:"TotalAttemptsE"`
			TotalConsumingTimeE int    `json:"TotalConsumingTimeE"`
			TotalScoresE        int    `json:"TotalScoresE"`
			TotalAttemptsM      int    `json:"TotalAttemptsM"`
			TotalConsumingTimeM int    `json:"TotalConsumingTimeM"`
			TotalScoresM        int    `json:"TotalScoresM"`
			TotalAttemptsH      int    `json:"TotalAttemptsH"`
			TotalConsumingTimeH int    `json:"TotalConsumingTimeH"`
			TotalScoresH        int    `json:"TotalScoresH"`
		}

		var AllUserInfo []ScoreTable
		var UsersInfoDB []entity.User
		// get all records
		dao.DB.Find(&UsersInfoDB)

		for _, info := range UsersInfoDB {
			eachUserInfo := ScoreTable{
				Username:            info.Username,
				TotalAttemptsE:      info.TotalAttemptsE,
				TotalConsumingTimeE: info.TotalConsumingTimeE,
				TotalScoresE:        info.TotalScoresE,
				TotalAttemptsM:      info.TotalAttemptsM,
				TotalConsumingTimeM: info.TotalConsumingTimeM,
				TotalScoresM:        info.TotalScoresM,
				TotalAttemptsH:      info.TotalAttemptsH,
				TotalConsumingTimeH: info.TotalConsumingTimeH,
				TotalScoresH:        info.TotalScoresH,
			}
			AllUserInfo = append(AllUserInfo, eachUserInfo)
		}

		data, _ := json.Marshal(AllUserInfo)
		fmt.Println(string(data))
		context.JSON(http.StatusOK, gin.H{
			"code":    http.StatusOK,
			"message": string(data),
		})

	})
}

func ManageQuestions(r *gin.Engine) {

	r.GET("/admin/questions", func(c *gin.Context) {

		var Port = dao.GetPort()
		Port = strings.TrimLeft(Port, ":")
		fmt.Println(Port)

		allQuestions := dao.GetAllQuestionsInfo()
		c.HTML(http.StatusOK, "admin_questions.html", gin.H{
			"questions": allQuestions,
			"port":      Port,
		})
	})

}

func CreateQuestion(ginServer *gin.Engine) {
	ginServer.POST("/createQuestion", func(context *gin.Context) {
		id, _ := strconv.Atoi(context.PostForm("ID"))
		questionText := context.PostForm("questionText")
		answerA := context.PostForm("answerA")
		answerB := context.PostForm("answerB")
		answerC := context.PostForm("answerC")
		answerD := context.PostForm("answerD")
		correctAnswer := context.PostForm("correctAnswer")
		difficultyLevel := context.PostForm("difficultyLevel")
		totalTryNum, _ := strconv.Atoi(context.PostForm("totalTryNum"))
		correctTryNum, _ := strconv.Atoi(context.PostForm("correctTryNum"))
		totalTime, _ := strconv.Atoi(context.PostForm("totalTime"))
		question := entity.Question{
			Id:              id,
			Text:            questionText,
			A:               answerA,
			B:               answerB,
			C:               answerC,
			D:               answerD,
			Answer:          correctAnswer,
			DifficultyLevel: difficultyLevel,
			TotalTryNum:     totalTryNum,
			CorrectTryNum:   correctTryNum,
			ConsumingTime:   totalTime,
		}
		fmt.Println(question.DifficultyLevel)
		var existingQuestion = new(entity.Question)
		resultCheck := dao.DB.Where("text = ?", question.Text).Find(&existingQuestion)
		if resultCheck.RowsAffected != 0 {
			context.JSON(http.StatusOK, gin.H{"result": "Repeated Question!"})
		} else {
			result := dao.CreateQuestion(question)
			context.JSON(http.StatusOK, gin.H{"result": result})
		}

	})
}

func DeleteQuestion(ginServer *gin.Engine) {
	ginServer.GET("/admin/deleteQuestion/:id", func(context *gin.Context) {
		id := context.Param("id")
		fmt.Println(dao.DeleteQuestion(id))
		context.JSON(http.StatusOK, gin.H{"result": "deleted"})
	})
}

func ManegeUsers(r *gin.Engine) {
	r.GET("/admin/users", func(c *gin.Context) {

		var Port = dao.GetPort()
		Port = strings.TrimLeft(Port, ":")
		fmt.Println(Port)

		getAllUsers := dao.GetAllUsers()
		c.HTML(http.StatusOK, "admin_users.html", gin.H{
			"users": getAllUsers,
			"port":  Port,
		})
	})

}

func DeleteUsers(r *gin.Engine) {
	r.GET("/admin/deleteUser/:user", func(c *gin.Context) {
		user := c.Param("user")
		dao.DeleteUser(user)
		c.JSON(http.StatusOK, gin.H{"result": "deleted"})
	})
}

func ResetPassword(ginServer *gin.Engine) {
	ginServer.GET("/resetPassword/:user/:password", func(context *gin.Context) {
		user := context.Param("user")
		password := context.Param("password")

		// encrypt
		key := "1999082772809991"
		password, err := util.Encrypt(key, password)
		if err != nil {
			fmt.Println("Encryption error:", err)
			return
		}

		dao.ResetPassword(user, password)
		context.JSON(http.StatusOK, gin.H{"result": "reseted"})
	})
}
