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
  List<ProductModel> product = [];
  Future<List<ProductModel>> productList;

  Future<List<ProductModel>> updateAndGetList() async {
    return productDisplay();
  }

  Future<List<ProductModel>> productDisplay() async {
    try {
      var request =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (request.statusCode == 200) {
        var data = json.decode(request.body) as List;
        print("ProductData $data");
        for(var i = 0; i< data.length ; i++)
           {
             product.add(ProductModel.fromJson(data[i]));
           }
        return product;
      }
    } catch (e) {
      print("ProductDataError $e");
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
      body: FutureBuilder<List<ProductModel>>(
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

  Widget productListWidget(List<ProductModel> item) {
      return ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) =>
            Column(
              children: [
                Container(
                  width: 200,
                  // color: Colors.purple[300],
                  child: item[index].category == "men's clothing" ? Center(
                      child: Text(
                        item[index].category,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )) : Container(),
                ),
                Container(
                  width: 200,
                  // color: Colors.purple[300],
                  child: item[index].category == "jewelery" ? Center(
                      child: Text(
                        item[index].category,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )) : Container(),
                ),
                Container(
                  width: 200,
                  // color: Colors.purple[300],
                  child: item[index].category == "electronics" ? Column(
                    children: [
                      Center(
                          child: Text(
                            item[index].category,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )),
                      Center(
                          child: Text(
                            item[index].price,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )),
                    ],
                  ) : Container(),
                ),
              ],
            ),
      );
  }
}
