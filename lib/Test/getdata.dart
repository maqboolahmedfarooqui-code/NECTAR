import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection("products");

    return Scaffold(
      appBar: AppBar(title: Text("Products")),

      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data.docs;

          if (docs.isEmpty) {
            return Center(child: Text("No products found"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map;
              return Card(
                child: ListTile(
                  title: Text(data['name'] ?? ""),
                  subtitle: Text("Price: ${data['price'] ?? ""}\n${data['desc'] ?? ""}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}