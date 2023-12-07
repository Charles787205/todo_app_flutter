import 'package:firebase_auth/firebase_auth.dart';

class Todo {
  String title, description, date, time, priority;
  bool isNotify;

  Todo({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.isNotify,
  });

  // Convert Todo object to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'priority': priority,
      'isNotify': isNotify,
    };
  }

  String getWeekDay() {
    var weekdays = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday"
    };
    return weekdays[DateTime.parse(date).weekday]!;
  }
}

class UserAdditionalInfo {
  //ing.ani nalang kaysa mag edit sa firebase
  String image, nickname;
  User? user;
  UserAdditionalInfo({required this.image, required this.nickname, this.user});

  static UserAdditionalInfo fromMap(Map<String, dynamic> map) {
    UserAdditionalInfo user =
        UserAdditionalInfo(image: map['image'], nickname: map['nickname']);

    return user;
  }
}
