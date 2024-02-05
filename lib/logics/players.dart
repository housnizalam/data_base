import 'package:data_base/logics/teams_class.dart';

class Player {
  int id;
  String name;
  int age;
  int power;
  int goals;
  int assists;
  Team team;

  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.power,
    required this.goals,
    required this.assists,
    required this.team,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      power: json['power'],
      goals: json['goals'],
      assists: json['assists'],
      team: Team.fromJson(json['team']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'power': power,
      'goals': goals,
      'assists': assists,
      'team': team.toJson(),
    };
  }
}
