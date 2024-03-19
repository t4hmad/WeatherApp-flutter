import 'package:flutter/material.dart';
class HourlyForcastItem extends StatelessWidget {
  final String time;
  final IconData icon1;
  final String temp;
  const HourlyForcastItem({super.key, required this.time, required this.icon1, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 100,
              child: Container(
                width: 100,
                
      
                padding: const EdgeInsets.all(8.0),
                
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(15),
      
                ),
                child:  Column(
                  children: [
                    Text(time,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    ),
                     const SizedBox(height: 8,),
                      Icon(
                      icon1,
                        size: 32,
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(temp,
                    style:const TextStyle(
                      fontSize: 16,
                      
                    ),
                    
                    ),
                  ],
                        
                ),
              ),
            );
  }
}