import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/customer_section/model/area_model.dart';
import 'package:ashik_enterprise/customer_section/model/customer_list_model.dart';
import 'package:ashik_enterprise/customer_section/model/employee_model.dart';
import 'package:ashik_enterprise/provider/area_provider.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:ashik_enterprise/provider/product_list_provider.dart';
import 'package:ashik_enterprise/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../provider/employee_provider.dart';

class OrderEntryPage extends StatefulWidget {
  const OrderEntryPage({super.key});

  @override
  State<OrderEntryPage> createState() => _OrderEntryPageState();
}

class _OrderEntryPageState extends State<OrderEntryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _discountPercentController = TextEditingController();
  final TextEditingController _previousDueController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _salesRateController = TextEditingController();
  final TextEditingController _DiscountController = TextEditingController();
  final TextEditingController _VatController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _transportController = TextEditingController();
  var customerController = TextEditingController();
  var empluyeeNameController = TextEditingController();
  var areaController = TextEditingController();
  var categoryController = TextEditingController();
  var productController = TextEditingController();
  var bankController = TextEditingController();
  var customerSlNo;

  String? Salling_Rate = "0.0";
  String? customerMobile;
  String? customerAddress;
  String? categoryId;
  String? _selectedSalesBy;
  String? _selectedCustomer;
  String? _selectedCategory;
  String? _selectedProduct;
  String? employeeSlNo;
  String? areaSlNo;
  String? previousDue;
  String level = "retail";
  String availableStock = "0";
  double subtotal = 0;
  double CartTotal = 0;
  double TotalVat = 0;
  double totalDue = 0;
  double totalDueTc = 0;
  double Totaltc = 0;
  double DiccountTotal = 0;
  double TransportTotal = 0;
  double Diccountper = 0;
  double AfteraddVatTotal = 0;
 // List<SalesApiModelClass> salesCartList = [];

  String? cproductId;
  String? ccategoryName;
  String? cname;
  String? csalesRate;
  String? cvat;
  String? cquantity;
  String? ctotal;
  String? cpurchaseRate;

  double h1TextSize = 16.0;
  double h2TextSize = 12.0;
  double Total = 0.0;

  bool isVisible = false;
  bool isEnabled = false;
  bool isVisibleProductImg = false;

  //late final Box box;

  bool isSellBtnClk = false;
  bool isCustomerTypeChange = false;
  bool isBankListClicked = false;

  String? paymentType;
  String? _selectedType="Cash";
  final List<String> _selectedTypeList = [
    'Cash',
    'Bank',
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EmployeeProvider>(context,listen: false).getEmployee();
    Provider.of<AreaProvider>(context,listen: false).getArea();
    Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: level);
    Provider.of<ProductListProvider>(context,listen: false).getProduct("", "");
  }
  @override
  Widget build(BuildContext context) {
    final allEmployeeData = Provider.of<EmployeeProvider>(context).allEmployeeList;
    final allAreaData = Provider.of<AreaProvider>(context).allAreaList;
    final allCustomer = Provider.of<CustomerListProvider>(context).customerList;
    final allProductData = Provider.of<ProductListProvider>(context,listen: false).allProductList;
    return Scaffold(
      appBar: CustomAppBar(title: "Order Entry"),
        body: ModalProgressHUD(
          blur: 2,
          inAsyncCall: CustomerListProvider.isCustomerTypeChange,
          progressIndicator: Utils.showSpinKitLoad(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:  Colors.indigo,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Order Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Container(
                    height: 76.0,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 7, 125, 180),
                          width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const Expanded(
                            //   flex: 3,
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Invoice no :",
                            //         style: TextStyle(
                            //             color: Color.fromARGB(255, 126, 125, 125)),
                            //       ),
                            //       Text("12345"),
                            //     ],
                            //   ),
                            // ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Date to      :",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 126, 125, 125)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectedDate();
                                      },
                                      child: Container(
                                        margin:
                                        const EdgeInsets.only(top: 4,),
                                        height: 30,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            top: 3, bottom: 5, left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(255, 7, 125, 180),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              firstPickedDate == null
                                                  ? Utils.formatFrontEndDate(DateTime.now())
                                                  : firstPickedDate!,
                                              style:  TextStyle(fontSize: 13.0,color: Colors.grey.shade500),
                                            ),
                                            const Icon(Icons.calendar_month,size: 18,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),

                        // Invoice no drop down
                        Row(
                          children: [
                            const Expanded(
                              flex:1,
                              child:Text(
                                "Sales By    :",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),),

                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                height: 30,
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TypeAheadFormField(
                                  textFieldConfiguration:
                                  TextFieldConfiguration(
                                    onChanged: (value){
                                      if (value == '') {
                                        employeeSlNo = '';
                                      }
                                    },
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    controller: empluyeeNameController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                                      isDense: true,
                                      hintText: 'Select Employee',
                                      hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 13),
                                      suffixIcon:employeeSlNo == '' || employeeSlNo == 'null' ||
                                          employeeSlNo == null || empluyeeNameController.text == '' ? null : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            empluyeeNameController.text = '';
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Icon(Icons.close,size: 14,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return allEmployeeData
                                        .where((element) => element.employeeName
                                        .toString()
                                        .toLowerCase()
                                        .contains(pattern
                                        .toString()
                                        .toLowerCase()))
                                        .take(allEmployeeData.length)
                                        .toList();
                                    // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        child: Text(
                                          "${suggestion.employeeName}",
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ),
                                    );
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected:
                                      (EmployeeModel suggestion) {
                                        empluyeeNameController.text = suggestion.employeeName;
                                    setState(() {
                                      employeeSlNo = suggestion.employeeSlNo.toString();
                                    });
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                          ],
                        ), // Sales by drop down
                      ],
                    ),
                  ),
                  // SizedBox(height: 10),
                  ////
                  ///
                  ///my practice
                  ///
                  Container(
                    height: _selectedCustomer == 'null' ? 222 : 192.0,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 7, 125, 180),
                          width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Order Type :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.005,
                                  child: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                            (states) =>
                                        const Color.fromARGB(255, 5, 114, 165),
                                      ),
                                      value: "retail",
                                      groupValue: level,
                                      onChanged: (value) {

                                        setState(() {
                                          level = value.toString();
                                          print(level);
                                          isCustomerTypeChange = true;
                                          customerController.text = '';
                                          CustomerListProvider().on();
                                          Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: level);
                                          // Future.delayed(const Duration(seconds: 2),() {
                                          //   setState(() {
                                          //     isCustomerTypeChange = false;
                                          //   });
                                          // },);
                                        });
                                      }),
                                ),
                                const Text("Retail"),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.005,
                                  child: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                            (states) =>
                                        const Color.fromARGB(255, 5, 114, 165),
                                      ),
                                      value: "wholesale",
                                      groupValue: level,
                                      onChanged: (value) {
                                        setState(() {
                                          level = value.toString();
                                          print(level);
                                          isCustomerTypeChange = true;
                                          customerController.text = '';
                                          CustomerListProvider().on();
                                          Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: level);
                                          // Future.delayed(const Duration(seconds: 2),() {
                                          //   setState(() {
                                          //     isCustomerTypeChange = false;
                                          //   });
                                          // },);
                                        });
                                      }),
                                ),
                                const Text("Wholesale"),
                              ],
                            ),
                          ],
                        ),
                        ///Area
                        Row(
                          children: [
                            const Expanded(
                              flex:1,
                              child:Padding(
                                padding: EdgeInsets.only(left: 35.0),
                                child: Text(
                                  "Area  :",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                ),
                              ),),
                            const SizedBox(width: 5,),
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                height: 30,
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TypeAheadFormField(
                                  textFieldConfiguration:
                                  TextFieldConfiguration(
                                    onChanged: (value){
                                      if (value == '') {
                                        areaSlNo = '';
                                      }
                                    },
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                    controller: areaController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                                      isDense: true,
                                      hintText: 'Select Area',
                                      hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 13),
                                      suffixIcon:areaSlNo == '' || areaSlNo == 'null' ||
                                          areaSlNo == null || areaController.text == '' ? null : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            areaController.text = '';
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 25.0),
                                          child: Icon(Icons.close,size: 16,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return allAreaData
                                        .where((element) => element.districtName
                                        .toString()
                                        .toLowerCase()
                                        .contains(pattern
                                        .toString()
                                        .toLowerCase()))
                                        .take(allAreaData.length)
                                        .toList();
                                    // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        child: Text(
                                          "${suggestion.districtName}",
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ),
                                    );
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected:
                                      (AreaModel suggestion) {
                                    areaController.text = suggestion.districtName;
                                    setState(() {
                                      areaSlNo = suggestion.districtSlNo.toString();
                                    });
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                          ],
                        ), // radio button
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            const Text(
                              "Customer :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                height: 30,
                                padding: const EdgeInsets.only(left: 5, right: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TypeAheadFormField(
                                  textFieldConfiguration:
                                  TextFieldConfiguration(
                                      onChanged: (value){
                                        if (value == '') {
                                          _selectedCustomer = '';
                                        }
                                      },
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      controller: customerController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                                        hintText: 'Select Customer',
                                        isDense: true,
                                        hintStyle:  TextStyle(fontSize: 13.0,color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                        suffixIcon: _selectedCustomer == "null"
                                            || _selectedCustomer == ""
                                            || customerController.text == ""
                                            || _selectedCustomer == null ? null
                                            : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              customerController.text = '';
                                              _mobileNumberController.text = '';
                                              _addressController.text = '';
                                            });
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.close,size: 16,),
                                          ),
                                        ),
                                        suffixIconConstraints: const BoxConstraints(maxHeight: 30),
                                      )
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return allCustomer
                                        .where((element) => element
                                        .displayName!
                                        .toLowerCase()
                                        .contains(pattern
                                        .toString()
                                        .toLowerCase()))
                                        .take(allCustomer.length)
                                        .toList();
                                    // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        child: Text(
                                          "${suggestion.displayName}",
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected:
                                      (CustomerListModel suggestion) {
                                    customerController.text = suggestion.displayName!;
                                    setState(() {
                                      _selectedCustomer = suggestion.customerSlNo.toString();
                                      customerSlNo = suggestion.customerSlNo.toString();

                                      if (_selectedCustomer == 'null') {
                                        print("No has not $_selectedCustomer");

                                        isVisible = true;
                                        isEnabled = true;
                                        _nameController.text = '';
                                        _mobileNumberController.text = '';
                                        _addressController.text = '';
                                      } else {
                                        isEnabled = false;
                                        isVisible = false;

                                        _mobileNumberController.text = suggestion.customerMobile.toString();
                                        _addressController.text = suggestion.customerAddress.toString();

                                        /*final results = [

                                      customerList.where((m) => m.customerSlNo
                                          .toString()
                                          .contains(
                                          '${suggestion.customerSlNo}')) // or Testing 123
                                          .toList(),
                                    ];

                                    results.forEach((element) {
                                      element.add(element.first);
                                      print("dfhsghdfkhgkh");
                                      print(
                                          "productSlNo===> ${element[0].displayName}");
                                      print(
                                          "productCategoryName===> ${element[0].customerName}");
                                      customerMobile =
                                      "${element[0].customerMobile}";
                                      _mobileNumberController.text =
                                      "${element[0].customerMobile}";
                                      print(
                                          "customerMobile===> ${element[0].customerMobile}");
                                      customerAddress =
                                      "${element[0].customerAddress}";
                                      _addressController.text =
                                      "${element[0].customerAddress}";
                                      print(
                                          "customerAddress===> ${element[0].customerAddress}");
                                      dueReport(customerSlNo);
                                      // previousDue = "${element[0].previousDue}";
                                      // _previousDueController.text =
                                      // "${element[0].previousDue}";
                                      print(
                                          "previousDue===> ${element[0].previousDue}");
                                    });*/
                                      }
                                      //  print(_selectedCustomer);
                                      print('isVisible $isVisible');
                                    });
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                          ],
                        ), // drop down
                        Visibility(
                          visible: isVisible,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 28),
                                child: Text(
                                  "Name :",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 28.0,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  child: TextFormField(
                                    controller: _nameController,
                                    validator: (value) {
                                      if(value != null || value != ''){
                                        _nameController.text = value.toString();
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Customer Name",
                                      hintStyle:  TextStyle(fontSize: 13.0,color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                      contentPadding: const EdgeInsets.only(bottom:15,left: 5),
                                      filled: true,
                                      fillColor: isEnabled == true
                                          ? Colors.white
                                          : Colors.grey[200],
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 7, 125, 180),
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 7, 125, 180),
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 22),
                              child: Text(
                                "Mobile :",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 28.0,
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey[200],),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13),
                                  enabled: isEnabled,
                                  controller: _mobileNumberController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if(value != null || value != ''){
                                      _mobileNumberController.text = value.toString();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Mobile No",
                                    hintStyle:  TextStyle(fontSize: 13.0,color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                    contentPadding: const EdgeInsets.only(bottom:10,left: 5),
                                    filled: true,
                                    fillColor: isEnabled == true
                                        ? Colors.white
                                        : Colors.grey[200],
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // mobile

                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "Address :",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),

                            const SizedBox(width: 16,),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 30,
                                //margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey[200],),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13),
                                  maxLines: 2,
                                  controller: _addressController,
                                  validator: (value) {
                                    if(value != null || value != ''){
                                      _addressController.text = value.toString();
                                    }
                                    return null;
                                  },
                                  enabled: isEnabled,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    hintStyle:  TextStyle(fontSize: 13.0,color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                    contentPadding: const EdgeInsets.only(bottom:15,left: 5),
                                    filled: true,
                                    fillColor: isEnabled == true
                                        ? Colors.white
                                        : Colors.grey[200],

                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //address
                      ],
                    ),
                  ),
                  // SizedBox(height: 10),
                  Container(
                    height:isVisibleProductImg?250.0:182.0,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    padding:
                    const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 7, 125, 180),
                          width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 17,),
                            const Text(
                              "Product :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(width: 15,),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 7, 125, 180),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    onTap: () {
                                     setState(() {
                                       isVisibleProductImg=true;
                                     });
                                    },
                                  ),
                                  //child: SizedBox(
                                    // child: TypeAheadFormField(
                                    //   textFieldConfiguration:
                                    //   TextFieldConfiguration(
                                    //       onChanged: (value){
                                    //         if (value == '') {
                                    //           _selectedProduct = '';
                                    //         }
                                    //       },
                                    //       style: TextStyle(
                                    //           color: Colors.grey.shade600,
                                    //           fontSize: 13,
                                    //           overflow: TextOverflow.ellipsis
                                    //       ),
                                    //       controller: productController,
                                    //       decoration: InputDecoration(
                                    //         isDense: true,
                                    //         hintText: 'Select Product',
                                    //         hintStyle: const TextStyle(fontSize: 13),
                                    //         suffix: _selectedProduct == '' ? null : GestureDetector(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               productController.text = '';
                                    //             });
                                    //           },
                                    //           child: const Padding(
                                    //             padding: EdgeInsets.symmetric(horizontal: 3),
                                    //             child: Icon(Icons.close,size: 14,),
                                    //           ),
                                    //         ),
                                    //       )
                                    //   ),
                                    //   suggestionsCallback: (pattern) {
                                    //     return CategoryWiseProductList
                                    //         .where((element) => element.displayText!
                                    //         .toLowerCase()
                                    //         .contains(pattern
                                    //         .toString()
                                    //         .toLowerCase()))
                                    //         .take(CategoryWiseProductList.length)
                                    //         .toList();
                                    //     // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                    //   },
                                    //   itemBuilder: (context, suggestion) {
                                    //     return SizedBox(
                                    //       width: double.infinity,
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    //         child: Text("${suggestion.displayText}",
                                    //           style: const TextStyle(fontSize: 12),
                                    //           maxLines: 1,
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    //   transitionBuilder:
                                    //       (context, suggestionsBox, controller) {
                                    //     return suggestionsBox;
                                    //   },
                                    //   onSuggestionSelected:
                                    //       (AllProductModelClass suggestion) {
                                    //     productController.text = suggestion.displayText!;
                                    //     setState(() {
                                    //       _selectedProduct = "${suggestion.productSlNo}";
                                    //
                                    //       print("dfhsghdfkhgkh $_selectedProduct");
                                    //
                                    //       final results = [
                                    //         CategoryWiseProductList.where((m) =>
                                    //             m.productSlNo.toString().contains(
                                    //                 suggestion.productSlNo.toString())) // or Testing 123
                                    //             .toList(),
                                    //       ];
                                    //       print("dfhsghdfkhgkh $results");
                                    //
                                    //       results.forEach((element) async {
                                    //         element.add(element.first);
                                    //         cproductId = "${element[0].productSlNo}";
                                    //         print(
                                    //             "productSlNo===> ${element[0].productSlNo}");
                                    //         ccategoryName =
                                    //         "${element[0].productCategoryName}";
                                    //         print(
                                    //             "productCategoryName===> ${element[0].productCategoryName}");
                                    //         cname = "${element[0].productName}";
                                    //         print(
                                    //             "productName===> ${element[0].productName}");
                                    //         print(
                                    //             "productSellingPrice===> ${element[0].productSellingPrice}");
                                    //         cvat = "${element[0].vat}";
                                    //         print("vat===> ${element[0].vat}");
                                    //         print(
                                    //             "_quantityController ===> ${_quantityController.text}");
                                    //         print(
                                    //             "_quantityController ===> ${_quantityController.text}");
                                    //         cpurchaseRate =
                                    //         "${element[0].productPurchaseRate}";
                                    //         print(
                                    //             "productPurchaseRate===> ${element[0].productPurchaseRate}");
                                    //         _VatController.text = "${element[0].vat}";
                                    //         _salesRateController.text =
                                    //         "${element[0].productSellingPrice}";
                                    //         setState(() {
                                    //           Total = (double.parse(
                                    //               _quantityController.text) *
                                    //               double.parse(
                                    //                   _salesRateController.text));
                                    //         });
                                    //         totalStack(cproductId);
                                    //       });
                                    //     });
                                    //   },
                                    //   onSaved: (value) {},
                                    // ),
                                 // )
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: isVisibleProductImg,
                          child: Container(
                            height: 70.0,
                            width: 80.0,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),// product
                        Row(
                          children: [
                            const Text(
                              "Sales Rate :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 28.0,
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125),
                                      fontSize: 14.0),
                                  controller: _salesRateController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),// q
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "Box Qty.     :",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 28.0,
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125),
                                      fontSize: 14.0),
                                  controller: _salesRateController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "Pcs",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 28.0,
                                margin: const EdgeInsets.only(left: 5, right: 0),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125),
                                      fontSize: 14.0),
                                  controller: _quantityController,
                                  onChanged: (value) {
                                    setState(() {
                                      Total = (double.parse(
                                          _quantityController.text) *
                                          double.parse(_salesRateController.text));
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ), // quantity
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              "Amount :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 0, right: 5),
                                height: 28,
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "$Total",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125),
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "Available Stock,",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: Text(
                                  availableStock,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 35.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0), // Adjust the border radius here
                                  ),
                                  backgroundColor:
                                  Colors.indigo,
                                ),
                                onPressed: () {
                                  if (categoryController.text != ''||categoryController.text.isNotEmpty) {
                                    if (productController.text != '' ||
                                        productController.text.isNotEmpty) {
                                      // if (_quantityController.text
                                      //     .toString()
                                      //     .isNotEmpty
                                      //     || _quantityController.text != '') {
                                      if (availableStock != '0') {
                                        setState(() {
                                          // salesCartList.add(SalesApiModelClass(
                                          //     productId: "$cproductId",
                                          //     categoryName: "$ccategoryName",
                                          //     name: "$cname",
                                          //     salesRate: _salesRateController.text,
                                          //     vat: _VatController.text,
                                          //     quantity: _quantityController.text,
                                          //     total: "$Total",
                                          //     purchaseRate: "$cpurchaseRate"));

                                          CartTotal += Total;
                                          AfteraddVatTotal = CartTotal;
                                          DiccountTotal = AfteraddVatTotal;
                                          TransportTotal = DiccountTotal;
                                          print(
                                              "CartTotal ----------------- $CartTotal");
                                          categoryController.text = '';
                                          productController.text = '';
                                          _salesRateController.text = '';
                                          // _quantityController.text = '0';
                                          setState(() {
                                            Total = 0;
                                          });
                                        });
                                        // totalStack(cproductId);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text(
                                              "Stock Unavailable", style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red),)));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Center(
                                            child: Text(
                                              "Please Select Product",
                                              style: TextStyle(fontSize: 16,
                                                  color: Colors.red),),
                                          )));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Center(
                                          child: Text(
                                            "Please Select Category", style: TextStyle(
                                              fontSize: 16, color: Colors.red),),
                                        )));
                                  }
                                },
                                child: const Text("Add to cart", style: TextStyle(
                                    fontSize: 16, color: Colors.white),)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      const Divider(thickness: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "SL.",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: h2TextSize),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  "P.Code",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 5,
                              child: Center(
                                child: Text(
                                  "P.Name",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "Box",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "Pcs",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "Qty",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  "Rate",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  "Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const Divider(thickness: 2),
                      ...List.generate(2, (index){
                        return Column(
                          children: [
                            Container(
                              color: Colors.blue[50],
                              height: 25,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: Text(
                                              "P00100",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Center(
                                            child: Text(
                                              "mehedi hasan.",overflow:TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${index+1}",
                                              style: TextStyle(
                                                overflow:
                                                TextOverflow.ellipsis,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${index+1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: Text(
                                              "${index+1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Center(
                                            child: Text(
                                              "12154884",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                      //SizedBox(height: salesCartList.isNotEmpty ? 10 : 30),
                    ],
                  ),
                  ///Damage Entry
                  Container(
                    height: 183.0,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 7, 125, 180),
                          width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:  Colors.indigo,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Damage Entry',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height:6.0),
                        Row(
                          children: [
                            const Text(
                              "Product  :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(width: 15,),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                //child: SizedBox(
                                // child: TypeAheadFormField(
                                //   textFieldConfiguration:
                                //   TextFieldConfiguration(
                                //       onChanged: (value){
                                //         if (value == '') {
                                //           _selectedProduct = '';
                                //         }
                                //       },
                                //       style: TextStyle(
                                //           color: Colors.grey.shade600,
                                //           fontSize: 13,
                                //           overflow: TextOverflow.ellipsis
                                //       ),
                                //       controller: productController,
                                //       decoration: InputDecoration(
                                //         isDense: true,
                                //         hintText: 'Select Product',
                                //         hintStyle: const TextStyle(fontSize: 13),
                                //         suffix: _selectedProduct == '' ? null : GestureDetector(
                                //           onTap: () {
                                //             setState(() {
                                //               productController.text = '';
                                //             });
                                //           },
                                //           child: const Padding(
                                //             padding: EdgeInsets.symmetric(horizontal: 3),
                                //             child: Icon(Icons.close,size: 14,),
                                //           ),
                                //         ),
                                //       )
                                //   ),
                                //   suggestionsCallback: (pattern) {
                                //     return CategoryWiseProductList
                                //         .where((element) => element.displayText!
                                //         .toLowerCase()
                                //         .contains(pattern
                                //         .toString()
                                //         .toLowerCase()))
                                //         .take(CategoryWiseProductList.length)
                                //         .toList();
                                //     // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                //   },
                                //   itemBuilder: (context, suggestion) {
                                //     return SizedBox(
                                //       width: double.infinity,
                                //       child: Padding(
                                //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                //         child: Text("${suggestion.displayText}",
                                //           style: const TextStyle(fontSize: 12),
                                //           maxLines: 1,
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   transitionBuilder:
                                //       (context, suggestionsBox, controller) {
                                //     return suggestionsBox;
                                //   },
                                //   onSuggestionSelected:
                                //       (AllProductModelClass suggestion) {
                                //     productController.text = suggestion.displayText!;
                                //     setState(() {
                                //       _selectedProduct = "${suggestion.productSlNo}";
                                //
                                //       print("dfhsghdfkhgkh $_selectedProduct");
                                //
                                //       final results = [
                                //         CategoryWiseProductList.where((m) =>
                                //             m.productSlNo.toString().contains(
                                //                 suggestion.productSlNo.toString())) // or Testing 123
                                //             .toList(),
                                //       ];
                                //       print("dfhsghdfkhgkh $results");
                                //
                                //       results.forEach((element) async {
                                //         element.add(element.first);
                                //         cproductId = "${element[0].productSlNo}";
                                //         print(
                                //             "productSlNo===> ${element[0].productSlNo}");
                                //         ccategoryName =
                                //         "${element[0].productCategoryName}";
                                //         print(
                                //             "productCategoryName===> ${element[0].productCategoryName}");
                                //         cname = "${element[0].productName}";
                                //         print(
                                //             "productName===> ${element[0].productName}");
                                //         print(
                                //             "productSellingPrice===> ${element[0].productSellingPrice}");
                                //         cvat = "${element[0].vat}";
                                //         print("vat===> ${element[0].vat}");
                                //         print(
                                //             "_quantityController ===> ${_quantityController.text}");
                                //         print(
                                //             "_quantityController ===> ${_quantityController.text}");
                                //         cpurchaseRate =
                                //         "${element[0].productPurchaseRate}";
                                //         print(
                                //             "productPurchaseRate===> ${element[0].productPurchaseRate}");
                                //         _VatController.text = "${element[0].vat}";
                                //         _salesRateController.text =
                                //         "${element[0].productSellingPrice}";
                                //         setState(() {
                                //           Total = (double.parse(
                                //               _quantityController.text) *
                                //               double.parse(
                                //                   _salesRateController.text));
                                //         });
                                //         totalStack(cproductId);
                                //       });
                                //     });
                                //   },
                                //   onSaved: (value) {},
                                // ),
                                // )
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Quantity :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 28.0,
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125),
                                      fontSize: 14.0),
                                  controller: _salesRateController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height:4.0),
                        Row(
                          children: [
                            const Text(
                              "Total       :",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 28.0,
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125),
                                      fontSize: 14.0),
                                  controller: _salesRateController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height:5.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 35.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0), // Adjust the border radius here
                                  ),
                                  backgroundColor:
                                  Color(0xffFF6C37),
                                ),
                                onPressed: () {},
                                child: const Text("Add to Cart", style: TextStyle(
                                    fontSize: 16, color: Colors.white),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Divider(thickness: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "SL.",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: h2TextSize),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  "Product",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "Quantity",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  "Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const Divider(thickness: 2),
                      ...List.generate(2, (index){
                        return Column(
                          children: [
                            Container(
                              color: Colors.blue[50],
                              height: 25,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                overflow:
                                                TextOverflow.ellipsis,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                      //SizedBox(height: salesCartList.isNotEmpty ? 10 : 30),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:  Colors.indigo,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Amount Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 7, 125, 180),
                          width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(width: 28),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Sub Total :",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 4,),
                                  height: 30,
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 7, 125, 180),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    "$CartTotal",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 126, 125, 125)),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(width: 28),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Damage Total",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 4,),
                                  height: 30,
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 7, 125, 180),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    "$CartTotal",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 126, 125, 125)),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(width: 65),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Vat",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 28.0,
                                margin: const EdgeInsets.only(bottom: 5.0,top: 5.0),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                  controller: _paidController,
                                  onChanged: (value) {
                                    },

                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(width: 30),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Dis. Persent",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 6,
                              child: Container(
                                height: 28.0,
                                margin: const EdgeInsets.only(left: 5, right: 5),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                  controller: _DiscountController,
                                  onChanged: (value) {
                                    _transportController.text = '';
                                    _paidController.text = '';
                                    setState(() {
                                      Diccountper =  (double.parse(_DiscountController.text)/ 100) * CartTotal;
                                      print("Dis $Diccountper");
                                      _discountPercentController.text = "$Diccountper";
                                      DiccountTotal = AfteraddVatTotal - Diccountper;
                                      TransportTotal = DiccountTotal;

                                      Totaltc = CartTotal + TotalVat - Diccountper;
                                      totalDue = Totaltc;

                                    });
                                    // setState(() {
                                    //   Diccountper = AfteraddVatTotal *
                                    //       (double.parse(_DiscountController.text) /
                                    //           100);
                                    //   _discountPercentController.text =
                                    //       "${Diccountper}";
                                    //   DiccountTotal =
                                    //       AfteraddVatTotal - Diccountper;
                                    //   TransportTotal = DiccountTotal;
                                    // });
                                    //  setState(() {
                                    //   Diccountper = AfteraddVatTotal *
                                    //       (double.parse(_DiscountController.text) /
                                    //           100);
                                    //   // _discountPercentController.text =
                                    //   //     "${Diccountper}";
                                    //   DiccountTotal =
                                    //       AfteraddVatTotal - Diccountper;
                                    //   TransportTotal = DiccountTotal;
                                    //   Totaltc = TransportTotal +
                                    //       double.parse(_transportController.text);
                                    // });
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "%",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 28.0,
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                  controller: _discountPercentController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value){
                                    _transportController.text = '';
                                    _paidController.text = '';
                                    var res = double.parse(_discountPercentController.text)*100;
                                    var rees = double.parse("${res}") / double.parse("${CartTotal}");
                                    setState(() {
                                      _DiscountController.text = double.parse("${rees}").toStringAsFixed(2);

                                      DiccountTotal = AfteraddVatTotal - double.parse(_discountPercentController.text);
                                      TransportTotal = DiccountTotal;

                                      Totaltc = CartTotal + TotalVat - double.parse(_discountPercentController.text);
                                      totalDue = Totaltc;

                                    });

                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // const SizedBox(width: 24),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Transport",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 28.0,
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                  controller: _transportController,
                                  onChanged: (value) {
                                    setState(() {
                                      Totaltc = CartTotal + TotalVat + double.parse(_transportController.text);
                                      Totaltc = Totaltc - Diccountper;
                                      totalDue= Totaltc;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(top: 5, left: 5),
                                    hintText: "0",
                                    // hintText: "$DiccountTotal",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(width: 52),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 0, bottom: 5),
                                  height: 30,
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 7, 125, 180),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    "${Totaltc == 0.0 ? CartTotal : Totaltc.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 126, 125, 125)),
                                    //"$TransportTotal",
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Payment Type",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 30.0,
                                width: MediaQuery.of(context).size.width / 2,
                                padding: const EdgeInsets.only(left: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 5, 107, 155),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    // hint: const Text(
                                    //   'Select Type',
                                    //   style: TextStyle(
                                    //     fontSize: 14,
                                    //   ),
                                    // ),
                                    dropdownColor: const Color.fromARGB(255, 231, 251,
                                        255), // Not necessary for Option 1
                                    value: _selectedType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedType = newValue!;
                                        if (newValue == "Cash") {
                                          paymentType = "Cash";
                                        }
                                        if (newValue == "Bank") {
                                          paymentType = "Bank";
                                        }
                                        paymentType == "Bank"
                                            ? isBankListClicked = true
                                            : isBankListClicked = false;
                                      });
                                    },
                                    items: _selectedTypeList.map((location) {
                                      return DropdownMenuItem(
                                        value: location,
                                        child: Text(
                                          location,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        isBankListClicked == true
                            ? Container(
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Text(
                                  "Bank account",
                                  style: TextStyle(
                                      color: Color.fromARGB(
                                          255, 126, 125, 125)),
                                ),
                              ),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 11,
                                child: Container(
                                  height: 30.0,
                                  width:
                                  MediaQuery.of(context).size.width / 2,
                                  padding: const EdgeInsets.only(left: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color:
                                      const Color.fromARGB(255, 5, 107, 155),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  // child: FutureBuilder(
                                  //   future: Provider.of<CounterProvider>(context).getBankAccounts(context),
                                  //   builder: (context,
                                  //       AsyncSnapshot<List<AllBankAccountModelClass>> snapshot) {
                                  //     if (snapshot.hasData) {
                                  //       return TypeAheadFormField(
                                  //         textFieldConfiguration:
                                  //         TextFieldConfiguration(
                                  //             onChanged: (value){
                                  //               if (value == '') {
                                  //                 _selectedBank = '';
                                  //               }
                                  //             },
                                  //             style: const TextStyle(
                                  //               fontSize: 13,
                                  //             ),
                                  //             controller: bankController,
                                  //             decoration: InputDecoration(
                                  //               contentPadding: EdgeInsets.only(bottom: 15),
                                  //               hintText: 'Select Account',
                                  //               suffix: _selectedBank == '' ? null : GestureDetector(
                                  //                 onTap: () {
                                  //                   setState(() {
                                  //                     bankController.text = '';
                                  //                   });
                                  //                 },
                                  //                 child: const Padding(
                                  //                   padding: EdgeInsets.symmetric(horizontal: 3),
                                  //                   child: Icon(Icons.close,size: 14,),
                                  //                 ),
                                  //               ),
                                  //             )
                                  //         ),
                                  //         suggestionsCallback: (pattern) {
                                  //           return snapshot.data!
                                  //               .where((element) => element.accountName!
                                  //               .toLowerCase()
                                  //               .contains(pattern
                                  //               .toString()
                                  //               .toLowerCase()))
                                  //               .take(allBankAccountsData.length)
                                  //               .toList();
                                  //           // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                  //         },
                                  //         itemBuilder: (context, suggestion) {
                                  //           return SizedBox(
                                  //             child: Padding(
                                  //               padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  //               child: Text(
                                  //                 "${suggestion.accountNumber} - ${suggestion.bankName}",
                                  //                 style: const TextStyle(fontSize: 12),
                                  //                 maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  //             ),
                                  //           );
                                  //           //   ListTile(
                                  //           //   title: SizedBox(child: Text("${suggestion.accountName} - ${suggestion.accountNumber} (${suggestion.bankName})",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                  //           // );
                                  //         },
                                  //         transitionBuilder:
                                  //             (context, suggestionsBox, controller) {
                                  //           return suggestionsBox;
                                  //         },
                                  //         onSuggestionSelected:
                                  //             (AllBankAccountModelClass suggestion) {
                                  //           bankController.text = "${suggestion.accountName}-${suggestion.accountNumber} (${suggestion.bankName})";
                                  //           setState(() {
                                  //             _selectedBank = suggestion.accountId.toString();
                                  //           });
                                  //         },
                                  //         onSaved: (value) {},
                                  //       );
                                  //     }
                                  //     return const SizedBox();
                                  //   },
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        )
                            : Container(),
                        const SizedBox(height: 5.0,),
                        Row(
                          children: [
                            // const SizedBox(width: 55),
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Paid",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 28.0,
                                margin: const EdgeInsets.only(bottom: 5),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                  controller: _paidController,
                                  onChanged: (value) {
                                    if(_VatController.text == '0'){

                                      print("Empthy cart ${Totaltc == 0.0 ? CartTotal : Totaltc}");
                                      print("Empthy kajldfjas ${CartTotal}");
                                      setState(() {
                                        totalDue = CartTotal - double.parse(_paidController.text);
                                      });
                                      print("Empthy kajldfjas ${totalDue}");
                                    }
                                    else{
                                      setState(() {
                                        totalDue = Totaltc - double.parse(_paidController.text);
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 6),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 7, 125, 180),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 5,
                              child: Text(
                                "Due",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 0, bottom: 0,),
                                  height: 30,
                                  padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5,),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 7, 125, 180),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    "${totalDue == 0.0 ? CartTotal : totalDue.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 126, 125, 125)),
                                    //"$TransportTotal",
                                  ),
                                )),

                            const Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "P.Due ",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 126, 125, 125)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                //margin: const EdgeInsets.only(bottom: 2),
                                height: 30,
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const SizedBox(
                                  // child: Text(
                                  //   "$Previousdue" == 'null' ? '0' : "${Previousdue}",
                                  //   style: const TextStyle(color: Colors.red),
                                  //   maxLines: 1,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 35.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0), // Adjust the border radius here
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isSellBtnClk = true;
                                  });
                                  if (CartTotal == 0) {
                                    setState(() {
                                      isSellBtnClk = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Please Add to Cart")));
                                  } else {
                                    print("Name controller ${_nameController.text}");
                                    print("Name controller $_selectedCustomer");
                                    //addSales();
                                  }
                                },
                                child: Center(
                                    child: isSellBtnClk ? const SizedBox(height: 20,width:20,child: CircularProgressIndicator(color: Colors.white,)) : const Text(
                                      "Sale",
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 35.0,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0), // Adjust the border radius here
                                    ),
                                    backgroundColor:
                                    Colors.indigo,
                                  ),
                                  onPressed: () {},
                                  child: const Text("New Sale", style: TextStyle(
                                      fontSize: 16, color: Colors.white),)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
  String? firstPickedDate;
  var backEndFirstDate;
  void _selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }
  }
}
