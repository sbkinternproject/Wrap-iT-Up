import '/services/mainpage_products.dart';

import '../notifications_page.dart';
import '../search_page.dart';
import '/app_properties.dart';
import '/custom_background.dart';
import '/models/product.dart';
import '/screens/profile_page.dart';
import '../shop/wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
import 'components/tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

//TimeLines Options
List<String> timelines = ['Weekly featured', 'Best of June', 'Best of 2022'];
// Selected By Default
String selectedTimeline = 'Weekly featured';

// Product List, COmes from Repository, Weekly Featured
List<Product> products = MainPageProducts().products;

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  //Treding Sports Headsets Wirelss Bluetooth Controller
  late TabController tabController;
  //Bottom Tab Controller for Navigation
  late TabController bottomTabController;

  @override
  void initState() {
    super.initState();
    //Controller for Trending Sports Headsets Wireless Bluetooth
    tabController = TabController(length: 5, vsync: this);
    // Controller for Home Category Cart Account
    bottomTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // App Bar Contains Notification and Search Icon.
    Widget appBar = Container(
      //kToolbarHeight The height of the toolbar component of the [AppBar].
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () =>
                  // {},
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => NotificationsPage())),
              icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () =>
                  // {},
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget topHeader = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            /*
            InkWell class in Flutter is a rectangular area in Flutter of a 
            material that responds to touch in an application. The InkWell 
            widget must have a material widget as an ancestor. The material 
            widget is where the ink reactions are actually performed. InkWell 
            reactions respond when the user clicks the button.
*/
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedTimeline = timelines[0];
                  products = MainPageProducts().products;
                });
              },
              child: Text(
                timelines[0],
                style: TextStyle(
                    fontSize: timelines[0] == selectedTimeline ? 20 : 14,
                    color: darkGrey),
              ),
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedTimeline = timelines[1];
                  products = MainPageProducts().products1;
                });
              },
              child: Text(timelines[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: timelines[1] == selectedTimeline ? 20 : 14,
                      color: darkGrey)),
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedTimeline = timelines[2];
                  products = MainPageProducts().products2;
                });
              },
              child: Text(timelines[2],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: timelines[2] == selectedTimeline ? 20 : 14,
                      color: darkGrey)),
            ),
          ),
        ],
      ),
    );

    //Tab Bar Trending Sports Headsets Wireless Bluetooth
    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Trending'),
        Tab(text: 'Sports'),
        Tab(text: 'Headsets'),
        Tab(text: 'Wireless'),
        Tab(text: 'Bluetooth'),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        //Custom Background
        painter: MainBackground(),
        //Creates a page view with one child per tab.
        child: TabBarView(
          controller: bottomTabController,
          // Creates scroll physics that does not let the user scroll.
          // You can make the ListView widget never scrollable by setting
          // physics property to NeverScrollableScrollPhysics().
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SafeArea(
              // Creates a nested scroll view.
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    //Creates a sliver that contains a single box widget.
                    SliverToBoxAdapter(
                      child: appBar,
                    ),
                    // Sliver is a portion of the scrollable area which
                    //is used to achieve a custom scrolling effect. In
                    //other words, the sliver widget is a slice of the
                    //viewport. We can implement all of the scrollable
                    //views, such as ListView, GridView using slivers.
                    SliverToBoxAdapter(
                      child: topHeader,
                    ),
                    SliverToBoxAdapter(
                      child: ProductList(
                        products: products,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: tabBar,
                    )
                  ];
                },
                body:
                    // Center(child: Text('Body')),
                    TabView(
                  tabController: tabController,
                ),
              ),
            ),
            WishListPage(),
            ProfilePage()
          ],
        ),
      ),
    );
  }
}
