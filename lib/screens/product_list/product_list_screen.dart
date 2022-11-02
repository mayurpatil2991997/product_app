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
        for (var i = 0; i < data.length; i++) {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) => Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            width: width * 0.9,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.green[100],
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 1.0,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          item[index].image,
                          height: 80.0,
                          width: 80.0,
                          // color: Colors.red,
                          fit: BoxFit.contain,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  item[index].title,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  item[index].description,
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${item[index].price}\$",
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
