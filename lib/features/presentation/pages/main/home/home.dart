import 'package:flutter/material.dart';
import 'package:uni_link/features/presentation/pages/main/home/widget/single_post.dart';
import 'package:uni_link/features/presentation/widgets/appbar_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar:appBarWidget(context,title: 'search',isChatPage: false),
        body: ListView.builder(itemCount: 20,itemBuilder: (context, index) {return PostWidget();}),
      ),
    );
  }
}