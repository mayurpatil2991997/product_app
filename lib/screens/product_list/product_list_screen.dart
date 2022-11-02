import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:task_app/model/product/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> product = [];
  List<ProductModel> filterSearch = [];
  String query = "";
  Timer debouncer;
  Future<List<ProductModel>> productList;
  String ratingValue = "";
  TextEditingController searchController = TextEditingController();

  Future<List<ProductModel>> productDisplay() async {
    try {
      var request =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (request.statusCode == 200) {
        var data = json.decode(request.body) as List;
        for (var i = 0; i < data.length; i++) {
          product.add(ProductModel.fromJson(data[i]));
        }

        if(query.isEmpty) {
          return product;
        }
         product.forEach((book) {
          final titleLower = book.title.toLowerCase();
          final searchLower = query.toLowerCase();

          if ( titleLower.contains(searchLower)){
            filterSearch.add(book);
          }
        });
        return filterSearch;
      }
    } catch (e) {
      print(e);
    }
  }

  //Debounce Method
  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }


  // Search Function
  Future searchBook(String query) async => debounce(() async {
    final books = await productDisplay();

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.product = books;
    });
  });


  //Init Method
  @override
  void initState() {
    filterSearch.addAll(product);
    super.initState();
  }

  //Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Products List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search Product',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchBook(value);
              },
            ),
          ),
          FutureBuilder<List<ProductModel>>(
              future: productDisplay(),
              builder: (context, snapShot) {
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
        ],
      ),
    );
  }


  //Widget
  Widget productListWidget(List<ProductModel> item) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          var parseValue = double.parse(item[index].rating.rate);
          var ratingValueDisplay = (parseValue * 100).round() / 100.0;
          return Column(
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
                          children: [
                            Image.network(
                              item[index].image,
                              height: 80.0,
                              width: 80.0,
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
                                      item[index].category,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      item[index].title,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
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
                                    RatingBar.builder(
                                      allowHalfRating: true,
                                      initialRating: ratingValueDisplay,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      direction: Axis.horizontal,
                                      onRatingUpdate: (rating) {
                                        ratingValue = rating.toString();
                                      },
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
          );
        },
      ),
    );
  }
}
