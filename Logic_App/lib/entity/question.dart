class TestQuestions {
  late int Id;
  late String Text;
  late String A;
  late String B;
  late String C;
  late String D;
  late String Answer;
  late int ConsumingTime;

  TestQuestions(this.Id,this.Text,this.A,this.B,this.C,this.D,this.Answer,this.ConsumingTime);

  factory TestQuestions.fromJson(Map<String, dynamic> json) {
    return TestQuestions(
      json['Id'],
      json['Text'],
      json['A'],
      json['B'],
      json['C'],
      json['D'],
      json['Answer'],
      json['ConsumingTime'],
    );
  }

}

