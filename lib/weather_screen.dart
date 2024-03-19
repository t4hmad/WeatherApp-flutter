
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather1/Hourly_forcast.dart';
import 'package:weather1/addInfo.dart';
import 'package:http/http.dart' as http;
import 'package:weather1/key.dart';
class WeatherScreen extends StatefulWidget
{
const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
   
 
  
Future<Map<String,dynamic>> getCurrentWeather() async {
  
  try{
    
    final res = await http.get(Uri.parse(
    'https://api.openweathermap.org/data/2.5/forecast?q=Charsadda,Paskistan&APPID=$openWeatherAPIKey'),
  );
 final data = jsonDecode(res.body);
 if (int.parse(data['cod'])!=200){
  throw 'An Unexpected Error Occured';
 }
 return data;



  }catch (e){
    throw e.toString();
  }

}

@override
Widget build(BuildContext context)
{
  return  Scaffold
  (
appBar: AppBar(
  
  title: const Text('Weathere App',style: TextStyle(
    fontWeight: FontWeight.bold),
    
    ),
  centerTitle: true,
  
  actions: [ IconButton(onPressed: (){
    setState(() {
      
    });
  }, icon:
   const Icon(Icons.refresh),
  ),
  ],
    
),
body: FutureBuilder(
  future: getCurrentWeather() ,
  builder: (context,snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting){
      return const Center(child:  CircularProgressIndicator.adaptive()
      );
    }
    if (snapshot.hasError){
      return Text(snapshot.error.toString()
      );
    }
    final data = snapshot.data!;
    final currentTemp =data['list'][0]['main']['temp'];
    final currentSky = data['list'][0]['weather'][0]['main'];
    final currentpressure = data['list'][0]['main']['pressure'];
    final windSpeed = data['list'][0]['wind']['speed'];
   final currentHumidiy = data['list'][0]['main']['humidity'];

    return Padding(
  
    padding: const EdgeInsets.all(16.0),
  
    child:   Column(
  
      crossAxisAlignment: CrossAxisAlignment.start, 
  
      children: [
  
      SizedBox(
  
  
  
        width: double.infinity,
  
  
  
         child: Card(
  
    
  
          elevation: 10,
  
    
  
          shape: RoundedRectangleBorder(
  
    
  
            borderRadius: BorderRadius.circular(16),
  
    
  
          ),
  
          child:ClipRRect(
  
            borderRadius: BorderRadius.circular(16),
  
            child: BackdropFilter(
  
              filter:ImageFilter.blur(
  
                sigmaX: 10,
  
                sigmaY: 10,
  
                ),
  
               
  
          
  
    
  
          child:  Padding(
  
    
  
            padding:  const EdgeInsets.all(16.0),
  
    
  
            child:  Column(children: [
  
              Text('$currentTemp °K', 
  
              style: const TextStyle(
  
                fontSize: 32,
  
                fontWeight: FontWeight.bold,
  
              ),
  
              ),
  
    
  
              const SizedBox(height: 10),
  
              Icon( currentSky == 'Clouds' || currentSky == 'Rain'? Icons.cloud: Icons.sunny,
                size: 50,
  
    
  
              ),
  
    
  
            const  SizedBox(height: 10,
  
    
  
              ),
  
    
  
              Text(currentSky,
              style: const TextStyle
  
    
  
              (
  
    
  
                fontSize: 20,
  
    
  
            ),
  
    
  
              ),
  
            ],
  
            ),
  
          ),
  
          ),
  
          ),
  
         ),
  
       ),
  
  
  
        const SizedBox(height: 20,),
  
       const Text('Hourly Forcast',style: TextStyle(
  
          fontSize: 16,
  
          fontWeight: FontWeight.bold,
  
        ),
  
        ),
  
       
  
        const SizedBox(height: 10),
        SizedBox(
           height: 120,
           
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              final hourlyForcast = data['list'][index+1];
              final time = DateTime.parse(hourlyForcast['dt_txt'].toString());
              return HourlyForcastItem(
                time: DateFormat.j().format(time),
                 icon1: data['list'][index+1]['main']=='Clouds'|| data['list'][0]['main']=='Rain' ? 
                  Icons.cloud : Icons.sunny,
                 temp: hourlyForcast['main']['temp'].toString(), 
                 );
           
          },
          ),
        ),
  
         const SizedBox(height: 20,),
  
       const Text('Additional information',style: TextStyle(
  
          fontSize: 16,
  
          fontWeight: FontWeight.bold,
  
        ),
  
        ),   
  
         Row(
  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
          children: [
  
            AddInfoItem(
  
              icon: Icons.water_drop,
  
              label: 'Humidity',
  
              value:currentHumidiy.toString() ,
  
            ),
  
            AddInfoItem(
  
              icon: Icons.air,
  
              label: 'Wind Speed',
  
              value: windSpeed.toString(),
  
            ),
  
            AddInfoItem(
  
              icon: Icons.beach_access,
  
              label: 'Pressure',
  
              value: currentpressure.toString(),
  
            ),
  
  
  
          ],
  
          
  
         )
  
      ],
  
    ),
  
  );
  },
),
  );
}
}

