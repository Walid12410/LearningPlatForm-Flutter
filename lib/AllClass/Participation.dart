class Participation {
  int parID;
  DateTime? parDate;
  double paidAmount;
  int userID;
  int fullPlatform;
  DateTime? expDate;

  Participation(
      {required this.parID,
      required this.parDate,
      required this.paidAmount,
      required this.userID,
      required this.fullPlatform,
      required this.expDate});

  factory Participation.fromJson(Map<String, dynamic> json) {
    return Participation(
      parID: json['ParID'] ?? 0,
      parDate: json['ParDate'] != null ? DateTime.parse(json['ParDate']['date']) : null,
      paidAmount: double.parse(json['PaidAmount']),
      userID: json['TraineeID'] ?? 0,
      fullPlatform: json['FullPlatform'] ?? 0,
      expDate: json['ExpDate'] != null ? DateTime.parse(json['ExpDate']['date']) : null,
    );
  }
}
