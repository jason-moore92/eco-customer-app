import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trapp/src/dialogs/index.dart';
import 'package:trapp/src/elements/keicy_text_form_field.dart';
import 'package:trapp/config/app_config.dart' as config;
import 'package:trapp/src/helpers/price_functions.dart';
import 'package:trapp/src/helpers/price_functions1.dart';
import 'package:trapp/src/models/index.dart';
import 'package:trapp/src/providers/index.dart';

class PromocodePanel extends StatefulWidget {
  final OrderModel? orderModel;
  final Function? refreshCallback;
  final bool? isReadOnly;
  final List? typeList;
  final bool? isForAssistant;

  PromocodePanel({
    @required this.orderModel,
    @required this.refreshCallback,
    this.isReadOnly = false,
    this.typeList = const [],
    this.isForAssistant = false,
  });

  @override
  _PromocodePanelState createState() => _PromocodePanelState();
}

class _PromocodePanelState extends State<PromocodePanel> {
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

  TextEditingController _promocodeController = TextEditingController();
  FocusNode _promocodeFocusNode = FocusNode();

  PromocodeProvider? _promocodeProvider;

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

    _promocodeProvider = PromocodeProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orderModel!.promocode == null) _promocodeController.clear();

    return Consumer<PromocodeProvider>(builder: (context, promocodeProvider, _) {
      bool isReadOnly = widget.isReadOnly!;
      if (widget.orderModel!.storeModel != null &&
          (promocodeProvider.promocodeState.promocodeData![widget.orderModel!.storeModel!.subType] == null ||
              promocodeProvider.promocodeState.promocodeData![widget.orderModel!.storeModel!.subType].isEmpty)) {
        isReadOnly = true;
        _promocodeProvider!.setPromocodeState(_promocodeProvider!.promocodeState.update(progressState: 0), isNotifiable: false);
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: widthDp * 15, vertical: heightDp * 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Do you have a Promo code?",
              style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w500),
            ),
            Text(
              "Apply to get discount",
              style: TextStyle(fontSize: fontSp * 12, color: Colors.grey.withOpacity(1)),
            ),
            SizedBox(height: heightDp * 10),
            Row(
              children: [
                Expanded(
                  child: KeicyTextFormField(
                    controller: _promocodeController,
                    focusNode: _promocodeFocusNode,
                    width: null,
                    height: heightDp * 40,
                    autofocus: false,
                    readOnly: isReadOnly || widget.orderModel!.promocode != null,
                    border: Border.all(color: Colors.grey.withOpacity(0.6)),
                    borderRadius: heightDp * 6,
                    textStyle: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                    hintStyle: TextStyle(fontSize: fontSp * 14, color: Colors.grey.withOpacity(0.6)),
                    hintText: "Promocode",
                  ),
                ),
                SizedBox(width: widthDp * 10),
                GestureDetector(
                  onTap: _promocodeHandler,
                  child: Container(
                    height: heightDp * 40,
                    padding: EdgeInsets.symmetric(
                      horizontal: widthDp * 15,
                    ),
                    decoration: BoxDecoration(
                      color: isReadOnly ? Colors.grey.withOpacity(0.6) : config.Colors().mainColor(1),
                      borderRadius: BorderRadius.circular(heightDp * 6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.orderModel!.promocode != null ? "Cancel" : "Apply",
                      style: TextStyle(fontSize: fontSp * 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void _promocodeHandler() {
    if (widget.isReadOnly! || _promocodeController.text.isEmpty) return;

    FocusScope.of(context).requestFocus(FocusNode());

    if (widget.orderModel!.promocode != null) {
      widget.orderModel!.promocode = null;
      _promocodeController.clear();
      widget.refreshCallback!();
      return;
    }
    widget.orderModel!.promocode = null;

    String message = "This promocode is wrong or is not valid for this type of order";

    double totalOriginPrice = PriceFunctions1.getTotalOrignPrice(orderModel: widget.orderModel!);

    for (var i = 0; i < _promocodeProvider!.promocodeState.promocodeData![widget.orderModel!.storeModel!.subType].length; i++) {
      var data = _promocodeProvider!.promocodeState.promocodeData![widget.orderModel!.storeModel!.subType][i];
      DateTime startDT = DateTime.parse(data["validityStartDate"]);
      if (startDT.isUtc) startDT = startDT.toLocal();
      DateTime endDT = DateTime.parse(data["validityEndDate"]);
      if (endDT.isUtc) endDT = endDT.toLocal();
      if (data["promocodeCode"] == _promocodeController.text.trim() &&
          startDT.isBefore(DateTime.now()) &&
          endDT.isAfter(DateTime.now()) &&
          (widget.typeList!.isEmpty || widget.typeList!.contains(data["promocodeType"]))) {
        if (widget.isForAssistant!) {
          widget.orderModel!.promocode = data;
          break;
        } else {
          if (data["minimumorder"] != null && totalOriginPrice < double.parse(data["minimumorder"].toString())) {
            message = "To apply this code minimum order is ${data["minimumorder"]}.";
            widget.orderModel!.promocode = null;
          } else {
            widget.orderModel!.promocode = PromocodeModel.fromJson(data);
          }

          // /// for test
          // widget.orderModel!.promocode = data;
          break;
        }
      }
    }

    if (widget.orderModel!.promocode == null) {
      _promocodeController.clear();
      ErrorDialog.show(
        context,
        heightDp: heightDp,
        fontSp: fontSp,
        text: message,
        widthDp: widthDp,
        callBack: null,
        isTryButton: false,
      );
    } else {
      SuccessDialog.show(context, heightDp: heightDp, fontSp: fontSp, text: "Added Promocode successfully");
    }
    widget.refreshCallback!();
  }
}
