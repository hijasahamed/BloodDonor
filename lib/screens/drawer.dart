import 'package:blood_donor/screens/add_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: SafeArea(
        child: ListView.separated(
          itemBuilder: (context,index){
            return Card(
              elevation: 5,
              color: Colors.red,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text(bloodGroups[index],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                          const Icon(Icons.bloodtype)
                        ],
                      )),
                  ],
                ),
              ),
            );
          }, 
          separatorBuilder: (context,index){
            return const SizedBox(height: 10,);
          }, 
          itemCount: bloodGroups.length
        ),
      ),
    );
  }
}