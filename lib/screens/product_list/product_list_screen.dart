import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:task_app/model/product/product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductModel product;
  Future<ProductModel> productList;

  Future<ProductModel> updateAndGetList() async {
    return productDisplay();
  }

  Future<ProductModel> productDisplay() async {
    try {
      var request =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (request.statusCode == 200) {
        var data = json.decode(request.body);
        print("Product Data $data");
        product = ProductModel.fromJson(data);
        return product;
      }
    } catch (e) {
      print("Product Data Error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    productList = updateAndGetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductModel>(
          future: productList,
          builder: (context, snapShot) {
            print("Future");
            if (snapShot.hasData) {
              return productListWidget(snapShot.data);
            } else if (snapShot.hasError) {
              return const Center(
                  child: Text(
                "Something went wrong",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget productListWidget(ProductModel item) {
      return ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) =>
            Container(
              width: 200,
              // color: Colors.purple[300],
              child: Center(
                  child: Text(
                    item.category,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ),
      );
  }
}
