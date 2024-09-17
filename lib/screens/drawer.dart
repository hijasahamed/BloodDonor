// ignore_for_file: use_build_context_synchronously
import 'package:blood_donor/screens/add_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Blood Groups',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BloodDonorListScreen(bloodGroup: bloodGroups[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    bloodGroups[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.bloodtype,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: bloodGroups.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class BloodDonorListScreen extends StatelessWidget {
  final String bloodGroup;

  const BloodDonorListScreen({super.key, required this.bloodGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed:() {
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,)
        ),
        title: Text('Donors for $bloodGroup',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('blooddonation')
            .where('blood', isEqualTo: bloodGroup)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return const Center(child: Text('No donors found for this blood group'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(               
                itemCount: snapshot.data.docs.length,
                itemBuilder: (ctx, index) {
                  final DocumentSnapshot donorsnap = snapshot.data.docs[index];
                  return GestureDetector(
                    child: Card(
                      color: Colors.white,
                      elevation: 15,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 241, 237, 237),
                        ),
                        height: 125,
                        child: Row(
                          children: [
                            const SizedBox(width: 25,),
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(
                                donorsnap['blood'],
                                style: const TextStyle(fontSize: 30,color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 25,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${donorsnap['name']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Age: ${donorsnap['age'].toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Mobile: ${donorsnap['mobile'].toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'District: ${donorsnap['district']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Village: ${donorsnap['village']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Blood: ${donorsnap['blood']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) => const SizedBox(height: 10),
              ),
            );
          }
        },
      ),
    );
  }
}
