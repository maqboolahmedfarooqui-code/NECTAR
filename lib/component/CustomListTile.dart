import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomListTile({super.key,
   required this.icon,
   required this.text,
   });

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: () {},
     leading: Icon(icon, size: 30),
     title: Text(text,style: TextStyle(fontSize: 20.sp),),
     trailing: Icon(Icons.arrow_right ,size: 50,),
     );
  }
}
