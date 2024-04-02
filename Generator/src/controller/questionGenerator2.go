package controller

import (
	"dao"
	"entity"
	"math/rand"
	"time"
)

func GeneratorM() {

	rand.Seed(time.Now().UnixNano())

	var t = rand.Intn(4)
	if t == 0 {
		commutativityGenerator()
	} else if t == 1 {
		associativityGenerator()
	} else if t == 2 {
		distributivityGenerator()
	} else {
		demorganGenerator()
	}
}

// Commutativity:  x ∗ y = y ∗ x, ∀ ∗ ∈ ∧, ∨, ⊕, ↔, ↑, ↓
func commutativityGenerator() {

	rand.Seed(time.Now().UnixNano())

	var symbolSlice = []string{"A", "B", "C", "D", "E", "F", "G", "P", "Q", "M", "N", "R"}
	var connectivesSlices = []string{"∧", "∨", "↔", "⊕", "↑", "↓"}
	var negativeSlice = []string{"", "¬"}
	var choiceSlice = []string{}

	s1 := rand.Intn(11)
	s2 := rand.Intn(11)
	for {
		if s1 == s2 {
			s2 = rand.Intn(11)
		} else {
			break
		}
	}

	// too guarantee all the connectivesSlices are not reapted
	randomInteger := []int{0, 1, 2, 3, 4, 5}
	rand.Shuffle(len(randomInteger), func(i, j int) {
		randomInteger[i], randomInteger[j] = randomInteger[j], randomInteger[i]
	})
	c := randomInteger[4]

	// creat correct answer
	var Text = "which of following formula is equivalent to " + symbolSlice[s1] + " " + connectivesSlices[c] + " " + symbolSlice[s2] + "?"
	var answer = symbolSlice[s2] + " " + connectivesSlices[c] + " " + symbolSlice[s1]
	choiceSlice = append(choiceSlice, answer)

	//creat three incorrect answer
	for t := 0; t < 3; t++ {
		c2 := randomInteger[t]
		rank := rand.Intn(1)
		if rank == 0 {
			neg := rand.Intn(2)
			choices := negativeSlice[neg] + symbolSlice[s2] + " " + connectivesSlices[c2] + " " + symbolSlice[s1]
			choiceSlice = append(choiceSlice, choices)
		} else {
			neg := rand.Intn(2)
			choices := negativeSlice[neg] + symbolSlice[s1] + " " + connectivesSlices[c2] + " " + symbolSlice[s2]
			choiceSlice = append(choiceSlice, choices)
		}
	}

	saveToQuestion(Text, choiceSlice)

}

// Associativity  (x ∗ y) ∗ z = x ∗ (y ∗ z), ∀ ∗ ∈ ∧, ∨, ⊕, ↔ .
func associativityGenerator() {
	var symbolSlice = []string{"A", "B", "C", "D", "E", "F", "G", "P", "Q", "M", "N", "R"}
	var connectivesSlices = []string{"∧", "∨", "↔", "⊕"}
	var negativeSlice = []string{"", " ¬"}
	var choiceSlice = []string{}

	// random select three capital
	rand.Shuffle(len(symbolSlice), func(i, j int) {
		symbolSlice[i], symbolSlice[j] = symbolSlice[j], symbolSlice[i]
	})
	s1 := symbolSlice[0]
	s2 := symbolSlice[1]
	s3 := symbolSlice[2]

	//random select two connectivesSlices
	rand.Shuffle(len(connectivesSlices), func(i, j int) {
		connectivesSlices[i], connectivesSlices[j] = connectivesSlices[j], connectivesSlices[i]
	})
	c1 := connectivesSlices[0]
	c2 := connectivesSlices[1]
	c3 := connectivesSlices[2]
	c4 := connectivesSlices[3]

	QuestionText := "Which of following formulas is equivalent to " + "( " + s1 + " " + c1 + " " + s2 + " ) " +
		c2 + " " + s3 + " ?"
	Answer := s1 + " " + c1 + " (" + s2 + " " + c2 + " " + s3 + " )"
	//choiceSlice = append(choiceSlice, Answer)

	// then creat incorrect answer
	incorrectAnswer1 := "( " + s1 + " " + c1 + " " + s2 + " ) " + c3 + " " + s3
	incorrectAnswer2 := s1 + " " + c4 + " (" + s2 + " " + c2 + " " + s3 + " )"
	incorrectAnswer3 := "( " + s1 + " " + c1 + " " + s2 + " ) " + c2 + negativeSlice[1] + s3
	choiceSlice = append(choiceSlice, Answer, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3)

	saveToQuestion(QuestionText, choiceSlice)
}

// De Morgan's laws    ¬ (x ∧ y) = ¬x ∨ ¬y;  ¬ (x ∨ y) = ¬x ∧ ¬y;
func demorganGenerator() {
	var symbolSlice = []string{"A", "B", "C", "D", "E", "F", "G", "P", "Q", "M", "N", "R"}
	var connectivesSlices = []string{"¬", "∧", "∨"}
	var connectivesSlices2 = []string{"→", "↔", "⊕", "↑", "↓"}
	var choiceSlice = []string{}

	// random select three capital
	rand.Shuffle(len(symbolSlice), func(i, j int) {
		symbolSlice[i], symbolSlice[j] = symbolSlice[j], symbolSlice[i]
	})
	s1 := symbolSlice[0]
	s2 := symbolSlice[1]

	randNum := rand.Intn(2)
	if randNum == 0 {
		//¬ (x ∧ y) = ¬x ∨ ¬y
		Text := "Which of following formulas is equivalent to " + "¬" + "( " + s1 + " " + connectivesSlices[1] + " " +
			s2 + " )"
		Answer := "¬" + s1 + " " + connectivesSlices[2] + " " + "¬" + s2
		incorrectAnswer1 := s1 + " " + connectivesSlices[2] + " " + "¬" + s2
		incorrectAnswer2 := s1 + " " + connectivesSlices2[rand.Intn(5)] + " " + "¬" + s2
		incorrectAnswer3 := "¬" + s1 + " " + connectivesSlices2[rand.Intn(5)] + " " + "¬" + s2
		choiceSlice = append(choiceSlice, Answer, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3)
		saveToQuestion(Text, choiceSlice)
	} else {
		// ¬ (x ∨ y) = ¬x ∧ ¬y;
		Text := "Which of following formulas is equivalent to " + "¬" + "( " + s1 + " " + connectivesSlices[2] + " " +
			s2 + " )"
		Answer := "¬" + s1 + " " + connectivesSlices[1] + " " + "¬" + s2
		incorrectAnswer1 := s1 + " " + connectivesSlices[1] + " " + "¬" + s2
		incorrectAnswer2 := "¬" + s1 + " " + connectivesSlices2[rand.Intn(5)] + " " + "¬" + s2
		incorrectAnswer3 := s1 + " " + connectivesSlices[1] + " " + s2
		choiceSlice = append(choiceSlice, Answer, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3)
		saveToQuestion(Text, choiceSlice)
	}

}

// distributivity
func distributivityGenerator() {

	var symbolSlice = []string{"A", "B", "C", "D", "E", "F", "G", "P", "Q", "M", "N", "R"}
	var connectivesSlices = []string{"∧", "∨", "⊕"}
	var connectivesSlices2 = []string{"↔", "↑", "↓"}
	var choiceSlice = []string{}

	// random select three capital
	rand.Shuffle(len(symbolSlice), func(i, j int) {
		symbolSlice[i], symbolSlice[j] = symbolSlice[j], symbolSlice[i]
	})
	s1 := symbolSlice[0]
	s2 := symbolSlice[1]
	s3 := symbolSlice[2]

	//confirm select two connectivesSlice
	c1 := connectivesSlices[0]
	c2 := connectivesSlices[1]
	c3 := connectivesSlices[2]

	t := rand.Intn(3)
	if t == 0 {
		Text := "Which of following formulas is equivalent to " +
			s1 + " " + c1 + " (" + s2 + " " + c2 + " " + s3 + " )?"
		Answer1 := "( " + s1 + " " + c1 + " " + s2 + " )" + " " + c2 + " " + "( " + s1 + " " + c1 + " " + s3 + " )"
		// incorrect answer
		incorrectAnswer1 := "¬( " + s1 + " " + c1 + " " + s2 + " )" + " " + c2 + " " + "( " + s1 + " " + c1 + " " + s3 + " )"
		incorrectAnswer2 := "¬( " + s1 + " " + c1 + " " + s2 + " )" + " " + connectivesSlices2[rand.Intn(3)] + " " + "( " + s1 + " " + c1 + " " + s3 + " )"
		incorrectAnswer3 := "¬( " + s1 + " " + connectivesSlices2[rand.Intn(3)] + " " + s2 + " )" + " " + c2 + " " + "( " + s1 + " " + connectivesSlices2[rand.Intn(3)] + " " + s3 + " )"
		choiceSlice = append(choiceSlice, Answer1, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3)
		saveToQuestion(Text, choiceSlice)
	} else if t == 1 {
		Text := "Which of following formulas is equivalent to " +
			s1 + " " + c2 + " (" + s2 + " " + c1 + " " + s3 + " )?"
		Answer := "( " + s1 + " " + c2 + " " + s2 + " )" + " " + c1 + " " + "( " + s1 + " " + c2 + " " + s3 + " )"
		incorrectAnswer1 := "( " + s1 + " " + c2 + " " + s2 + " )" + " " + c1 + " " + "¬( " + s1 + " " + c2 + " " + s3 + " )"
		incorrectAnswer2 := "( " + s1 + " " + c2 + " " + s2 + " )" + " " + connectivesSlices2[rand.Intn(3)] + " " + "( " + s1 + " " + c2 + " " + s3 + " )"
		incorrectAnswer3 := "( " + s1 + " " + connectivesSlices2[rand.Intn(3)] + " " + s2 + " )" + " " + c1 + " " + "( " + s1 + " " + connectivesSlices2[rand.Intn(3)] + " " + s3 + " )"
		choiceSlice = append(choiceSlice, Answer, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3)
		saveToQuestion(Text, choiceSlice)
	} else {
		Text := "Which of following formulas is equivalent to " +
			s1 + " " + c1 + " (" + s2 + " " + c3 + " " + s3 + " )?"
		Answer := "( " + s1 + " " + c1 + " " + s2 + " )" + " " + c3 + " " + "( " + s1 + " " + c1 + " " + s3 + " )"
		incorrectAnswer1 := "¬( " + s1 + " " + c1 + " " + s2 + " )" + " " + c3 + " " + "( " + s1 + " " + c1 + " " + s3 + " )"
		incorrectAnswer2 := "( " + s1 + " " + c1 + " " + s2 + " )" + " " + connectivesSlices2[rand.Intn(3)] + " " + "( " + s1 + " " + c1 + " " + s3 + " )"
		incorrectAnswer3 := "( " + s1 + " " + connectivesSlices2[rand.Intn(3)] + " " + s2 + " )" + " " + c3 + " " + "( " + s1 + " " + connectivesSlices2[rand.Intn(3)] + " " + s3 + " )"
		choiceSlice = append(choiceSlice, Answer, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3)
		saveToQuestion(Text, choiceSlice)
	}

}

func saveToQuestion(text string, choices []string) {

	question := new(entity.Question)

	rand.Seed(time.Now().UnixNano())
	TrueAnswerloc := rand.Intn(4)
	switch TrueAnswerloc {
	case 0:
		question.Answer = "A"
		question.A = choices[0]
		question.B = choices[1]
		question.C = choices[2]
		question.D = choices[3]
	case 1:
		question.Answer = "B"
		question.A = choices[1]
		question.B = choices[0]
		question.C = choices[2]
		question.D = choices[3]
	case 2:
		question.Answer = "C"
		question.A = choices[1]
		question.B = choices[2]
		question.C = choices[0]
		question.D = choices[3]
	case 3:
		question.Answer = "D"
		question.A = choices[1]
		question.B = choices[2]
		question.C = choices[3]
		question.D = choices[0]
	}

	//fmt.Printf("Text:%v, A: %v, B: %v, C: %v, D: %v, Answer:%v", question.Text, question.A, question.B, question.C, question.D, question.Answer)
	question.Id = dao.GetLastId() + 1
	question.Text = text
	question.DifficultyLevel = "Medium"
	question.TotalTryNum = 0
	question.CorrectTryNum = 0
	question.ConsumingTime = 0

	// check whether this question exits
	var existingQuestion entity.Question
	result := dao.DB.Where("text = ?", question.Text).First(&existingQuestion)
	if result.RowsAffected != 0 {
		return
	} else {
		dao.DB.Create(&question)
	}

	dao.DB.Create(&question)
}
