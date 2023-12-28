
import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/image_string.dart';




class SingleNetworkUserWidget extends StatefulWidget {

  const SingleNetworkUserWidget({super.key, });

  @override
  State<SingleNetworkUserWidget> createState() => _SingleNetworkUserWidgetState();
}

class _SingleNetworkUserWidgetState extends State<SingleNetworkUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: const BoxDecoration(
                    color: Colors.grey
                ),

              ),
              const SizedBox(height: 60,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Username", maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("info", maxLines: 1, overflow: TextOverflow.ellipsis,   style: Theme.of(context).textTheme.bodySmall
              ),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.group),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(" mutual connections", maxLines: 2, overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.labelSmall,))
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: Container(

                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: oPrimaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text("Connect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: oPrimaryColor),),
                  ),
                ),
              )
            ],
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(60),child: Image.asset(profileImage, fit: BoxFit.cover,)),
            ),
          )
        ],
      ),
    );
  }
}
