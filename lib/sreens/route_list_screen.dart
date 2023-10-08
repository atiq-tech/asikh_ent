import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/provider/area_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteListScreen extends StatefulWidget {
  const RouteListScreen({super.key});

  @override
  State<RouteListScreen> createState() => _RouteListScreenState();
}

class _RouteListScreenState extends State<RouteListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AreaProvider.isCustomerTypeChange = true;
    Provider.of<AreaProvider>(context,listen: false).getArea();
  }
  @override
  Widget build(BuildContext context) {
    final allAreaData = Provider.of<AreaProvider>(context).allAreaList;
    return Scaffold(
      appBar: CustomAppBar(title: "Route List"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AreaProvider.isCustomerTypeChange == true
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator(),),
              )
                  : Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  //color: Colors.yellow.shade50,
                  //color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Colors.indigo,
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
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Route ID.       :   ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.black),),
                        Text("${allAreaData[0].districtSlNo}",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.grey.shade800),),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Route Name :   ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.black),),
                        Text("${allAreaData[0].districtName}",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.grey.shade800),),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Added By      :   ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.black),),
                        Text("${allAreaData[0].addBy}",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.grey.shade800),),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
