class UserScore {

  late String username;
  late String password;

  late int totalAttemptsE;
  late int totalConsumingTimeE;
  late int totalScoresE;

  late int totalAttemptsM;
  late int totalConsumingTimeM;
  late int totalScoresM;

  late int totalAttemptsH;
  late int totalConsumingTimeH;
  late int totalScoresH;

  UserScore(this.username,this.totalAttemptsE,this.totalConsumingTimeE,this.totalScoresE,
      this.totalAttemptsM, this.totalConsumingTimeM, this.totalScoresM, this.totalAttemptsH, this.totalConsumingTimeH,
      this.totalScoresH);

  factory UserScore.fromJson(Map<String, dynamic> json) {
    return UserScore(
      json['Username'],
      json['TotalAttemptsE'],
      json['TotalConsumingTimeE'],
      json['TotalScoresE'],
      json['TotalAttemptsM'],
      json['TotalConsumingTimeM'],
      json['TotalScoresM'],
      json['TotalAttemptsH'],
      json['TotalConsumingTimeH'],
      json['TotalScoresH'],
    );
  }

}