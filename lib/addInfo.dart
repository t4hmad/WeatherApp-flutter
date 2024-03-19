 import 'package:flutter/material.dart';


 class AddInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AddInfoItem({super.key,
  required this.icon,
  required this.label,
  required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return   Column(
           children: [
            const SizedBox(height: 15,),
            Icon(icon,
            size: 30,
            ),
           const SizedBox(height: 15,),
            Text(
              label,
              style: const TextStyle(
              fontSize: 16,

            ),
            ),
              const SizedBox(
                      height: 8,
                    ),
                    Text(value,
                    style:const TextStyle(
                      fontSize: 16,
                      
                    ),
                    ),
            
           ],
           
           
    );
           
  }
}