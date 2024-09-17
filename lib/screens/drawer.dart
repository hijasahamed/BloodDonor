// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:blood_donor/functions/fuctions.dart';
import 'package:blood_donor/screens/add_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red,
      child: SafeArea(
        child: Column(
          children: [
            const Text(
              'Blood Groups',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
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
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: SizedBox(
                        height: 60,
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
            return ListView.separated(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, index) {
                final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                return InkWell(
                  onTap: () {
                    final mobileNumber = donorSnap['mobile'];
                    showDialog(
                      context: ctx,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Contact Donor'),
                          content: Text('Would you like to call ${donorSnap['name']}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                launchDialer(mobileNumber,context);
                              },
                              child: const Text('Call Donor'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(donorSnap['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mobile: ${donorSnap['mobile']}'),
                        Text('Mobile: ${donorSnap['district']}'),
                        Text('Mobile: ${donorSnap['village']}'),
                      ],
                    ),
                    trailing: Text('Age: ${donorSnap['age'].toString()}'),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
            );
          }
        },
      ),
    );
  }
}
