import 'dart:convert';
import 'dart:developer';

import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/customer_section/model/area_model.dart';
import 'package:ashik_enterprise/customer_section/model/employee_model.dart';
import 'package:ashik_enterprise/provider/area_provider.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:ashik_enterprise/provider/employee_provider.dart';
import 'package:ashik_enterprise/utils/const_model.dart';
import 'package:ashik_enterprise/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerEntryPage extends StatefulWidget {
  const CustomerEntryPage({super.key});

  @override
  State<CustomerEntryPage> createState() => _CustomerEntryPageState();
}

class _CustomerEntryPageState extends State<CustomerEntryPage> {
  final TextEditingController _employeeController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _OwnerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _officePhoneController = TextEditingController();
  final TextEditingController _previousDueController = TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();

  String? _Get_customerType="retail";
  String? _selectedArea;
  String? _selectedEmployee;

  String? employeeSlNo;
  String? areaSlNo;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    Provider.of<EmployeeProvider>(context,listen: false).getEmployee();
    Provider.of<AreaProvider>(context,listen: false).getArea();
    Provider.of<CustomerListProvider>(context, listen: false).customerList = [];
    CustomerListProvider.isCustomerTypeChange = true;
    Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: '');
    // Provider.of<CounterProvider>(context, listen: false).getDistricts(context);
    //
    // Provider.of<CounterProvider>(context, listen: false).getCustomers(context);

  }
  ScrollController mainScrollController = ScrollController();
  late ScrollController _listViewScrollController = ScrollController()
    ..addListener(listViewScrollListener);
  ScrollPhysics _physics = ScrollPhysics();

  void listViewScrollListener() {

    if (_listViewScrollController.offset >=
        _listViewScrollController.position.maxScrollExtent &&
        !_listViewScrollController.position.outOfRange) {
      if (mainScrollController.offset == 0) {
        mainScrollController.animateTo(50,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
      setState(() {
        _physics = NeverScrollableScrollPhysics();
      });
      print("bottom");
    }
  }
  void mainScrollListener() {
    if (mainScrollController.offset <=
        mainScrollController.position.minScrollExtent &&
        !mainScrollController.position.outOfRange) {
      setState(() {
        if (_physics is NeverScrollableScrollPhysics) {
          _physics = ScrollPhysics();

          _listViewScrollController.animateTo(
              _listViewScrollController.position.maxScrollExtent - 50,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear);
        }
      });
      print("top");
    }
  }

  var areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mainScrollController.addListener(mainScrollListener);

    final allAreaData = Provider.of<AreaProvider>(context).allAreaList;
    final allEmployeeData = Provider.of<EmployeeProvider>(context).allEmployeeList.where((element) => element.employeeSlNo=="1").toList();

    //get Customer
    final allCustomerList = Provider.of<CustomerListProvider>(context).customerList.where((element) => element.customerName!=null).toList();

    return Scaffold(
      appBar: CustomAppBar(title: "Customer Entry"),
      body: SingleChildScrollView(
        controller: mainScrollController,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 395.0,
                width: double.infinity,
                // margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(top:4.0,left: 4.0, right: 4.0),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 7, 125, 180),
                      width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 6,
                    //       child: Text(
                    //         "Customer Id",
                    //         style: TextStyle(
                    //             color: Color.fromARGB(255, 126, 125, 125)),
                    //       ),
                    //     ),
                    //     Expanded(flex: 1, child: Text(":")),
                    //     Expanded(
                    //       flex: 11,
                    //       child: Container(
                    //         height: 28.0,
                    //         width: MediaQuery.of(context).size.width / 2,
                    //         child: TextField(
                    //           controller: _customerIdController,
                    //           decoration: InputDecoration(
                    //             border: InputBorder.none,
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                 color: Color.fromARGB(255, 7, 125, 180),
                    //               ),
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                 color: Color.fromARGB(255, 7, 125, 180),
                    //               ),
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Customer Name",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _customerNameController,
                              decoration: InputDecoration(
                                hintText: "Enter Customer Name",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Owner Name",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _OwnerNameController,
                              decoration: InputDecoration(
                                hintText: "Enter Owner Name",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Address",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _addressController,
                              decoration: InputDecoration(
                                hintText: "Enter Address Name",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Area",
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
                            child: TypeAheadFormField(
                              textFieldConfiguration:
                              TextFieldConfiguration(
                                onChanged: (value){
                                  if (value == '') {
                                    areaSlNo = '';
                                  }
                                },
                                style: const TextStyle(
                                  fontSize: 12,
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
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Icon(Icons.close,size: 14,),
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
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Employee",
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
                                controller: _employeeController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                                  isDense: true,
                                  hintText: 'Select Employee',
                                  hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 13),
                                  suffixIcon:employeeSlNo == '' || employeeSlNo == 'null' ||
                                      employeeSlNo == null || _employeeController.text == '' ? null : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _employeeController.text = '';
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
                                    _employeeController.text = suggestion.employeeName;
                                setState(() {
                                  employeeSlNo = suggestion.employeeSlNo.toString();
                                });
                              },
                              onSaved: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Mobile",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _mobileController,
                              decoration: InputDecoration(
                                hintText: "Enter Mobile Number",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Office Phone",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _officePhoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: "Enter Office Phone Number",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Previous Due",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _previousDueController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Credit Limit",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              controller: _creditLimitController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(left: 5),
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
                    //
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Customer Type      :",
                    //       style: TextStyle(
                    //           color: Color.fromARGB(255, 126, 125, 125)),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.15,
                    //           child: Radio(
                    //               fillColor: MaterialStateColor.resolveWith(
                    //                 (states) =>
                    //                     Color.fromARGB(255, 5, 114, 165),
                    //               ),
                    //               value: _Get_customerType,
                    //               groupValue: lavel,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   lavel = value.toString();
                    //                   if (value == "Retails") {
                    //                     _Get_customerType = "retail";
                    //                   }
                    //                   if (value == "Wholesale") {
                    //                     _Get_customerType = "wholesale";
                    //                   }
                    //                 });
                    //               }),
                    //         ),
                    //         Text("Retails"),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.15,
                    //           child: Radio(
                    //               fillColor: MaterialStateColor.resolveWith(
                    //                 (states) =>
                    //                     Color.fromARGB(255, 5, 114, 165),
                    //               ),
                    //               value: _Get_customerType,
                    //               groupValue: lavel,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   lavel = value.toString();
                    //                   if (value == "Wholesale") {
                    //                     _Get_customerType = "wholesale";
                    //                   }
                    //                   if (value == "Retail") {
                    //                     _Get_customerType = "retail";
                    //                   }
                    //                 });
                    //               }),
                    //         ),
                    //         Text("Wholesale"),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //

                    // SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Customer Type   :",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Radio(
                                value: "retail",
                                groupValue: _Get_customerType,
                                activeColor: const Color.fromARGB(255, 84, 107, 241),
                                onChanged: (value) {
                                  setState(() {
                                    _Get_customerType = value;
                                    print(
                                        "Get_customerType============>$value");
                                  });
                                },
                              ),
                              const Expanded(child: SizedBox(child: Text("Retail",maxLines: 2,overflow: TextOverflow.ellipsis,))),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Radio(
                                value: "wholesale",
                                groupValue: _Get_customerType,
                                activeColor: const Color.fromARGB(255, 84, 107, 241),
                                onChanged: (value) {
                                  setState(() {
                                    _Get_customerType = value;
                                    print(
                                        "Get_customerType============>$value");
                                  });
                                },
                              ),
                              const Expanded(child: SizedBox(child: Text("Wholesale",maxLines: 2,overflow: TextOverflow.ellipsis,))),

                            ],
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Utils.closeKeyBoard(context);
                          if(_customerNameController.text==''){
                            Utils.errorSnackBar(context, "Customer name is required");
                          }
                          else if(areaController.text==''){
                            Utils.errorSnackBar(context, "Area field is required");
                          }
                          else if(_employeeController.text==''){
                            Utils.errorSnackBar(context, "Employee field is required");
                          }
                          else if(_mobileController.text==''){
                            Utils.errorSnackBar(context, "Mobile field is required");
                          }
                          else{
                            setState(() {
                              customerEntryBtnClk = true;
                            });
                            getCustomerCode().then((value){
                              if(value!=""){
                                customerEntry(context).then((value){
                                  Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: "");
                                  setState(() {

                                  });
                                });
                              }
                            });
                          }
                          // setState(() {
                          //   customerEntryBtnClk = true;
                          //   getCustomerCode();
                          // });
                          // _AddCustomer(context);
                          //  //getCustomer();
                        },
                        child: Container(
                          height: 35.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 173, 241, 179),
                                width: 2.0),
                            color: const Color.fromARGB(255, 94, 136, 84),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: Center(
                              child: customerEntryBtnClk ? SizedBox(height: 20,width:20,child: CircularProgressIndicator(color: Colors.white,)) : const Text(
                                "SAVE",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            ///
            const SizedBox(height: 4.0),
            CustomerListProvider.isCustomerTypeChange
                ? Center(child: CircularProgressIndicator(),)
                : Container(
              height: MediaQuery.of(context).size.height / 1.43,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  controller: _listViewScrollController,
                  physics: _physics,
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        headingRowHeight: 20.0,
                        dataRowHeight: 20.0,
                        showCheckboxColumn: true,
                        border:
                        TableBorder.all(color: Colors.black54, width: 1),
                        columns: const [
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Added Date'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Customer Id'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Customer Name'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Owner Name'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Area'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Contact Number'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Customer Type'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Credit Limit'))),
                          ),
                          // DataColumn(
                          //   label: Center(child: Text('Image')),
                          // ),
                        ],
                        rows: List.generate(
                          allCustomerList.length > 100 ? 100 : allCustomerList.length,
                              (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(
                                    child: Text(
                                        "${DateFormat('dd-MM-yyyy').format(DateTime.parse('${allCustomerList[index].addTime}'))}")),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].customerCode}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].customerName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].ownerName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].districtName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].customerMobile}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].customerType}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCustomerList[index].customerCreditLimit}')),
                              ),
                              // DataCell(
                              //   Center(
                              //       child: Container(
                              //           width: 40.0,
                              //           height: 40.0,
                              //           color: Colors.black,
                              //           child: Image.network(
                              //               "${allCustomerData[index].imageName}"))),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  String? customId;
  getCustomerCode() async {
    String link = "${baseUrl}api/v1/getCustomerId";
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await Dio().post(
        link,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${sharedPreferences.getString("token")}",
        }),
      );
      print(response.data);
      customId = jsonDecode(response.data);
      print("Customer Code===========> $customId");
    } catch (e) {
      print(e);
    }
  }

  // XFile? images;
  // ImageSource _imageSource = ImageSource.gallery;
  // chooseImageFrom() async {
  //   ImagePicker _picker = ImagePicker();
  //   images = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {});
  // }
  emptyMethod() {
    setState(() {
      _customerNameController.text = "";
      // customerType = "";
      _mobileController.text = "";
      _officePhoneController.text = "";
      _addressController.text = "";
      _OwnerNameController.text = "";
       areaController.text = "";
       _employeeController.text="";
      _creditLimitController.text = "";
      _previousDueController.text = "";
    });
  }
  Future<String>customerEntry(context) async {
    String link = "${baseUrl}api/v1/addCustomer";

    var data = {
      "Customer_SlNo": 0,
      "Customer_Code": customId.toString().trim(),
      "Customer_Name": _customerNameController.text.toString().trim(),
      "Customer_Type": _Get_customerType.toString().trim(),
      "Customer_Phone": "",
      "Customer_Mobile": _mobileController.text.toString().trim(),
      "Customer_Email": "",
      "Customer_OfficePhone": _officePhoneController.text.toString().trim(),
      "Customer_Address": _addressController.text.toString().trim(),
      "owner_name": _OwnerNameController.text.toString().trim(),
      "Employee_Id":employeeSlNo.toString().trim(),
      "area_ID": areaSlNo.toString().trim(),
      "Customer_Credit_Limit": _creditLimitController.text.toString().trim(),
      "previous_due": _previousDueController.text.toString().trim(),
    };
    log("sdahkf ${data}");

    FormData formData = FormData.fromMap({
      "data": jsonEncode({
        "Customer_SlNo": 0,
        "Customer_Code": customId.toString().trim(),
        "Customer_Name": _customerNameController.text.toString().trim(),
        "Customer_Type": _Get_customerType.toString().trim(),
        "Customer_Phone": "",
        "Customer_Mobile": _mobileController.text.toString().trim(),
        "Customer_Email": "",
        "Customer_OfficePhone": _officePhoneController.text.toString().trim(),
        "Customer_Address": _addressController.text.toString().trim(),
        "owner_name": _OwnerNameController.text.toString().trim(),
        "Employee_Id":employeeSlNo.toString().trim(),
        "area_ID": areaSlNo.toString().trim(),
        "Customer_Credit_Limit": _creditLimitController.text.toString().trim(),
        "previous_due": _previousDueController.text.toString().trim(),
      }),
      "image": "",

      //"image": await MultipartFile.fromFile(images!.path, filename: "fileName"),
    });
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await Dio().post(link,
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
          }));
      var item = jsonDecode(response.data);
      print("customer DDDDDDDDDDDATA ${item}");
      print("success============> ${item["success"]}");
      print("message =================> ${item["message"]}");
      print("customerCode================>  ${item["customerCode"]}");
      if (item["success"] == true) {
        setState(() {
          customerEntryBtnClk = false;
        });
        emptyMethod();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(255, 4, 108, 156),
            duration: const Duration(seconds: 2),
            content: Center(child: Text("${item["message"]}",style: const TextStyle(color: Colors.white),))));
        return "true";
        // Navigator.pop(context);
      } else {
        setState(() {
          customerEntryBtnClk = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 2),
            content: Center(child: Text("${item["message"]}",style: const TextStyle(color: Colors.red),))));
        return "false";
      }
    } catch (e) {
      return "false";
    }
  }
  bool customerEntryBtnClk = false;
}
//Customer added successfully