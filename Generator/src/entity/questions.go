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

// initial Easy Level
var InitialQuestions = []Question{

	Question{Id: 1, Text: "Which symbol represents logical conjunction (AND)?", A: "∧", B: "∨", C: "¬", D: "→",
		Answer: "A", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 2, Text: "What is the negation of the statement 'It is raining' ?", A: "It is not raining", B: "It is snowing",
		C: "It is sunny", D: "It is cloudy", Answer: "A", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 3, Text: "In propositional logic, what does the symbol '∨' represent?", A: "Logical conjunction (AND)", B: "Logical disjunction (OR)",
		C: "Logical negation (NOT)", D: "Implication (IF...THEN)", Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 4, Text: "What is the result of the statement 'p ∧ ¬p'?", A: "True", B: "False",
		C: "Undetermined", D: "Contradictory", Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 5, Text: "Which of the following is the contrapositive of the statement 'If it is raining, then the streets are wet'?", A: "If the streets are not wet, then it is not raining",
		B: "If it is not raining, then the streets are not wet", C: "If the streets are wet, then it is raining", D: "If it is raining, then the streets are not wet", Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 6, Text: "What is the result of the statement 'p ∧ ¬p'?", A: "True", B: "False",
		C: "Undetermined", D: "Contradictory", Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 7, Text: "What does 'p → q' represent in propositional logic?", A: "Logical conjunction (AND)", B: "Logical disjunction (OR)",
		C: "Implication (IF...THEN)", D: "Biconditional (IF AND ONLY IF)", Answer: "C", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 8, Text: "Which law states 'p ∧ (q ∨ r) ≡ (p ∧ q) ∨ (p ∧ r)'?", A: " Distributive Law", B: "De Morgan's Law",
		C: "Associative Law", D: "Commutative Law", Answer: "A", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 9, Text: "What is the inverse of the statement 'If it is sunny, then I go to the beach'?", A: "If I go to the beach, then it is sunny", B: "If it is not sunny, then I don't go to the beach",
		C: "If I don't go to the beach, then it is sunny", D: "If I go to the beach, then it is not sunny", Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{
		Id: 11, Text: "Which law states '(p ∨ q) ∧ (¬p ∨ r) ≡ (p ∨ q) ∧ (p ∨ r)'?",
		A: "Distributive Law", B: "De Morgan's Law",
		C: "Associative Law", D: "Commutative Law",
		Answer: "B", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 12, Text: "What is the contrapositive of the statement 'If it is snowing, then the roads are icy'?",
		A: "If the roads are not icy, then it is not snowing", B: "If it is not snowing, then the roads are not icy",
		C: "If the roads are icy, then it is snowing", D: "If it is snowing, then the roads are not icy",
		Answer: "A", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 13, Text: "Which logical connective represents exclusive disjunction?",
		A: "∧", B: "∨", C: "⊻", D: "→",
		Answer: "C", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 14, Text: "What is the inverse of the statement 'If it is Monday, then I have a meeting'?",
		A: "If I have a meeting, then it is not Monday", B: "If it is not Monday, then I don't have a meeting",
		C: "If I don't have a meeting, then it is Monday", D: "If I have a meeting, then it is Monday",
		Answer: "D", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 15, Text: "What is the result of the statement 'p ∨ p'?",
		A: "True", B: "False", C: "Undetermined", D: "Contradictory",
		Answer: "A", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 16, Text: "Which law states 'p ∨ (q ∧ r) ≡ (p ∨ q) ∧ (p ∨ r)'?",
		A: "Distributive Law", B: "De Morgan's Law", C: "Associative Law", D: "Commutative Law",
		Answer: "A", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 17, Text: "What is the converse of the statement 'If it is cold, then I wear a jacket'?",
		A: "If I wear a jacket, then it is cold", B: "If it is not cold, then I don't wear a jacket",
		C: "If I don't wear a jacket, then it is cold", D: "If it is cold, then I don't wear a jacket",
		Answer: "A", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 18, Text: "Which logical connective represents logical equivalence?",
		A: "∧", B: "∨", C: "↔", D: "→", Answer: "C",
		DifficultyLevel: "Easy",
		TotalTryNum:     0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id: 19, Text: "What is the truth value of 'p ∧ (q ∨ ¬q)'?",
		A: "True", B: "False",
		C: "Undetermined", D: "Contradictory",
		Answer: "A", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{
		Id:   20,
		Text: "Which law states 'p → q ≡ ¬p ∨ q'?",
		A:    "Distributive Law", B: "De Morgan's Law",
		C: "Law of Excluded Middle", D: "Law of Implication",
		Answer: "D", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0,
	},
	Question{Id: 21,
		Text: "What is the contrapositive of the statement 'If it is sunny, then I go for a walk'?",
		A:    "If I don't go for a walk, then it is sunny", B: "If it is not sunny, then I don't go for a walk",
		C: "If I go for a walk, then it is not sunny", D: "If it is sunny, then I don't go for a walk",
		Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 22, Text: "Which logical connective represents material implication?",
		A: "∧", B: "∨", C: "→", D: "↔", Answer: "C", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 23, Text: "What is the converse of the statement 'If it is summer, then it is hot'?",
		A: "If it is hot, then it is summer", B: "If it is not summer, then it is not hot",
		C: "If it is hot, then it is not summer", D: "If it is summer, then it is not hot",
		Answer: "C", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 24, Text: "Which law states 'p ∨ (¬p ∧ q) ≡ p ∨ q'?",
		A: "Idempotent Law", B: "Commutative Law", C: "Absorption Law", D: "Distributive Law",
		Answer: "C", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 25, Text: "What is the inverse of the statement 'If it is windy, then the trees sway'?",
		A: "If the trees sway, then it is not windy", B: "If it is not windy, then the trees don't sway",
		C: "If the trees don't sway, then it is windy", D: "If it is windy, then the trees don't sway",
		Answer: "B", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 26, Text: "Which logical connective represents logical biconditional?",
		A: "∧", B: "∨", C: "→", D: "↔", Answer: "D", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 27, Text: "What is the contrapositive of the statement 'If it is cold, then I wear a coat'?",
		A: "If I don't wear a coat, then it is cold", B: "If it is not cold, then I don't wear a coat",
		C: "If I wear a coat, then it is not cold", D: "If it is cold, then I don't wear a coat",
		Answer: "D", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 28, Text: "Which law states 'p ∨ (p ∧ q) ≡ p'?",
		A: "Idempotent Law", B: "Commutative Law", C: "Associative Law", D: "Distributive Law",
		Answer: "A", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 29, Text: "What is the converse of the statement 'If it is midnight, then it is dark'?",
		A: "If it is dark, then it is midnight", B: "If it is not midnight, then it is not dark",
		C: "If it is dark, then it is not midnight", D: "If it is midnight, then it is not dark",
		Answer: "C", DifficultyLevel: "Easy", TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
	Question{Id: 30, Text: "Which logical connective represents negation?",
		A: "∧", B: "∨", C: "¬", D: "→", Answer: "C", DifficultyLevel: "Easy",
		TotalTryNum: 0, CorrectTryNum: 0, ConsumingTime: 0},
}
