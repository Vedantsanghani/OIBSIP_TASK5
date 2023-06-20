import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //logic
  int seconds=0,minutes=0,hours=0;
  String digitSeconds="00",digitMinutes="00",digitHours="00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //timer function

  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }
  //reset function

  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds="00";
      digitMinutes="00";
      digitHours="00";

      started = false;
    });
  }

  void addLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }
  //start function

  void start(){
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds > 59){
        if(localMinutes > 59){
          localHours++;
          localMinutes=0;
        }
        else{
          localMinutes++;
          localSeconds=0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ?"$seconds":"0$seconds";
        digitHours = (hours >= 10) ?"$hours":"0$hours";
        digitMinutes = (minutes >= 10) ?"$minutes":"0$minutes";
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "StopWatch",
                  style: TextStyle(
                    color: Colors.yellow.shade500,
                    fontFamily: 'Bokis-Oblique',
                    fontSize: 65,
                    //fontWeight: FontWeight.bold,
                  ),),
              ),
              SizedBox(height: 10,),
              Center(
                child:
                Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade500,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context,index){
                    return Padding (
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap ${index+1}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text("${laps[index]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          (!started) ? start() : stop();
                        },
                        padding: EdgeInsets.all(15),
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: Colors.yellowAccent,
                          ),
                        ),
                        child: Text(
                          (!started) ? "Start" : " Pause",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ),
                  SizedBox(width: 8,),
                  IconButton(
                      padding: EdgeInsets.all(15),
                      color: Colors.white,
                      onPressed: (){
                        addLaps();
                      },
                      icon: Icon(Icons.flag),),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: (){
                        reset();
                      },
                      fillColor: Colors.red,
                      padding: EdgeInsets.all(15),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
