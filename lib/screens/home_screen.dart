import 'package:blood_donor/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('blooddonation');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            splashRadius: 27,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            iconSize: 40,
          );
        }),
        title: const Text(
          'Blood Donors',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: const Drawerscreen(),
      body: const Center(child: Text('Requests')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.red,
              label: 'Add Blood',
              labelStyle: const TextStyle(fontSize: 18.0,color: Colors.red,fontWeight: FontWeight.w400),
              onTap: () {
                
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.bloodtype, color: Colors.white),
              backgroundColor: Colors.red,
              label: 'Request Blood',
              labelStyle: const TextStyle(fontSize: 18.0,color: Colors.red,fontWeight: FontWeight.w400),
              onTap: () {
               
              },
            ),
          ],
        ),
      ),
    );
  }
}
