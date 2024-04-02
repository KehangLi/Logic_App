package controller

import (
	"dao"
	"entity"
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

func GeneratorH() {

	question := new(entity.Question)

	//define symbol
	var symbolSlice = []string{"A", "B", "C", "D", "E", "F", "G", "P", "Q", "M", "N", "R"}
	var negativeSlice = []string{"", "¬"}
	var connectivesSlices = []string{"∧", "∨", "→", "↔", "⊕", "↑", "↓"}
	var bracket = []string{"(", ")", ""}
	var choiceSlices = []string{}

	rand.Seed(time.Now().UnixNano())

	//random Integer then true the value
	var t1 = rand.Intn(2)  // negative    0 -> ¬    1 -> /
	var t2 = rand.Intn(2)  // negative    0 -> ¬    1 -> /
	var s1 = rand.Intn(11) //symbol 1
	var s1T = rand.Intn(2) //truth value of s1     0 ->  false   1 ->  true
	var s2 = rand.Intn(11) // symbol 2
	for {
		if s1 == s2 {
			s2 = rand.Intn(7)
		} else {
			break
		}
	}
	var s2T = rand.Intn(2) //truth value of s2
	var c = rand.Intn(7)   //connectives
	var truthvalue = rand.Intn(2)

	//creat truth map
	truthMap := make(map[int]bool)
	truthMap[0] = false
	truthMap[1] = true
	s1T_s := strconv.FormatBool(truthMap[s1T])
	s2T_s := strconv.FormatBool(truthMap[s2T])
	truthvalue_s := strconv.FormatBool(truthMap[truthvalue])

	questionText := "Given that the Truth Value of" + " " + symbolSlice[s1] + " " + "is" + " " + s1T_s + " " +
		"and" + " " + symbolSlice[s2] + " " + "is" + " " + s2T_s + "," +
		"which of following formula' truth value is equal to " + truthvalue_s + "?"
	question.Text = questionText
	fmt.Println(questionText)

	//creat answer
	t1 = rand.Intn(2) // negative    0 -> ¬    1 -> /
	t2 = rand.Intn(2) // negative    0 -> ¬    1 -> /
	c = rand.Intn(7)  //connectives
	var choices = negativeSlice[t1] + symbolSlice[s1] + " " + connectivesSlices[c] + " " + negativeSlice[t2] + symbolSlice[s2]
	//fmt.Println(choices)
	var choice1Value = checkValue(t1, t2, s1T, s2T, c)
	//fmt.Println(choice1Value)

	if choice1Value == truthMap[truthvalue] {
		choiceSlices = append(choiceSlices, choices)
	} else {
		choices = negativeSlice[1] + "" + bracket[0] + choices + bracket[1]
		choiceSlices = append(choiceSlices, choices)
	}

	// creat three false choices
	for i := 0; i < 3; i++ {
		t1 = rand.Intn(2) // negative    0 -> ¬    1 -> /
		t2 = rand.Intn(2) // negative    0 -> ¬    1 -> /
		c = rand.Intn(7)  //connectives
		var choices = negativeSlice[t1] + symbolSlice[s1] + " " + connectivesSlices[c] + " " + negativeSlice[t2] + symbolSlice[s2]
		//fmt.Println(choices)
		var choice1Value = checkValue(t1, t2, s1T, s2T, c)
		//fmt.Println(choice1Value)

		if choice1Value != truthMap[truthvalue] {
			choiceSlices = append(choiceSlices, choices)
		} else {
			choices = negativeSlice[1] + "" + bracket[0] + choices + bracket[1]
			choiceSlices = append(choiceSlices, choices)
		}
	}

	// randomly give it to correct answer
	TrueAnswerloc := rand.Intn(4)
	switch TrueAnswerloc {
	case 0:
		question.Answer = "A"
		question.A = choiceSlices[0]
		question.B = choiceSlices[1]
		question.C = choiceSlices[2]
		question.D = choiceSlices[3]
	case 1:
		question.Answer = "B"
		question.A = choiceSlices[1]
		question.B = choiceSlices[0]
		question.C = choiceSlices[2]
		question.D = choiceSlices[3]
	case 2:
		question.Answer = "C"
		question.A = choiceSlices[1]
		question.B = choiceSlices[2]
		question.C = choiceSlices[0]
		question.D = choiceSlices[3]
	case 3:
		question.Answer = "D"
		question.A = choiceSlices[1]
		question.B = choiceSlices[2]
		question.C = choiceSlices[3]
		question.D = choiceSlices[0]
	}

	//fmt.Printf("Questions:%v, A: %v, B: %v, C: %v, D: %v, Answer:%v", question.Text, question.A, question.B, question.C, question.D, question.Answer)
	//then assign value to instance
	question.Id = dao.GetLastId() + 1
	question.DifficultyLevel = "Hard"
	question.TotalTryNum = 0
	question.CorrectTryNum = 0
	question.ConsumingTime = 0

	var existingQuestion entity.Question
	result := dao.DB.Where("text = ?", question.Text).First(&existingQuestion)
	if result.RowsAffected != 0 {
		return
	} else {
		dao.DB.Create(&question)
	}

}

// check the truth value
func checkValue(t1 int, t2 int, s1T int, s2T int, c int) (t bool) {
	var atomic1 bool
	var atomic2 bool
	var result bool

	if t1 == 0 && s1T == 0 {
		atomic1 = false
	} else if t2 == 1 && s2T == 1 {
		atomic1 = false
	} else {
		atomic1 = true
	}

	if t1 == 0 && s1T == 1 {
		atomic2 = true
	} else if t2 == 1 && s2T == 0 {
		atomic2 = true
	} else {
		atomic2 = false
	}

	//  connectives "∧", "∨", "→", "↔", "⊕", "↑", "↓"
	if c == 0 {
		if atomic1 == atomic2 == true {
			result = true
		} else {
			result = false
		}
	} else if c == 1 {
		if atomic1 == atomic2 == false {
			result = false
		} else {
			result = true
		}
	} else if c == 2 {
		if atomic1 == true && atomic2 == false {
			result = false
		} else {
			result = true
		}
	} else if c == 3 {
		if atomic1 == atomic2 {
			result = true
		} else {
			result = false
		}
	} else if c == 4 {
		if atomic1 == atomic2 {
			result = false
		} else {
			result = true
		}
	} else if c == 5 {
		if atomic1 == atomic2 == true {
			result = false
		} else {
			result = true
		}
	} else if c == 6 {
		if atomic1 == atomic2 == false {
			result = true
		} else {
			result = false
		}
	}

	return result

}
