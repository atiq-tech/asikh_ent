import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/order_section/model/customer_due_model.dart';
import 'package:ashik_enterprise/order_section/model/product_list_model.dart';
import 'package:ashik_enterprise/order_section/order_details_page.dart';
import 'package:ashik_enterprise/provider/all_category_provider.dart';
import 'package:ashik_enterprise/provider/customer_due_provider.dart';
import 'package:ashik_enterprise/provider/product_list_provider.dart';
import 'package:ashik_enterprise/utils/const_model.dart';
import 'package:ashik_enterprise/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../customer_section/model/customer_list_model.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, this.customerListModel, });
  final CustomerListModel? customerListModel;


  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  ScrollController? _iscrollController;

  @override
  void initState() {
    _iscrollController = ScrollController();
    _iscrollController?.addListener(_scrollListener);
    super.initState();
    Provider.of<AllCategoryProvider>(context,listen: false).getCategory();
    Provider.of<ProductListProvider>(context,listen: false).getProduct('', "");
    Provider.of<CustomerDueProvider>(context,listen: false).getCustomerDue(widget.customerListModel!.customerSlNo);

  }
  _scrollListener() {
    if (_iscrollController!.offset >= 100) {
      print("Buttom++++");

      setState(() {
        heightt = 800;
      });
    }
    if (_iscrollController!.offset <= _iscrollController!.position.minScrollExtent &&
        !_iscrollController!.position.outOfRange) {
        print("Top++++");

      setState(() {
        heightt = 660;
      });
    }
  }

  double heightt = 660;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _iscrollController.
  }
  
  @override
  Widget build(BuildContext context) {
    final allCategoryData = Provider.of<AllCategoryProvider>(context).allCategoryList;

    final allCustomerDue = Provider.of<CustomerDueProvider>(context).customerDueList.where((element) 
    => widget.customerListModel!.customerSlNo == element.customerSlNo).toList();
    
    print('asdfhasdjk ${allCustomerDue.length}');
    // ModalProgressHUD(
    //     blur: 2,
    //     inAsyncCall: CustomerListProvider.isCustomerTypeChange||CategoryWiseProductProvider.isCustomerTypeChange,
    //     progressIndicator: Utils.showSpinKitLoad(),
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(title: "Order List"),
      body: Column(children: [
        const SizedBox(
          height: 5.0,
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Address : ${widget.customerListModel!.customerAddress}"),
              Text("Previous Due : ${allCustomerDue.map((e) => e.dueAmount)}".replaceAll("(", "").replaceAll(")", "")),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Customer : ${widget.customerListModel!.customerName}"),
              Text("${widget.customerListModel!.customerMobile}"),
            ],
          ),
        ),
        const Divider(
          thickness: 2.0,
          color: Colors.indigo,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
            child: GridView.builder(
              itemCount: allCategoryData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                crossAxisSpacing: 15.0, // Spacing between columns
                mainAxisSpacing: 25.0, // Spacing between rows
              ),
              itemBuilder: (context, index) {
                // Build the individual grid item
                return GestureDetector(
                  onTap: () {
                    Utils.loadingDialog(context);
                    var data = Provider.of<ProductListProvider>(context,listen: false).getProduct(allCategoryData[index].productCategorySlNo, "").then((value){

                      Utils.closeDialog(context);

                        if(value.isNotEmpty){
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(builder: (context, setState) {
                                return Container(
                                    height: MediaQuery.of(context).size.height * 0.8,
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
                                      child: GridView.builder(
                                        controller: _iscrollController,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3, // Number of columns in the grid
                                            crossAxisSpacing:15.0, // Spacing between columns
                                            mainAxisSpacing: 15.0,
                                            mainAxisExtent: 150.0// Spacing between rows
                                        ),
                                        itemBuilder: (context, index) {
                                          // Build the individual grid item
                                          return GestureDetector(

                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderDetailsPage(
                                                productListModel: value[index],
                                               customerListModel: widget.customerListModel,
                                               customerDueAmount: "${allCustomerDue.map((e) => e.dueAmount)}".replaceAll("(", "").replaceAll(")", "")
                                              ),));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: const Offset(
                                                        0, 1), // changes the position of the shadow
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex:5,
                                                    child: Container(
                                                        child: Image.network("http://ashik.expressretailbd.com/uploads/products/${value[index].image}",fit: BoxFit.cover,)
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex:3,
                                                    child: Container(
                                                      color: Colors.blue.shade50,
                                                      child: Center(child: Column(
                                                        children: [
                                                          const SizedBox(height: 8.0,),
                                                          Text('${value[index].productName}',overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 12.0),),
                                                          Text('Price : ৳${value[index].productSellingPrice}',style: const TextStyle(fontSize: 12.0),),
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: value.length, // Number of items in the grid
                                      ),
                                    ));
                              },);
                            },
                          );
                        }
                      });

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(
                              0, 1), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Center(child: Text("${allCategoryData[index].productCategoryName}")),
                  ),
                );
              }, // Number of items in the grid
            ),
          ),
        ),
      ]),
    );
  }
}
