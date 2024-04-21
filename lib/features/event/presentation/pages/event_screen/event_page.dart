
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'event_detail_page.dart';
import 'event_page.dart';
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  int _selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 8,
                color: Colors.grey,
              ),
              ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),shrinkWrap: true, physics: const ScrollPhysics(),itemCount: 15,itemBuilder: (context, index) {
                return GestureDetector(child:_singleEventWidget(),onTap:(){
                   Get.to(()=>const EventDetailPage());
                });
              })
            ],
          ),
        )
    );
  }

  _singleCategoryItem({String? title, Color? textColor, Color? bgColor, VoidCallback? onTap, double? border}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: border!),
          color: bgColor,
        ),
        child: Center(child: Text("$title", style: TextStyle(color: textColor, fontWeight: FontWeight.bold),),),
      ),
    );
  }

  _singleEventWidget() {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: ClipRRect(borderRadius: BorderRadius.circular(35),child: Image.asset("assets/images/general/profile_2.jpeg", fit: BoxFit.cover,)),
              ),
              const SizedBox(width: 10,),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),Text("Event Name", style: TextStyle(fontSize: 14),),
                  SizedBox(height: 2,),
                  Text("05-01-2024", style: TextStyle(color: Colors.grey),),
                ],
              ),
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1h", style: TextStyle(color: Colors.grey, fontSize: 12),),
              Icon(Icons.more_vert, color: Colors.grey,)
            ],
          )

        ],
      ),
    );
  }
}


