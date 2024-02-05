import 'package:amazing_tools/tools/animated_navigator.dart';
import 'package:data_base/logics/appstate.dart';
import 'package:data_base/logics/globals.dart';
import 'package:data_base/logics/teams_class.dart';
import 'package:data_base/widgets/edit_team.dart';
import 'package:flutter/material.dart';

class TeamsList extends StatefulWidget {
  const TeamsList({Key? key}) : super(key: key);

  @override
  State<TeamsList> createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TextEditingController name = TextEditingController();
  TextEditingController points = TextEditingController(text: '0');
  TextEditingController goalsfor = TextEditingController(text: '0');
  TextEditingController goalsagainst = TextEditingController(text: '0');
  double width = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _addTeam();
          setState(() {
            // isComplete = false;
            width = width == 0 ? 500 : 0;
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text('Teams list'),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: FutureBuilder(
              future: AppState.teams,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Zeige einen Ladeindikator, während die Daten geladen werden
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Zeige eine Fehlermeldung, wenn ein Fehler auftritt
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Zeige die Liste der Teams, wenn die Daten verfügbar sind
                  teams = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 200,
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'name',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'points',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: AnimatedList(
                            key: _listKey,
                            initialItemCount: teams.length,
                            itemBuilder: (context, index, animation) {
                              return _buildAnimatedListItem(index, animation);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          AnimatedContainer(
              color: Colors.white,
              duration: Duration(milliseconds: 500),
              width: width,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(labelText: 'name'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: points,
                        decoration: InputDecoration(labelText: 'points'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: goalsfor,
                        decoration: InputDecoration(labelText: 'goalsfor'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: goalsagainst,
                        decoration: InputDecoration(labelText: 'goalsagainst'),
                      ),
                    ),
                    if (width > 0)
                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            Team addedTeam = Team(
                              name: name.text,
                              points: int.parse(points.text),
                              goalsfor: int.parse(goalsfor.text),
                              goalsagainst: int.parse(goalsagainst.text),
                              goalsdifference: int.parse(goalsfor.text) - int.parse(goalsagainst.text),
                            );
                            // AppState.addTeam(addedTeam.toJson());
                            List<Team> data = await AppState.teams;
                            setState(() {
                              teams = data;
                            });
                            name.clear();
                            points = TextEditingController(text: '0');
                            goalsfor = TextEditingController(text: '0');
                            goalsagainst = TextEditingController(text: '0');
                            _addTeam(addedTeam);
                            setState(() {
                              width = 0;
                            });
                            // AnimatedNavigator.scale(
                            //   context: context,
                            //   page: TeamsList(),
                            //   naviType: NaviType.replacement,
                            // );
                          },
                          icon: Icon(Icons.save),
                        ),
                      ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAnimatedListItem(int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: InkWell(
        onTap: () {
          AnimatedNavigator.scale(
            context: context,
            page: EditTeam(
              team: teams[index],
            ),
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: 200,
              color: Colors.blue,
              padding: const EdgeInsets.all(7),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              '${teams[index].name}: ',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${teams[index].points}',
                              style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await _deleteTeam(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addTeam(Team team) async {
    await AppState.addTeam(team.toJson());

    var teamsData = await AppState.teams;
    teams = teamsData;

    _listKey.currentState!.insertItem(0);
  }

Future<void> _deleteTeam(int index) async {
  Team deletedTeam = teams[index];

  await AppState.deleteTeam(deletedTeam.toJson());

  _listKey.currentState!.removeItem(
    index,
    (context, animation) => _buildAnimatedListItem(index, animation),
    // Specify the duration for the removal animation
    duration: const Duration(milliseconds: 500),
  );

  // Wait for the removal animation to complete before updating the list
  await Future.delayed(const Duration(milliseconds: 500));

  var teamsData = await AppState.teams;
  setState(() {
    teams = teamsData;
  });
}

}
