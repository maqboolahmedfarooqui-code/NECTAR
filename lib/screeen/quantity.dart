import 'package:flutter/material.dart';

class quantity extends StatefulWidget {
  const quantity({super.key});

  @override
  State<quantity> createState() => _quantityState();
}

class _quantityState extends State<quantity> {
  int quantity = 1;
  int price = 200;

  @override
  Widget build(BuildContext context) {
    int totalprice = quantity * price;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80,),
          Text('$quantity'),
          Row(
            children: [                                                                    

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                child: Text('+'),

              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if(quantity > 1){
                    quantity--; 
                    }
                  });
                },
                child: Text('-'),
              ),
            ],
          ),
          Text("$totalprice"),
        ],
      ),
    );
  }
}
