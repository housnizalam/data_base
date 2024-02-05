import 'dart:convert';
import 'package:data_base/logics/globals.dart';
import 'package:http/http.dart' as http;
import 'package:data_base/logics/teams_class.dart';

class AppState {
  static Future<String> getAllTeams({String? condition}) async {
    try {
      var response = await http.post(
        Uri.parse(getTeamsUrl),
        body: jsonEncode({'condition': condition}),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error: $e');
    }
    return '';
  }

  static Future addTeam(Map<String, dynamic> body) async {
    try {
      var request = await http.post(
        Uri.parse(addTeamUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (request.statusCode == 200) {
        print('success');
        print(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future editTeam(Map<String, dynamic> body) async {
    try {
      var request = await http.post(
        Uri.parse(editTeamUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (request.statusCode == 200) {
        print('success');
        print(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future deleteTeam(Map<String, dynamic> body) async {
    try {
      var request = await http.post(
        Uri.parse(deleteTeamUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (request.statusCode == 200) {
        print('success');
        print(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<List<Team>> get teams async {
    List<Team> result = [];

    String response = await getAllTeams();

    // Updated this line to explicitly cast to List<dynamic>
    List<dynamic> responseList = json.decode(response);

    // Updated this line to use List<Map<String, dynamic>>
    List<Map<String, dynamic>> responseBody = List<Map<String, dynamic>>.from(responseList);

    for (var responsMap in responseBody) {
      result.add(Team.fromJson(responsMap));
    }
    return result;
  }
}





  // static void fromJson(Map<String, dynamic> json) {
  //   teams = (json['teams'] as List<dynamic>).map((teamJson) => Team.fromJson(teamJson)).toList();
  // }

  // static List<Team> generateRandomTeams(int count) {
  //   List<Team> teams = [];

  //   for (int i = 1; i <= count; i++) {
  //     Team team = Team(
  //       id: i,
  //       name: "Team $i",
  //       points: Random().nextInt(100),
  //       goalsFor: Random().nextInt(100),
  //       goalsAgainst: Random().nextInt(100),
  //       goalsDifference: Random().nextInt(100),
  //       players: [],
  //     );

  //     teams.add(team);
  //   }

  //   return teams;
  // }

// import 'package:data_base/logics/teams_class.dart';

// class Appstate {
//   List<Team> teams;

//   Appstate({
//     required this.teams,
//   });

//   factory Appstate.fromJson(Map<String, dynamic> json) {
//     return Appstate(
//       teams: (json['teams'] as List<dynamic>).map((teamJson) => Team.fromJson(teamJson)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'teams': teams.map((team) => team.toJson()).toList(),
//     };
//   }

//   List<Team> get pointsSortiert {
//     List<Team> sortedList = [...teams];
//     sortedList.sort((a, b) => a.points.compareTo(b.points));
//     return sortedList;
//   }
// }



















// import 'package:data_base/logics/teams_class.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final teamsProvider = StateNotifierProvider<TeamsNotifier, List<Team>>((ref) {
//   return TeamsNotifier();
// });

// class TeamsNotifier extends StateNotifier<List<Team>> {
//   TeamsNotifier() : super([]);

//   // You can add methods to modify the state, for example, fetching teams from an API.
// }

// final selectedTeamProvider = StateProvider<Team?>((ref) => null);