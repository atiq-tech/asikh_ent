import 'package:ashik_enterprise/customer_section/model/customer_list_model.dart';
import 'package:ashik_enterprise/order_section/model/product_list_model.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:ashik_enterprise/sreens/model/user_data_model.dart';
import 'package:ashik_enterprise/sreens/order_list_screen.dart';
import 'package:ashik_enterprise/utils/const_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutletList extends StatefulWidget {
  const OutletList({super.key,
    this.customerListModel,
    this.totatOrderValue,
    });
  final  CustomerListModel? customerListModel;
  final  totatOrderValue;

  @override
  State<OutletList> createState() => _OutletListState();
}

class _OutletListState extends State<OutletList> {
  final customerNameController = TextEditingController();
  String search="";
  String level = "Ordered";
  bool yetToVisit = true;
  bool ordered =true;
  bool notOrdered = false;
  List searchList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: "");
  }
  @override
  Widget build(BuildContext context) {
    final allCustomerData=Provider.of<CustomerListProvider>(context).customerList.where((element) => element.customerName!=null).toList();

    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 22.0,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "Outlet List",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(text: "Ordered Value: ",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.grey.shade800),
                    children:  [
                      TextSpan(text: "${widget.totatOrderValue}",style: TextStyle(color: Colors.purple,fontSize: 18.0))
                    ]),
                  ),
                  RichText(
                    text:  TextSpan(text: "LPC: ",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.grey.shade800),
                        children: const [
                          TextSpan(text: "100",style: TextStyle(color: Colors.blue,fontSize: 18.0))
                        ]),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2,color:  Colors.indigo,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child:  Text(
                "Section",
                style: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.grey.shade800),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "MOULOBI BAZAR-A+C",
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.indigo),
                  ),
                  Text(
                    "MONDAY",
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.indigo),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2,color:  Colors.red,),
            Row(
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.005,
                      child: Radio(
                          fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                            Colors.red,
                          ),
                          value: "Yet to visit",
                          groupValue: level,
                          onChanged: (value) {
                            setState(() {
                              yetToVisit=true;
                              ordered=false;
                              notOrdered=false;
                              level = value.toString();
                            Future.delayed(const Duration(seconds: 2),() {
                                setState(() {
                                  // isCustomerTypeChange = false;
                                });
                              },);
                            });
                          }),
                    ),
                  Text("Yet to visit",
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w500, color: Colors.grey.shade900),),
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.005,
                      child: Radio(
                          fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                                Colors.red,
                          ),
                          value: "Ordered",
                          groupValue: level,
                          onChanged: (value) {
                            setState(() {
                              yetToVisit=false;
                              ordered=true;
                              notOrdered=false;
                              level = value.toString();
                              Future.delayed(const Duration(seconds: 2),() {
                                setState(() {
                                  // isCustomerTypeChange = false;
                                });
                              },);
                            });
                          }),
                    ),
                    Text("Ordered",
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w500, color: Colors.grey.shade900),),
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.005,
                      child: Radio(
                          fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                            Colors.red,
                          ),
                          value: "Not Ordered",
                          groupValue: level,
                          onChanged: (value) {
                            setState(() {
                              yetToVisit=false;
                              ordered=false;
                              notOrdered=true;
                              level = value.toString();
                            Future.delayed(const Duration(seconds: 2),() {
                                setState(() {
                                  // isCustomerTypeChange = false;
                                });
                              },);
                            });
                          }),
                    ),
                     Text("Not Ordered",
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w500, color: Colors.grey.shade900),),
                  ],
                ),
              ],),
         Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Outlets (${allCustomerData.length})",
                style: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.grey.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
              child: SizedBox(
                height: 45.0,
                child:TextField(
                  style: const TextStyle(fontSize: 13),
                  controller: customerNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 6),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Search Customer Name',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14.0),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                      search = value.toString();
                      setState((){
                          for(final product in allCustomerData){
                            if(product.customerName!.toLowerCase().contains(search.toLowerCase())){
                              searchList.add(product);
                              // searchList.toSet().toList();
                            }else {
                              searchList.remove(product);
                              // searchList.toSet().toList();
                            }
                          }
                      });

                  },
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                // if(yetToVisit){
                //   return Container(
                //     height: MediaQuery.of(context).size.height,
                //     width: MediaQuery.of(context).size.width,
                //     padding: const EdgeInsets.all(10),
                //     child: GridView.builder(
                //         //physics: const NeverScrollableScrollPhysics(),
                //         itemCount: allCustomerData.length,
                //         gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 3,
                //           mainAxisSpacing: 8,
                //           crossAxisSpacing: 8,
                //           mainAxisExtent: 120,
                //         ),
                //         itemBuilder: (context, index) {
                //           if(customerNameController.text.isEmpty){
                //             return Container(
                //               child: GestureDetector(
                //                 onTap: () {
                //                   Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderListScreen(),));
                //                 },
                //                 child:  Card(
                //                   shape: const RoundedRectangleBorder(
                //                       borderRadius:
                //                       BorderRadius.all(Radius.circular(5))),
                //                   color: Colors.blueGrey.shade100,
                //                   // color: Colors.yellow.shade100,
                //                   elevation: 9.00,
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(5.0),
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Text(
                //                           "${allCustomerData[index].customerName}",
                //                           textAlign: TextAlign.center,
                //                           style: const TextStyle(
                //                               fontSize: 13.2,
                //                               color: Colors.black54,
                //                               fontWeight: FontWeight.w500
                //                           ),
                //                         ),
                //                         Text(
                //                           "${allCustomerData[index].customerAddress}",
                //                           textAlign: TextAlign.center,
                //                           style: const TextStyle(
                //                               fontSize: 13.2,
                //                               color: Colors.black54,
                //                               fontWeight: FontWeight.w500
                //                           ),
                //                         ),
                //                         Text(
                //                           "${allCustomerData[index].customerMobile}",
                //                           textAlign: TextAlign.center,
                //                           style: const TextStyle(
                //                               fontSize: 13.2,
                //                               color: Colors.black54,
                //                               fontWeight: FontWeight.w500
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           }else if("${allCustomerData[index].customerName}".toLowerCase().contains(customerNameController.text.toLowerCase())){
                //             return Container(
                //               child: GestureDetector(
                //                 onTap: () {
                //                   Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderListScreen(),));
                //                 },
                //                 child:  Card(
                //                   shape: const RoundedRectangleBorder(
                //                       borderRadius:
                //                       BorderRadius.all(Radius.circular(5))),
                //                   color: Colors.blueGrey.shade100,
                //                   // color: Colors.yellow.shade100,
                //                   elevation: 9.00,
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(5.0),
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Text(
                //                           "${allCustomerData[index].customerName}",
                //                           textAlign: TextAlign.center,
                //                           style: const TextStyle(
                //                               fontSize: 13.2,
                //                               color: Colors.black54,
                //                               fontWeight: FontWeight.w500
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           }
                //           return Container();
                //         }),
                //   );
                // }
                if(ordered){
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchList.isNotEmpty
                            ? searchList.toSet().toList().length
                            : allCustomerData.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 120,
                        ),
                        itemBuilder: (context, index) {
                          if(customerNameController.text.isEmpty){
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderListScreen(
                                  customerListModel: allCustomerData[index],

                                ),));
                              },
                              child:  Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                color: Colors.blueGrey.shade100,
                                // color: Colors.yellow.shade100,
                                elevation: 9.00,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${allCustomerData[index].customerName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        "${allCustomerData[index].customerAddress}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        "${allCustomerData[index].customerMobile}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          else if(searchList.isNotEmpty){
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderListScreen(
                                  customerListModel: searchList[index],
                                ),));
                              },
                              child:  Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                color: Colors.blueGrey.shade100,
                                // color: Colors.yellow.shade100,
                                elevation: 9.00,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${searchList[index].customerName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        "${searchList[index].customerAddress}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        "${searchList[index].customerMobile}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        }),
                  );
                }
                if(notOrdered){
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 120,
                        ),
                        itemBuilder: (context, index) {
                          if(customerNameController.text.isEmpty){
                            return Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderListScreen(
                                    customerListModel: allCustomerData[index],
                                  ),));
                                },
                                child:  Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                  color: Colors.blueGrey.shade100,
                                  // color: Colors.yellow.shade100,
                                  elevation: 9.00,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${allCustomerData[index].customerName}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 13.2,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          "${allCustomerData[index].customerAddress}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 13.2,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          "${allCustomerData[index].customerMobile}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 13.2,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          else if("${allCustomerData[index].customerName}".toLowerCase().contains(customerNameController.text.toLowerCase())){
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderListScreen(
                                  customerListModel: allCustomerData[index],
                                ),));
                              },
                              child:  Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                color: Colors.blueGrey.shade100,
                                // color: Colors.yellow.shade100,
                                elevation: 9.00,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${allCustomerData[index].customerName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        }),
                  );
                }
              return Container();
            },),
            const SizedBox(height: 50.0,)
          ],
        ),
      ),
    );
  }
}
