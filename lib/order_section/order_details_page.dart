import 'dart:convert';

import 'package:ashik_enterprise/cart/my_cart_screen.dart';
import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/customer_section/model/customer_list_model.dart';
import 'package:ashik_enterprise/hive/hive_adapter.dart';
import 'package:ashik_enterprise/order_section/model/customer_due_model.dart';
import 'package:ashik_enterprise/order_section/model/product_list_model.dart';
import 'package:ashik_enterprise/provider/customer_due_provider.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:ashik_enterprise/provider/employee_provider.dart';
import 'package:ashik_enterprise/utils/const_model.dart';
import 'package:ashik_enterprise/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key,
    this.productListModel,
    this.customerListModel,
    this.customerDueAmount,
  });

  final ProductListModel? productListModel;
  final CustomerListModel? customerListModel;
  final  String? customerDueAmount;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final TextEditingController boxQtyController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  double value1 = 0.0;
  double value2 = 0.0;
  double totalValue = 0.0;
  List<Product> productListBox = [];

  String availableStock = "0";
  double? subTotal;
  @override
  void initState() {
    totalStock();
    // TODO: implement initState
    super.initState();
    productListBox = Hive.box<Product>('product').values.toList();
    productListBox.length;
  }

  Response? response;
  void totalStock() async {
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    response = await Dio().post("${baseUrl}api/v1/getProductStock",
        data: {"productId": widget.productListModel!.productSlNo},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${sharedPreferences.getString("token")}",
        }));
    setState(() {
      availableStock = "${response!.data}";
    });

    print("response========> ${response!.data}");
  }

  @override
  Widget build(BuildContext context) {
   subTotal=productListBox.map((e) => e.total).fold(0.0, (p, element) => p!+double.parse(element!));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Order Details",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20.0),
        ),
        actions: [
          GestureDetector(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                Positioned(
                    right: -8,
                    top: -10,
                    child: Container(
                        height: 15,
                        width: 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey.shade800),
                        child: Text(
                          '${productListBox.length}',
                          // ${addToCartProviderList.length}
                          style: const TextStyle(
                              // color: Color(0xffCC1A0C),
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )))
              ],
            ),
            onTap: () {
              // Navigator.push(
              //    context,
              //    MaterialPageRoute(
              //       builder: (context) => const MyCartScreen(),
              //     )).then((value){
                productListBox = Hive.box<Product>('product').values.toList();
                setState(() {

                });
             // });
            },
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: 180.0,
                          width: 180.0,
                          child: Image.network(
                            "http://ashik.expressretailbd.com/uploads/products/${widget.productListModel?.image}",
                            //fit: BoxFit.fill,
                          )),
                      Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              "Available Stock",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green.shade800),
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              availableStock,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green.shade800),
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              widget.productListModel!.unitName,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green.shade800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Product Name : ${widget.productListModel?.productName}",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Product Price  : ৳${widget.productListModel?.productSellingPrice}",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Promo Info:",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Order:",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800),
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: boxQtyController,
                      onChanged: (value) {
                        setState(() {
                          value1 = boxQtyController.text != ""
                              ? (double.parse(widget.productListModel!
                                          .productSellingPrice) *
                                      double.parse(widget
                                          .productListModel!.perUnitConvert)) *
                                  double.parse(boxQtyController.text)
                              : 0.0;
                          totalValue = value1 + value2;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Box Qty.',
                          hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500)
                          //border: OutlineInputBorder(),
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: quantityController,
                      onChanged: (value) {
                        setState(() {
                          value2 = quantityController.text != ""
                              ? (double.parse(quantityController.text) *
                                  double.parse(
                                      "${widget.productListModel?.productSellingPrice}"))
                              : 0.0;
                          totalValue = value1 + value2;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Pcs',
                          hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500)
                          //border: OutlineInputBorder(),
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Value : $totalValue",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 45.0,
        color: Colors.indigo,
        child: Row(children: [
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    emptyMethod();
                  },
                  child: const Center(
                      child: Text("CANCEL",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500))))),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    // if (availableStock != '0'
                    //     && ((double.parse(availableStock)>=double.parse(boxQtyController.text))
                    //     && double.parse(availableStock)>=double.parse(quantityController.text))) {
                    //   List<Product> productBox = Hive.box<Product>('product').values.toList();
                    //   bool isAlreadyAdded = productBox.map((e) => e.productId).contains(widget.productListModel!.productSlNo);
                    //
                    //   if (isAlreadyAdded) {
                    //     Utils.errorSnackBar(context, "Item already added to cart");
                    //     // setState(() {
                    //     //   final products = Product(
                    //     //     productId: widget.productListModel!.productSlNo,
                    //     //     productImage: widget.productListModel!.image,
                    //     //     productName: widget.productListModel!.productName,
                    //     //     salesRate: widget.productListModel!.productSellingPrice,
                    //     //     boxQuantity: boxQtyController.text==""?"0":boxQtyController.text,
                    //     //     quantity: quantityController.text==""?"0":quantityController.text,
                    //     //     total: totalValue==0.0?widget.productListModel!.productSellingPrice : "${totalValue}",
                    //     //   );
                    //     //   productBox.add(products);
                    //     //   print('askjldhfasd ${productBox.length}');
                    //     //   productListBox =
                    //     //       Hive.box<Product>('product').values.toList();
                    //     // });
                    //   }
                    //   else{
                    //     final productBox = Hive.box<Product>('product');
                    //
                    //     // if (boxQtyController.text == "") {
                    //     //   Utils.errorSnackBar(context, "Please Select Box.Qty");
                    //     // }
                    //     // if(quantityController.text == "") {
                    //     //   Utils.errorSnackBar(context, "Please Select Quantity");
                    //     // }
                    //
                    //
                    //   }
                    //   }
                      if(availableStock == '0') {
                        Utils.errorSnackBar(context, "Stock Unavailable");
                      }
                     else if (boxQtyController.text == "" && quantityController.text == "") {
                           if (boxQtyController.text == ""){
                             Utils.errorSnackBar(context, "Box.Qty & quantity is require");
                           }
                           else if (quantityController.text == ""){
                             Utils.errorSnackBar(context, "Please Select quantity");
                           }
                      }
                      // else if(boxQtyController.text!="" && double.parse(availableStock) < double.parse(boxQtyController.text)){
                      //   Utils.errorSnackBar(context, "Stock Unavailable");
                      // }
                      // else if(quantityController.text!="" && double.parse(availableStock) < double.parse(quantityController.text)){
                      //   Utils.errorSnackBar(context, "Stock Unavailable");
                      //}
                      else{
                        final productBox = Hive.box<Product>('product');
                        setState(() {
                          final products = Product(
                            productId: widget.productListModel!.productSlNo,
                            productImage: widget.productListModel!.image,
                            productName: widget.productListModel!.productName,
                            purchaseRate:widget.productListModel!.productPurchaseRate,
                            salesRate: widget.productListModel!.productSellingPrice,
                            boxQuantity: boxQtyController.text==""?"0":boxQtyController.text,
                            quantity: quantityController.text==""?"0":quantityController.text,
                            total: totalValue == 0.0 ? widget.productListModel!.productSellingPrice : "$totalValue",
                          );
                          productBox.add(products).then((value){
                            Utils.showSnackBar(context, "Cart added successfully",Colors.white);
                          });
                          productListBox = Hive.box<Product>('product').values.toList();
                        });
                        emptyMethod();
                      }
                  },  
                  child: const Center(
                      child: Text("CONFIRM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                          ),
                      ),
                  ),
              ),
          ),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOrderBtnClk = true;
                    });
                    addOrder();
                  },
                  child: const Center(
                      child: Text("ORDER",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500))))),
        ]),
      ),
    );
  }
  emptyMethod() {
    setState(() {
      boxQtyController.text = "";
      quantityController.text = "";
      totalValue = 0.0;
    });
  }
  addOrder() async {
    String link = "${baseUrl}api/v1/addOder";
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    print("cccccccccccccccccccc ${widget.customerListModel?.customerSlNo}");
    print("eeeeeeeeeeeeeeeeeeee ${sharedPreferences.getString('employee_id')}");
    print("ssssssssssssssssssss ${subTotal}");
    print("dddddddddddddddddddd ${widget.customerDueAmount}");
    try {
      var productBox = productListBox.map((e) {
        return {
            "productId":e.productId,
            "quantity": e.quantity,
            "purchaseRate": e.purchaseRate,
            "salesRate": e.salesRate,
            "total": e.total,
        };
      }).toList();
      Response response = await Dio().post(
        link,
        data: {
          "order": {
            "customerId": "${widget.customerListModel?.customerSlNo}",
            "employeeId": "${sharedPreferences.getString('employee_id')}",
            "subTotal": "${subTotal}",
            "prevDue": "${widget.customerDueAmount}"
          },
          "cart": productBox,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${sharedPreferences.getString("token")}",
        }),
      );
      print(response.data);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        print("asdfasfe sdfgdsf");
        // productListBox = Hive.box<Product>('product').values.toList();

        productListBox.clear();
        productBox.clear();
        Hive.box<Product>('product').clear();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {
          isOrderBtnClk = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.black,
            content: Center(
              child: Text(
                "${item["message"]}",
                style: const TextStyle(color: Colors.white),
              ),
            )));
      } else {
        setState(() {
          isOrderBtnClk = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.black,
            content: Center(
              child: Text(
                "${item["message"]}",
                style: const TextStyle(color: Colors.red),
              ),
            )));
      }
    } catch (e) {
      print("asdfasfe $e");

      setState(() {
        isOrderBtnClk = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.black,
          content: Center(
            child: Text(
              e.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          )));
    }
  }
  bool isOrderBtnClk = false;
}
