import 'package:blood_donor/screens/add_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const Text(
              'Blood Groups',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.red),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the blood donor list screen with selected blood group
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BloodDonorListScreen(bloodGroup: bloodGroups[index]),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.red,
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
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.bloodtype,
                                  color: Colors.white,
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
        title: Text('Donors for $bloodGroup'),
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
                return ListTile(
                  title: Text(donorSnap['name']),
                  subtitle: Text('Mobile: ${donorSnap['mobile']}'),
                  trailing: Text('Age: ${donorSnap['age'].toString()}'),
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
