import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:provider/provider.dart';
import 'package:trapp/src/dialogs/index.dart';
import 'package:trapp/src/dialogs/login_ask_dialog.dart';
import 'package:trapp/src/elements/SearchBarWidget.dart';
import 'package:trapp/src/elements/qrcode_icon_widget.dart';
import 'package:trapp/src/elements/top_category_1_widget.dart';
import 'package:trapp/src/elements/top_category_2_widget.dart';
import 'package:trapp/src/pages/OrderAssistantPage/index.dart';
import 'package:trapp/src/pages/CreateBargainRequestPage/index.dart';
import 'package:trapp/src/pages/CreateReverseAuctionPage/index.dart';
import 'package:trapp/src/pages/SearchPage/index.dart';
import 'package:trapp/src/pages/StoreCategoriesPage/index.dart';
import 'package:trapp/src/providers/fb_analytics.dart';
import 'package:trapp/src/providers/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trapp/environment.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  /// Responsive design variables
  double deviceWidth = 0;
  double deviceHeight = 0;
  double statusbarHeight = 0;
  double bottomBarHeight = 0;
  double appbarHeight = 0;
  double widthDp = 0;
  double heightDp = 0;
  double fontSp = 0;
  ///////////////////////////////

  @override
  void initState() {
    super.initState();

    /// Responsive design variables
    deviceWidth = 1.sw;
    deviceHeight = 1.sh;
    statusbarHeight = ScreenUtil().statusBarHeight;
    bottomBarHeight = ScreenUtil().bottomBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setWidth(1);
    fontSp = ScreenUtil().setSp(1) / ScreenUtil().textScaleFactor;

    ///////////////////////////////
    // if (Environment.enableFBEvents!) {
    //   getFBAppEvents().logViewContent(
    //     type: "page",
    //     id: "home",
    //     content: {},
    //     currency: "INR",
    //     price: 0,
    //   );
    // }

    // if (Environment.enableFreshChatEvents!) {
    //   Freshchat.trackEvent(
    //     "navigation",
    //     properties: {
    //       "page": "home",
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    print(DateTime.now().add(Duration(days: 2)).millisecondsSinceEpoch);
    return Consumer<AppDataProvider>(builder: (context, appDataProvider, _) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ///
            Container(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              color: Colors.transparent,
              child: SearchBarWidget(
                readOnly: true,
                tapCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => StoreCategoriesPage(onlyStore: false)),
                  );
                },
              ),
            ),

            ///
            SizedBox(height: heightDp * 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: CarouselSlider(
                items: [1, 2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: deviceWidth - widthDp * 40,
                        height: (deviceWidth - widthDp * 40) / 2,
                        // margin: EdgeInsets.symmetric(horizontal: widthDp * 10, vertical: heightDp * 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(heightDp * 10),
                          image: DecorationImage(
                            image: AssetImage("img/promocodes/promocode_$i.png"),
                            fit: BoxFit.fill,
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     offset: Offset(0, 0),
                          //     blurRadius: 6,
                          //     color: Colors.grey.withOpacity(0.6),
                          //   )
                          // ],
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: (deviceWidth - widthDp * 40) * 2 / 5,
                  aspectRatio: 5 / 2,
                  viewportFraction: 0.8,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  pauseAutoPlayOnTouch: false,
                ),
              ),
            ),

            ///
            Divider(height: heightDp * 40, thickness: heightDp * 10, color: Colors.grey.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order from 1000's of local businesses",
                    style: TextStyle(fontSize: fontSp * 16, fontWeight: FontWeight.w500),
                  ),
                  QRCodeIconWidget(),
                ],
              ),
            ),
            SizedBox(height: heightDp * 10),

            ///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: TopCategory1Widget(),
            ),

            ///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: TopCategory2Widget(),
            ),
            Divider(height: heightDp * 40, thickness: heightDp * 10, color: Colors.grey.withOpacity(0.3)),

            ///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: CarouselSlider(
                items: [1, 2, 3, 4].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: deviceWidth - widthDp * 40,
                        height: (deviceWidth - widthDp * 40) * 20 / 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(heightDp * 10),
                          image: DecorationImage(
                            image: AssetImage("img/sliders/$i.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: (deviceWidth - widthDp * 40) * 20 / 50,
                  aspectRatio: 50 / 20,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  pauseAutoPlayOnTouch: false,
                ),
              ),
            ),

            ///
            Divider(height: heightDp * 40, thickness: heightDp * 10, color: Colors.grey.withOpacity(0.3)),
            Center(
              child: Text(
                "What Do You Want To Do Today?",
                style: TextStyle(
                  fontSize: fontSp * 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: heightDp * 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (AuthProvider.of(context).authState.userModel!.id == null) {
                            LoginAskDialog.show(context, callback: () {
                              NormalDialog.show(
                                context,
                                title: "TradeMantri Assistant",
                                content: "Select a store in a category. "
                                    "Create a list of products and services you want from store. "
                                    "Choose PickUp/Delivery/Service Date and Place Order.",
                                callback: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OrderAssistantPage()));
                                },
                              );
                            });
                          } else {
                            NormalDialog.show(
                              context,
                              title: "TradeMantri Assistant",
                              content: "Select a store in a category. "
                                  "Create a list of products and services you want from store. "
                                  "Choose PickUp/Delivery/Service Date and Place Order",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OrderAssistantPage()));
                              },
                            );
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(heightDp * 10),
                            child: Container(
                              width: (deviceWidth - widthDp * 60) / 2,
                              height: (deviceWidth - widthDp * 60) / 2,
                              child: Image.asset(
                                "img/assistant_home1.png",
                                width: (deviceWidth - widthDp * 60) / 2,
                                height: (deviceWidth - widthDp * 60) / 2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (AuthProvider.of(context).authState.userModel!.id == null) {
                            LoginAskDialog.show(context, callback: () {
                              NormalDialog.show(
                                context,
                                title: "Bargain Request",
                                content: "Select a product/service of a store in a category. "
                                    "Make your offer and send a bargain request to the store. "
                                    "When the store accepts your offer, you can place the order.",
                                callback: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateBargainRequestPage()));
                                },
                              );
                            });
                          } else {
                            NormalDialog.show(
                              context,
                              title: "Bargain Request",
                              content: "Select a product/service of a store in a category. "
                                  "Make your offer and send a bargain request to the store. "
                                  "When the store accepts your offer, you can place the order.",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateBargainRequestPage()));
                              },
                            );
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(heightDp * 10),
                            child: Container(
                              width: (deviceWidth - widthDp * 60) / 2,
                              height: (deviceWidth - widthDp * 60) / 2,
                              child: Image.asset(
                                "img/BargainRequest1.png",
                                width: (deviceWidth - widthDp * 60) / 2,
                                height: (deviceWidth - widthDp * 60) / 2,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: widthDp * 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (AuthProvider.of(context).authState.userModel!.id == null) {
                            LoginAskDialog.show(context, callback: () {
                              NormalDialog.show(
                                context,
                                title: "Reverse Auction Request",
                                content: "Select a product/service in specific category & location. "
                                    "Quote your own price and create auction. "
                                    "Sellers will compete and you can accept the best price.",
                                callback: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateReverseAuctionPage()));
                                },
                              );
                            });
                          } else {
                            NormalDialog.show(
                              context,
                              title: "Reverse Auction Request",
                              content: "Select a product/service in specific category & location. "
                                  "Quote your own price and create auction. "
                                  "Sellers will compete and you can accept the best price.",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateReverseAuctionPage()));
                              },
                            );
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(heightDp * 10),
                            child: Container(
                              width: (deviceWidth - widthDp * 60) / 2,
                              height: (deviceWidth - widthDp * 60) / 2,
                              child: Image.asset(
                                "img/ReverseAuction1.png",
                                width: (deviceWidth - widthDp * 60) / 2,
                                height: (deviceWidth - widthDp * 60) / 2,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SizedBox(height: heightDp * 20),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
            //   child: GestureDetector(
            //     onTap: () {
            //       if (AuthProvider.of(context).authState.userModel.id == "") {
            //         LoginAskDialog.show(context, callback: () {
            //           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OrderAssistantPage()));
            //         });
            //       } else {
            //         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OrderAssistantPage()));
            //       }
            //     },
            //     child: Card(
            //       margin: EdgeInsets.zero,
            //       elevation: 5,
            //       shadowColor: Colors.black,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(heightDp * 10),
            //         child: Image.asset(
            //           "img/assistant_home.png",
            //           width: double.infinity,
            //           fit: BoxFit.fitWidth,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(height: heightDp * 20),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
            //   child: GestureDetector(
            //     onTap: () {
            //       if (AuthProvider.of(context).authState.userModel.id == "") {
            //         LoginAskDialog.show(context, callback: () {
            //           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateBargainRequestPage()));
            //         });
            //       } else {
            //         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateBargainRequestPage()));
            //       }
            //     },
            //     child: Card(
            //       margin: EdgeInsets.zero,
            //       elevation: 5,
            //       shadowColor: Colors.black,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(heightDp * 10),
            //         child: Image.asset(
            //           "img/BargainRequest.png",
            //           width: double.infinity,
            //           fit: BoxFit.fitWidth,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(height: heightDp * 20),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
            //   child: GestureDetector(
            //     onTap: () {
            //       if (AuthProvider.of(context).authState.userModel.id == "") {
            //         LoginAskDialog.show(context, callback: () {
            //           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateReverseAuctionPage()));
            //         });
            //       } else {
            //         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateReverseAuctionPage()));
            //       }
            //     },
            //     child: Card(
            //       margin: EdgeInsets.zero,
            //       elevation: 5,
            //       shadowColor: Colors.black,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(heightDp * 10),
            //         child: Image.asset(
            //           "img/ReverseAuction.png",
            //           width: double.infinity,
            //           fit: BoxFit.fitWidth,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            ///
            Divider(height: heightDp * 40, thickness: heightDp * 10, color: Colors.grey.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 5,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(heightDp * 10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(heightDp * 10),
                  child: Image.asset(
                    "img/pickup_store.png",
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            SizedBox(height: heightDp * 40),
          ],
        ),
      );
    });
  }
}
