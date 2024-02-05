// import 'package:amazing_tools/tools/animated_dialog.dart';
import 'package:amazing_tools/tools/animated_navigator.dart';
import 'package:data_base/logics/appstate.dart';
import 'package:data_base/logics/globals.dart';
import 'package:data_base/widgets/teams_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_sharp),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Data base')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                teams = await AppState.teams;
                setState(() {
                  // teams.sort(
                  //   (a, b) => b.points.compareTo(a.points),
                  // );
                  print('Teams number: ${teams.length}');
                });
                AnimatedNavigator.slideDown(
                    context: context, page: TeamsList(), duration: Duration(milliseconds: 1000));
              },
              child: const Text('Teams'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Players'),
            ),
          ],
        ),
      ),
    );
  }
}
