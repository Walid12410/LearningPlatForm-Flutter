class CourseTime{
  int totalMinutes;
  int totalSecond;

  CourseTime({
    required this.totalMinutes,
    required this.totalSecond
  });

  factory CourseTime.fromJson(Map<String,dynamic> json){
    return CourseTime(
        totalMinutes : json['TotalMinutes'],
        totalSecond : json['TotalSeconds']
    );
  }

  double getTotalHours() {
    double totalHours = (totalMinutes / 60) + (totalSecond / 3600);
    return double.parse(totalHours.toStringAsFixed(2));
  }


}