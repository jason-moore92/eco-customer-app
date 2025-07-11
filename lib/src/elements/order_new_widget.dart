import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/src/dialogs/index.dart';
import 'package:trapp/src/elements/keicy_avatar_image.dart';
import 'package:trapp/src/elements/keicy_raised_button.dart';
import 'package:trapp/src/helpers/date_time_convert.dart';
import 'package:trapp/src/models/index.dart';
import 'package:trapp/src/providers/index.dart';
import 'package:trapp/config/app_config.dart' as config;
import 'package:url_launcher/url_launcher.dart';

import 'keicy_checkbox.dart';

class OrderNewWidget extends StatefulWidget {
  final OrderModel? orderModel;
  final bool? loadingStatus;
  final Function()? cancelCallback;
  final Function? detailCallback;
  final Function()? payCallback;
  final bool? showButton;

  OrderNewWidget({
    @required this.orderModel,
    @required this.loadingStatus,
    @required this.cancelCallback,
    @required this.payCallback,
    @required this.detailCallback,
    this.showButton = true,
  });

  @override
  _OrderNewWidgetState createState() => _OrderNewWidgetState();
}

class _OrderNewWidgetState extends State<OrderNewWidget> {
  /// Responsive design variables
  double? deviceWidth;
  double? deviceHeight;
  double? statusbarHeight;
  double? bottomBarHeight;
  double? appbarHeight;
  double? widthDp;
  double? heightDp;
  double? heightDp1;
  double? fontSp;

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
    heightDp1 = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1) / ScreenUtil().textScaleFactor;

    ///////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: widthDp! * 15,
        right: widthDp! * 15,
        top: heightDp! * 5,
        bottom: heightDp! * 10,
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: widthDp! * 20, vertical: heightDp! * 10),
        color: Colors.transparent,
        child: widget.loadingStatus! ? _shimmerWidget() : _orderWidget(),
      ),
    );
  }

  Widget _shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      direction: ShimmerDirection.ltr,
      enabled: widget.loadingStatus!,
      period: Duration(milliseconds: 1000),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: widthDp! * 70,
                height: widthDp! * 70,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(heightDp! * 6)),
              ),
              SizedBox(width: widthDp! * 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Store Name",
                        style: TextStyle(fontSize: fontSp! * 14, fontWeight: FontWeight.bold, color: Colors.transparent),
                      ),
                    ),
                    SizedBox(height: heightDp! * 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Text(
                            'Order Id 123123',
                            style: TextStyle(fontSize: fontSp! * 12, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Text(
                            '2021-05-65',
                            style: TextStyle(fontSize: fontSp! * 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heightDp! * 5),
                    Container(
                      color: Colors.white,
                      child: Text(
                        "order city",
                        style: TextStyle(fontSize: fontSp! * 11, color: Colors.transparent),
                      ),
                    ),
                    SizedBox(height: heightDp! * 5),
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Store address sfsdf",
                        style: TextStyle(fontSize: fontSp! * 11, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: heightDp! * 15, thickness: 1, color: Colors.grey.withOpacity(0.6)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: widthDp! * 10, vertical: heightDp! * 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(heightDp! * 6),
                    bottomRight: Radius.circular(heightDp! * 6),
                  ),
                ),
                child: Text(
                  "Not Paid",
                  style: TextStyle(fontSize: fontSp! * 14, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: heightDp! * 10),

          ///
          Column(
            children: [
              Container(
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Order Status:   ",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        "orderStatus",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///
          SizedBox(height: heightDp! * 7),
          Column(
            children: [
              Container(
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Order Type:   ",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        "pick up",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///
          Column(
            children: [
              SizedBox(height: heightDp! * 7),
              Container(
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Pickup Date:  ",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        "2021-05-26",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///
          SizedBox(height: heightDp! * 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                child: Text(
                  "To Pay: ",
                  style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                color: Colors.white,
                child: Text(
                  "₹ 4163.25",
                  style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderWidget() {
    String orderStatus = "";
    for (var i = 0; i < AppConfig.orderStatusData.length; i++) {
      if (AppConfig.orderStatusData[i]["id"] == widget.orderModel!.status) {
        orderStatus = AppConfig.orderStatusData[i]["name"];
        break;
      }
    }

    var distnce = Geolocator.distanceBetween(
      AppDataProvider.of(context).appDataState.currentLocation!["location"]["lat"],
      AppDataProvider.of(context).appDataState.currentLocation!["location"]["lng"],
      widget.orderModel!.storeModel!.location!.latitude,
      widget.orderModel!.storeModel!.location!.longitude,
    );

    return GestureDetector(
      onTap: () {
        if (AuthProvider.of(context).authState.loginState == LoginState.IsNotLogin) {
          LoginAskDialog.show(context);
        } else {
          widget.detailCallback!();
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                KeicyAvatarImage(
                  url: widget.orderModel!.storeModel!.profile!["image"],
                  width: widthDp! * 70,
                  height: widthDp! * 70,
                  backColor: Colors.grey.withOpacity(0.4),
                  borderRadius: heightDp! * 6,
                  errorWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(heightDp! * 6),
                    child: Image.asset(
                      "img/store-icon/${widget.orderModel!.storeModel!.subType!.toLowerCase()}-store.png",
                      width: widthDp! * 70,
                      height: widthDp! * 70,
                    ),
                  ),
                ),
                SizedBox(width: widthDp! * 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.orderModel!.storeModel!.name} Store",
                        style: TextStyle(fontSize: fontSp! * 14, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: heightDp! * 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.orderModel!.orderId!,
                            style: TextStyle(fontSize: fontSp! * 12, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            KeicyDateTime.convertDateTimeToDateString(
                              dateTime: widget.orderModel!.updatedAt,
                              formats: "Y-m-d H:i",
                              isUTC: false,
                            ),
                            style: TextStyle(fontSize: fontSp! * 12, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: heightDp! * 5),
                      Row(
                        children: [
                          Text(
                            '${widget.orderModel!.storeModel!.city}',
                            style: TextStyle(fontSize: fontSp! * 11, color: Colors.black),
                          ),
                          // SizedBox(width: widthDp * 15),
                          // Text(
                          //   '${((widget.orderModel.storeModel.distance ?? 0) / 1000).toStringAsFixed(3)}Km',
                          //   style: TextStyle(fontSize: fontSp * 11, color: Colors.black),
                          // ),
                        ],
                      ),
                      SizedBox(height: heightDp! * 5),
                      Text(
                        "${widget.orderModel!.storeModel!.address}",
                        style: TextStyle(fontSize: fontSp! * 11, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // SizedBox(height: heightDp * 5),
                      // Container(
                      //   width: widthDp * 100,
                      //   padding: EdgeInsets.symmetric(horizontal: widthDp * 10, vertical: heightDp * 5),
                      //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(heightDp * 5), color: orderTypeColor.withOpacity(0.4)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(Icons.star, size: heightDp * 15, color: orderTypeColor),
                      //       SizedBox(width: widthDp * 5),
                      //       Text(
                      //         "${widget.orderModel.storeModel["type"]}",
                      //         style: TextStyle(fontSize: fontSp * 11, color: Colors.black),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: widthDp * 10, top: heightDp * 10, bottom: heightDp * 10),
                //   child: Icon(Icons.arrow_forward_ios, size: heightDp * 20, color: Colors.black),
                // ),
              ],
            ),
            Divider(height: heightDp! * 15, thickness: 1, color: Colors.grey.withOpacity(0.6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: widthDp! * 10, vertical: heightDp! * 5),
                  decoration: BoxDecoration(
                    color: widget.orderModel!.payStatus! ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(heightDp! * 6),
                      bottomRight: Radius.circular(heightDp! * 6),
                    ),
                  ),
                  child: Text(
                    widget.orderModel!.payStatus! ? "Paid" : "Not Paid",
                    style: TextStyle(fontSize: fontSp! * 14, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunch(widget.orderModel!.invoicePdfUrl!)) {
                          await launch(
                            widget.orderModel!.invoicePdfUrl!,
                            forceSafariVC: false,
                            forceWebView: false,
                          );
                        } else {
                          throw 'Could not launch ${widget.orderModel!.invoicePdfUrl}';
                        }
                      },
                      child: Image.asset("img/pdf-icon.png", width: heightDp! * 30, height: heightDp! * 30, fit: BoxFit.cover),
                    ),
                    SizedBox(width: widthDp! * 30),
                    GestureDetector(
                      onTap: () {
                        Share.share(widget.orderModel!.invoicePdfUrl!);
                      },
                      child: Image.asset(
                        "img/share-icon.png",
                        width: heightDp! * 30,
                        height: heightDp! * 30,
                        fit: BoxFit.cover,
                        color: config.Colors().mainColor(1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: heightDp! * 10),

            ///
            Column(
              children: [
                Container(
                  width: deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Status:   ",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        orderStatus,
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///
            SizedBox(height: heightDp! * 7),
            Column(
              children: [
                Container(
                  width: deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Type:   ",
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.orderModel!.orderType!,
                        style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///
            widget.orderModel!.products!.isEmpty || widget.orderModel!.orderType != "Pickup" || widget.orderModel!.pickupDateTime == null
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(height: heightDp! * 7),
                      Container(
                        width: deviceWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pickup Date:  ",
                              style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              KeicyDateTime.convertDateTimeToDateString(
                                dateTime: widget.orderModel!.pickupDateTime,
                                formats: 'Y-m-d h:i A',
                                isUTC: false,
                              ),
                              style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

            ///
            widget.orderModel!.products!.isEmpty || widget.orderModel!.orderType != "Delivery" || widget.orderModel!.deliveryAddress == null
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(height: heightDp! * 7),
                      Container(
                        width: deviceWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address:  ",
                              style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: heightDp! * 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${widget.orderModel!.deliveryAddress!.addressType}",
                                      style: TextStyle(fontSize: fontSp! * 12, color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: widthDp! * 10),
                                    Text(
                                      "${(widget.orderModel!.deliveryAddress!.distance! / 1000).toStringAsFixed(3)} Km",
                                      style: TextStyle(fontSize: fontSp! * 12, color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: heightDp! * 5),
                                widget.orderModel!.deliveryAddress!.building == ""
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Text(
                                            "${widget.orderModel!.deliveryAddress!.building}",
                                            style: TextStyle(fontSize: fontSp! * 12, color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: heightDp! * 5),
                                        ],
                                      ),
                                Text(
                                  "${widget.orderModel!.deliveryAddress!.address!.address}",
                                  style: TextStyle(fontSize: fontSp! * 12, color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: heightDp! * 7),
                                KeicyCheckBox(
                                  iconSize: heightDp! * 20,
                                  iconColor: Color(0xFF00D18F),
                                  labelSpacing: widthDp! * 10,
                                  label: "No Contact Delivery",
                                  labelStyle: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w500),
                                  value: widget.orderModel!.noContactDelivery!,
                                  readOnly: true,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

            ///
            widget.orderModel!.services!.isEmpty || widget.orderModel!.serviceDateTime == null
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(height: heightDp! * 7),
                      Container(
                        width: deviceWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Servie Date:  ",
                              style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              KeicyDateTime.convertDateTimeToDateString(
                                dateTime: widget.orderModel!.serviceDateTime,
                                formats: 'Y-m-d h:i A',
                                isUTC: false,
                              ),
                              style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

            ///
            SizedBox(height: heightDp! * 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "To Pay: ",
                  style: TextStyle(fontSize: fontSp! * 14, color: Colors.black, fontWeight: FontWeight.w600),
                ),
                Text(
                  "₹ ${widget.orderModel!.paymentDetail!.toPay}",
                  style: TextStyle(fontSize: fontSp! * 14, color: Colors.black),
                ),
              ],
            ),

            if (widget.showButton!)
              Divider(
                height: heightDp! * 15,
                thickness: 1,
                color: Colors.grey.withOpacity(0.6),
              )
            else
              SizedBox(),

            ///
            if (!widget.showButton!)
              SizedBox()
            else if (widget.showButton! && AppConfig.orderStatusData[1]["id"] == widget.orderModel!.status)
              _placeOrderActionButtonGroup()
            else if (widget.showButton! && AppConfig.orderStatusData[2]["id"] == widget.orderModel!.status)
              _acceptOrderActionButtonGroup(showCancel: true)
            else if (widget.showButton! && AppConfig.orderStatusData[4]["id"] == widget.orderModel!.status)
              _acceptOrderActionButtonGroup(showCancel: false)
            else if (widget.showButton! && AppConfig.orderStatusData[5]["id"] == widget.orderModel!.status)
              _acceptOrderActionButtonGroup(showCancel: false)
            else
              SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _placeOrderActionButtonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        KeicyRaisedButton(
          width: widthDp! * 130,
          height: heightDp! * 30,
          color: config.Colors().mainColor(1),
          borderRadius: heightDp! * 8,
          padding: EdgeInsets.symmetric(horizontal: widthDp! * 5),
          child: Text(
            "Cancel Order",
            style: TextStyle(fontSize: fontSp! * 14, color: Colors.white),
          ),
          onPressed: widget.cancelCallback,
        ),
      ],
    );
  }

  Widget _acceptOrderActionButtonGroup({showCancel = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (!widget.orderModel!.payAtStore! && !widget.orderModel!.cashOnDelivery!)
          KeicyRaisedButton(
            width: widthDp! * 130,
            height: heightDp! * 30,
            color: config.Colors().mainColor(1),
            borderRadius: heightDp! * 8,
            padding: EdgeInsets.symmetric(horizontal: widthDp! * 5),
            child: Text(
              "Pay this Order",
              style: TextStyle(fontSize: fontSp! * 14, color: Colors.white),
            ),
            onPressed: widget.payCallback,
          ),
        if (showCancel)
          KeicyRaisedButton(
            width: widthDp! * 130,
            height: heightDp! * 30,
            color: config.Colors().mainColor(1),
            borderRadius: heightDp! * 8,
            padding: EdgeInsets.symmetric(horizontal: widthDp! * 5),
            child: Text(
              "Cancel Order",
              style: TextStyle(fontSize: fontSp! * 14, color: Colors.white),
            ),
            onPressed: widget.cancelCallback,
          ),
      ],
    );
  }
}
