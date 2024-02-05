import 'package:data_base/logics/appstate.dart';
import 'package:data_base/logics/globals.dart';
import 'package:data_base/logics/teams_class.dart';
import 'package:flutter/material.dart';

class EditTeam extends StatefulWidget {
  final Team team;
  const EditTeam({super.key, required this.team});

  @override
  State<EditTeam> createState() => _EditTeamState();
}

class _EditTeamState extends State<EditTeam> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: widget.team.name);
    TextEditingController points = TextEditingController(text: widget.team.points.toString());
    TextEditingController goalsfor = TextEditingController(text: widget.team.goalsagainst.toString());
    TextEditingController goalsagainst = TextEditingController(text: widget.team.goalsagainst.toString());
    TabController tabController = TabController(length: 2, vsync: this);
    int position = _Position(widget.team);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              widget.team.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.grey.shade600,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 15),
          tabs: [
            Tab(
              child: Text('Details'),
            ),
            Tab(
              child: Text('Edit'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  height: 70,
                  width: 150,
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        'Position',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(position.toString()),
                    ),
                  ),
                ),
                Positioned(
                  height: 70,
                  width: 150,
                  right: 0,
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        'Points',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(widget.team.points.toString()),
                    ),
                  ),
                ),
                Positioned(
                  height: 70,
                  width: 170,
                  right: width * 0.5 - 85,
                  top: height * 0.15,
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        'Goals differenc',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(widget.team.goalsdifference.toString()),
                    ),
                  ),
                ),
                Positioned(
                  height: 70,
                  width: 150,
                  top: height * 0.3,
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        'Goals for',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(widget.team.goalsfor.toString()),
                    ),
                  ),
                ),
                Positioned(
                  height: 70,
                  width: 150,
                  right: 0,
                  top: height * 0.3,
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        'Goals against',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(widget.team.goalsagainst.toString()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      Team editTeam = Team(
                        name: name.text,
                        points: int.parse(points.text),
                        goalsfor: int.parse(goalsfor.text),
                        goalsagainst: int.parse(goalsagainst.text),
                        goalsdifference: int.parse(goalsfor.text) - int.parse(goalsagainst.text),
                      );
                      AppState.editTeam(editTeam.toJson());
                      print(editTeam.points);
                    },
                  ),
                ),
                Expanded(child: SizedBox()),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int _Position(Team team) {
  return teams.indexOf(team) + 1;
}
