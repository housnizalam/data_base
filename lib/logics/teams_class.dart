import 'package:data_base/logics/players.dart';

class Team {
  int? id;
  String name;
  int points;
  int goalsfor;
  int goalsagainst;
  int goalsdifference;
  List<Player>? players;

  Team({
     this.id,
    required this.name,
    required this.points,
    required this.goalsfor,
    required this.goalsagainst,
    required this.goalsdifference,
    this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: int.parse(json['id']),
      name: json['name'] ?? '',
      points: int.parse(json['points']),
      goalsfor: int.parse(json['goalsfor']),
      goalsagainst: int.parse(json['goalsagainst']),
      goalsdifference: int.parse(json['goalsdifference']),
      players: null,
      //  json['players'] == null
      //     ? []
      //     : (json['players'] as List<Map<String, dynamic>>).map((playerJson) => Player.fromJson(playerJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'points': points,
      'goalsfor': goalsfor,
      'goalsagainst': goalsagainst,
      'goalsdifference': goalsdifference,
      'players': '',
      //  players == null ? [] : players!.map((player) => player.toJson()).toList(),
    };
  }
}
