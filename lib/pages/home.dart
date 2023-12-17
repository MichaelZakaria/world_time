import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

    String bgImage = data['isDayTime'] ? 'day.PNG' : 'night.PNG';

    return Scaffold(
      body: SafeArea(
          child:
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$bgImage'),
                  fit: BoxFit.cover
                )
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,180,0,0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton.icon(
                        onPressed: () async{
                          dynamic result = await Navigator.pushNamed(context, '/location');
                          setState(() {
                            data = {
                              'time': result['time'],
                              'location': result['location'],
                              'isDayTime': result['isDayTime'],
                              'flag': result['flag'],
                              'url': result['url']
                            };
                          });
                          },
                        icon: Icon(
                          Icons.edit_location,
                          size: 28,
                        ),
                        label: Text(
                          'Edit Location',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Column(
                        children: [
                          Text(
                            data['location'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 32.0),
                              Text(
                                data['time'],
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2,
                                ),
                              ),
                              IconButton(onPressed: () async {
                                WorldTime instance = WorldTime(location: data['location'], flag: data['flag'], url: data['url']);
                                await instance.getTime();
                                setState(() {
                                  data = {
                                    'time': instance.time,
                                    'location': instance.location,
                                    'isDayTime': instance.isDayTime,
                                    'flag': instance.flag,
                                    'url': instance.url
                                  };
                                });
                              }, icon: Icon(Icons.refresh),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
