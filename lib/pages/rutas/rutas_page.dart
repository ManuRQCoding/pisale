import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pisale/models/map_route.dart';

class RutasPage extends StatelessWidget {
  const RutasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutas'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('routes')
              .orderBy('name')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            final data = snapshot.data!.docs;

            print(data);
            return ListView.separated(
                itemBuilder: (context, i) {
                  final currentData = data[i];

                  final mapRoute = MapRoute.fromFirebaseObject(currentData);

                  return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'ruta_detail',
                            arguments: mapRoute);
                      },
                      leading: Icon(Icons.location_on),
                      title: Text(mapRoute.name));
                },
                separatorBuilder: (context, i) => Divider(),
                itemCount: data.length);
          }),
    );
  }
}
