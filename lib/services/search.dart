import 'package:flutter/material.dart';
import 'world_time.dart';
import 'locations.dart';


class CustomSearchDelegate extends SearchDelegate {


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {query = '';}, icon: Icon(Icons.clear),),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () { close(context, null); }, icon: Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<WorldTime> matchQuery = [];

    void updateTime(index) async {
      WorldTime instance = matchQuery[index];
      await instance.getTime();
      Navigator.popAndPushNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'url': instance.url,
      });
    }


    for (var location in locations) {
      if (location.location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              updateTime(index);
            },
            title: Text(matchQuery[index].location),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${matchQuery[index].flag}'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<WorldTime> matchQuery = [];

    void updateTime(index) async {
      WorldTime instance = matchQuery[index];
      await instance.getTime();
      Navigator.popAndPushNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'url': instance.url,
      });
    }


    for (var location in locations) {
      if (location.location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              updateTime(index);
            },
            title: Text(matchQuery[index].location),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${matchQuery[index].flag}'),
            ),
          ),
        );
      },
    );
  }



}