import 'package:blood_donor/screens/drawer.dart';
import 'package:blood_donor/functions/fuctions.dart';
import 'package:flutter/material.dart';
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '2');
        },
        backgroundColor: Colors.red,
        elevation: 25,
        child: const Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: const Drawerscreen(),
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return const Center(
              child: Text('No Data Available'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                
                itemCount: snapshot.data.docs.length,
                itemBuilder: (ctx, index) {
                  final DocumentSnapshot donorsnap = snapshot.data.docs[index];

                  return GestureDetector(
                    onLongPress: () =>
                        deletebuttonclicked(donorsnap.id, context),
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