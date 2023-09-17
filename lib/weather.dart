import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  @override
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  String city ="";
  String state="";
  String country="";
  String image='assets/weather.jpg';
  double?lat;
  double ?lon;
  var temp;
  var pressure;
  var humidity;

  // void location()async{
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();
  //   Position pos= await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  //   print(pos.latitude);
  //   print(pos.longitude);
  //
  // }
  void GetLocation() async {
    city=myController2.text;
    state=myController.text;
    country=myController1.text;
  
   final loc=await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$city,$state,$country&limit=5&appid=d0b0d0d0590213919a8a25d366e03fa3'));
   var data=jsonDecode(loc.body.toString());

   lat=data[0]['lat'];
    lon=data[0]['lon'];

    final weather=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=d0b0d0d0590213919a8a25d366e03fa3'));
    var data1=jsonDecode(weather.body.toString());


    setState(() {
      temp= data1['main']['temp'];
      pressure=data1['main']['pressure'];
      humidity=data1['main']['humidity'];
    });
  }
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover
          )
      ),
          child:Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children:[
                SingleChildScrollView(
                  child: Container(
                    // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
                    margin: EdgeInsets.only(top: 150,right: 35,left: 35),
                    child: Column(
                      children: [
                        TextField(
                          controller: myController2,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              hintText:"City Name...",
                            labelText: 'City Name',
                              labelStyle: TextStyle(
                                  color: Colors.black
                              )


                          ),
                        ),
                        SizedBox(height: 40,),
                        TextField(
                          controller: myController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              hintText:"State Name(RJ).....",
                              labelText: 'State name',
                            labelStyle: TextStyle(
                              color: Colors.black
                            )
                          ),
                        ),
                        SizedBox(height: 40,),
                        TextField(
                          controller: myController1,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              hintText:"Country Name(IN)....",
                              labelText: 'Country Name',
                              labelStyle: TextStyle(
                                  color: Colors.black
                              )
                          ),

                        ),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed:(){


                                 GetLocation();
                              // showSnackBar(context: context, content: 'Enter all fields');
                              myController.clear();
                              myController1.clear();
                              myController2.clear();

                            },
                              style: ElevatedButton.styleFrom(
                                // padding:EdgeInsets.only(right:) ,
                                  shadowColor: Colors.black,
                                  elevation: 20,
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  fixedSize: Size(150, 40)
                              ),
                              child:Text(" Calculate ") ,),
                          ],
                        ),
                        SizedBox(height: 50,),
                        Text("${city} Temperature : ${temp} ",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 10,),
                        Text(" Pressure : ${pressure} ",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 10,),
                        Text("Humidity : ${humidity} ",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


    );
  }


  void showSnackBar({required BuildContext context,required String content})
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)),);
  }
}
