import '/services/searchpage_products.dart';

import '/app_properties.dart';
import '/models/product.dart';
import '/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";

  List<Product> products = SearchPageProducts().products;
  List<Product> searchResults = [];

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.orange, width: 1))),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  List<Product> tempList = [];
                  products.forEach((product) {
                    if (product.name.toLowerCase().contains(value)) {
                      tempList.add(product);
                    }
                  });
                  setState(() {
                    searchResults.clear();
                    searchResults.addAll(tempList);
                  });
                  return;
                } else {
                  setState(() {
                    searchResults.clear();
                    searchResults.addAll(products);
                  });
                }
              },
              cursorColor: darkGrey,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
                suffix: FlatButton(
                  onPressed: () {
                    searchController.clear();
                    searchResults.clear();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange[50],
              child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ViewProductPage(
                                      product: searchResults[index],
                                    ))),
                        title: Text(searchResults[index].name),
                      ))),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
//          bottomSheet: ClipRRect(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//            child: BottomSheet(
//                onClosing: () {},
//                builder: (_) => Container(
//                      padding: EdgeInsets.all(16.0),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[Text('Filters')]),
//                      color: Colors.white,
//                      width: MediaQuery.of(context).size.height,
//                    )),
//          ),
            body: RubberBottomSheet(
          lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          upperLayer: Container(),
          // _getUpperLayer(), // The bottomsheet content (Widget)
          animationController: _controller, // The one we created earlier
        )),
      ),
    );
  }
}
