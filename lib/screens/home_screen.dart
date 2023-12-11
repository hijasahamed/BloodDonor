import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        stream: donor.orderBy('name').snapshots(), 
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (ctx,index){
                  final DocumentSnapshot donorsnap=snapshot.data.docs[index];
                  return Container(
                    decoration:const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 241, 237, 237),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20,
                          spreadRadius: 20
                        )
                      ]
                    ),
                    height: 125,
                    
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: CircleAvatar(
                            radius: 50,
                            child: Text(donorsnap['blood'],style: const TextStyle(fontSize: 30),),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name:${donorsnap['name']}'),
                            Text('Age:${donorsnap['age'].toString()}'),
                            Text('Mobile:${donorsnap['mobile'].toString()}'),
                            Text('District:${donorsnap['district']}'),
                            Text('Village:${donorsnap['village']}'),
                            Text('Blood:${donorsnap['blood']}'),
                          ],
                        ),
                      ],
                    ),
                  );
                }, 
                separatorBuilder: (ctx,index){
                  return const  SizedBox(height: 10,);
                }, 
                itemCount: snapshot.data!.docs.length, 
              ),
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

