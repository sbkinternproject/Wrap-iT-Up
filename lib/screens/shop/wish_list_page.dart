import 'package:sbk_ecommerce_app/app_properties.dart';
import 'package:sbk_ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:sbk_ecommerce_app/services/wishlistpage_products.dart';

import 'components/shop_item_list.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<Product> products = WishListProducts().products;

  @override
  Widget build(BuildContext context) {
    Widget wishlistButton = InkWell(
      onTap: () => {},
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => AddAddressPage())),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Check Out",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/icons/denied_wallet.png'),
            onPressed: () => {},
            // Navigator.of(context)
            // .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
          )
        ],
        title: Text(
          'Wishlist',
          style: TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            // ConstrainedBox(
            //   constraints: BoxConstraints(
            //     minHeight: constraints.minHeight,
            //     maxHeight: constraints.maxHeight,
            //   ),
            height: constraints.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  height: 48.0,
                  color: red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Subtotal',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        products.length.toString() + ' items',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight * .75,
                  child: Scrollbar(
                    child: ListView.builder(
                      // Shop Item List is an Widget to Build Shop Item
                      itemBuilder: (_, index) => ShopItemList(
                        products[index],
                        onRemove: () {
                          setState(() {
                            products.remove(products[index]);
                          });
                        },
                      ),
                      itemCount: products.length,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Center(child: wishlistButton)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: wishlistButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
