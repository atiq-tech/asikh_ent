import 'package:ashik_enterprise/auth/login_screen.dart';
import 'package:ashik_enterprise/customer_section/customer_entry_page.dart';
import 'package:ashik_enterprise/customer_section/customer_list_page.dart';
import 'package:ashik_enterprise/drawer_section/drawer_menu.dart';
import 'package:ashik_enterprise/main.dart';
import 'package:ashik_enterprise/order_section/order_entry_page.dart';
import 'package:ashik_enterprise/order_section/order_record_screen.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:ashik_enterprise/provider/user_data_provider.dart';
import 'package:ashik_enterprise/sreens/category_section/category_entry.dart';
import 'package:ashik_enterprise/sreens/outlet_list.dart';
import 'package:ashik_enterprise/sreens/route_list_screen.dart';
import 'package:ashik_enterprise/sreens/sales_record_screen.dart';
import 'package:ashik_enterprise/sreens/stock_list_screen.dart';
import 'package:ashik_enterprise/utils/const_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  int? totatOrdValue = 0;

  @override
  Widget build(BuildContext context) {
     //final allGetUserData = Provider.of<UserDataProvider>(context).userDataModellist;
    return Scaffold(
      key: scaffoldKey,
       appBar: AppBar(
          //centerTitle: true,
          scrolledUnderElevation: 0,
         leading: GestureDetector(
           onTap: () {
             scaffoldKey.currentState?.openDrawer();
           },
           child: const Icon(
             Icons.menu,
             color: Colors.white,
             size: 24,
           ),
         ),
          elevation: 0.0,
          backgroundColor: Colors.indigo,
          title: const Text(
           "Ashik Enterprise",
            style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
          ),
         actions: [
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Column(
                 children: [
                   const CircleAvatar(
                     radius: 15.0,
                     backgroundImage: NetworkImage(
                         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw8tnmRAobUlTWwXTzG0yJevfymCAQw00wZw&usqp=CAU'),
                   ),
                   Text(
                     "Welcome, ${sharedPreferences?.getString('userName')}",
                     style: const TextStyle(
                         fontSize: 12.0,
                         fontWeight: FontWeight.w600,
                         color: Colors.white),
                   ),
                 ],
               ),
               PopupMenuButton(
                 child: Container(
                   height: 20,
                   width: 30,
                   alignment: Alignment.center,
                   child: const Icon(
                     Icons.arrow_drop_down,
                     color: Colors.white,
                   ),
                 ),
                 onSelected: (value) {
                   if (value == 0) {
                     // Navigator.pop(context);
                   } else {
                     showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return Dialog(
                             child: Container(
                               height: 160.0,
                               width: double.infinity,
                               padding: const EdgeInsets.only(
                                   top: 10.0, left: 10.0, right: 5.0,bottom: 10.0),
                               color: Colors.white,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Padding(
                                     padding:
                                     EdgeInsets.only(left: 8.0, top: 10.0),
                                     child: Text(
                                       "Logout...!",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w500,
                                           fontSize: 18.0),
                                     ),
                                   ),
                                   const Padding(
                                     padding:
                                     EdgeInsets.only(left: 8.0, top: 10.0),
                                     child: Text(
                                       "Are You Sure Went To Log Out?",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w400,
                                           fontSize: 16.0),
                                     ),
                                   ),
                                   const SizedBox(height: 25.0),
                                   Align(
                                     alignment: Alignment.center,
                                     child: Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceAround,
                                       children: [
                                         InkWell(
                                           onTap: () async {
                                             SharedPreferences sharedPreferences;
                                             sharedPreferences =
                                             await SharedPreferences
                                                 .getInstance();
                                             sharedPreferences.clear();
                                             GetStorage().erase();
                                             var box =
                                             await Hive.openBox('profile');
                                             box.clear();
                                             Navigator.of(context)
                                                 .pushAndRemoveUntil(
                                                 MaterialPageRoute(
                                                     builder: (context) =>
                                                     const LogInPage()),
                                                     (route) => false);
                                           },
                                           child: Container(
                                             height: 35.0,
                                             width: 60.0,
                                             decoration: BoxDecoration(
                                                 color: const Color.fromARGB(
                                                     255, 209, 55, 55),
                                                 borderRadius:
                                                 BorderRadius.circular(5.0)),
                                             child: const Center(
                                                 child: Text(
                                                   "YES",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.w500,
                                                       fontSize: 14.0),
                                                 )),
                                           ),
                                         ),
                                         const SizedBox(width: 10),
                                         InkWell(
                                           onTap: () {
                                             Navigator.pop(context);
                                           },
                                           child: Container(
                                             height: 35.0,
                                             width: 60.0,
                                             decoration: BoxDecoration(
                                                 color: const Color.fromARGB(
                                                     255, 7, 125, 180),
                                                 borderRadius:
                                                 BorderRadius.circular(5.0)),
                                             child: const Center(
                                                 child: Text(
                                                   "NO",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.w500,
                                                       fontSize: 14.0),
                                                 )),
                                           ),
                                         ),
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           );
                         });
                   }
                 },
                 itemBuilder: (BuildContext bc) {
                   return const [
                     PopupMenuItem(
                       height: 25,
                       value: 0,
                       child: Text(
                         "Profile",
                         style: TextStyle(
                             fontSize: 16, fontWeight: FontWeight.w500),
                       ),
                     ),
                     PopupMenuItem(
                       height: 25,
                       value: 1,
                       child: Text(
                         "Logout",
                         style: TextStyle(
                             fontSize: 16, fontWeight: FontWeight.w500),
                       ),
                     ),
                   ];
                 },
               )
             ],
           ),
           SizedBox(width: 5.0,)
         ],
        ),
      drawer: DrawerDemoPage(
        name: "",
        phon: "",
        photo: "",
        addreess: "",
      ),
      body: FutureBuilder(
        future: Provider.of<UserDataProvider>(context,listen: false).getUserData(context),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            totatOrdValue = snapshot.data?.todayOrder;
            return Container(
              padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "User",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "${sharedPreferences?.getString('userName')}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Today's Sales",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "${snapshot.data?.todaysSale}tk",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Value Target",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "${snapshot.data?.monthlySale}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Total Outlet",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "${snapshot.data?.totalCustomer}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              const Text(
                                "Today's Ordered Count",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "${snapshot.data?.todayOrder}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              const Text(
                                "Total SKU",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Ordered Weight(Kg)",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "${snapshot.data?.totalqty}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "$currentDate",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Today's Section/Beat",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "MOULOBI\nBAZAR-A+C",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Rem.Value",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "0.00",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Visited/Rem.Outlets",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "0/50",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Total Memo/SR",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "0(0%)",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "SKU/Invoice",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "0.00",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Weight Target(Kg)",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                "0.00",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ]),
                    const SizedBox(height: 5.0,),
                    Divider(thickness: 1.5,color: Colors.indigo.shade200),
                    const SizedBox(height: 10.0,),
                    Container(
                      height: MediaQuery.of(context).size.height/2,
                      // color: Colors.indigo,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // Number of columns
                          crossAxisSpacing: 2.0, // Spacing between columns
                          mainAxisSpacing: 5.0, // Spacing between rows
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          // Create a widget for each grid item at the given index
                          return GestureDetector(
                            onTap: () {
                              index==0?Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderEntryPage())):
                              index==1?Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderRecordScreen())):
                              index==2?Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerEntryPage())):
                              index==3?Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerListPage())):
                              index==4?Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryEntry())):
                              index==5?Navigator.push(context, MaterialPageRoute(builder: (context) => const RouteListScreen())):
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInPage()));
                            },
                            child: Card(
                              elevation: 10.0,
                              color: Colors.indigo.shade500,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 25.0,width: 25.0,
                                        child: Image.asset("${screenItems[index]["image"]}",)),
                                    SizedBox(height: 5.0,),
                                    Text(
                                      '${screenItems[index]["name"]}',textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.white,fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: screenItems.length, // Number of items in the grid
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return SizedBox();
        },
      ),
      bottomSheet: Container(
        height: 60.0,
        color: Colors.indigo,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                const StockListScreen()));
              },
              child: const Text("STOCK",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
             OutletList(
               totatOrderValue: totatOrdValue,
             ))).then((value){
                  Provider.of<UserDataProvider>(context,listen: false).getUserData(context);
                  setState(() {

                  });
                });
              },
              child: const Text("ORDER",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
