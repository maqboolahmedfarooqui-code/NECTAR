import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  // 🔥 Add Product to Firestore
  Future addProduct() async {
    await FirebaseFirestore.instance.collection("products").add({
      "name": nameController.text,
      "price": priceController.text,
      "desc": descController.text,
    });

    nameController.clear();
    priceController.clear();
    descController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Product Added!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: priceController,
              decoration: InputDecoration(
                hintText: "Price",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: addProduct, child: Text("Add Product")),
          ],
        ),
      ),
    );
  }
}
