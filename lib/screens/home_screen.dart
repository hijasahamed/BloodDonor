import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  final CollectionReference donor= FirebaseFirestore.instance.collection('blooddonation');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donors',style: TextStyle(fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.red, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.pushNamed(context, '2');},
        backgroundColor: Colors.red,
        child:const Icon(Icons.add,size: 50,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: donor.snapshots(), 
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.separated(
              itemBuilder: (ctx,index){
                final DocumentSnapshot donorsnap=snapshot.data.docs[index];
                return Text(donorsnap['name']);
              }, 
              separatorBuilder: (ctx,index){
                return const  SizedBox();
              }, 
              itemCount: snapshot.data!.docs.length, 
            );
          }
          return const SizedBox(
            child: Center(
              child: Text('No Data Available'),
            ),
          );
        },
      ),
    );
  }
}

