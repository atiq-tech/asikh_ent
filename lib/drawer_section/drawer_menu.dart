import 'package:ashik_enterprise/auth/login_screen.dart';
import 'package:ashik_enterprise/customer_section/customer_entry_page.dart';
import 'package:ashik_enterprise/customer_section/customer_list_page.dart';
import 'package:ashik_enterprise/drawer_section/custom_list_tile.dart';
import 'package:ashik_enterprise/home_page.dart';
import 'package:ashik_enterprise/order_section/order_entry_page.dart';
import 'package:ashik_enterprise/sreens/category_section/category_entry.dart';
import 'package:ashik_enterprise/sreens/client_list_screen.dart';
import 'package:ashik_enterprise/sreens/order_list_screen.dart';
import 'package:ashik_enterprise/order_section/order_record_screen.dart';
import 'package:ashik_enterprise/sreens/outlet_list.dart';
import 'package:ashik_enterprise/sreens/route_list_screen.dart';
import 'package:ashik_enterprise/sreens/stock_list_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sreens/sales_record_screen.dart';

class DrawerDemoPage extends StatelessWidget {
  DrawerDemoPage({Key? key,required this.addreess,required  this.name,required  this.phon,required  this.photo }) : super(key: key);
  String ? name,phon,photo ,addreess;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            //margin: EdgeInsets.only(top: 20),
            height: 150,
            width: double.infinity,
            color: Colors.indigo,
            padding: EdgeInsets.only(left: 10.0,top: 15.0),
            child: Row(
              children: [
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(100)),
                //     // child: const CircleAvatar(
                //     //   radius: 35,
                //     //    backgroundImage: NetworkImage("https://1.bp.blogspot.com/-rrb3s2u5SPo/XZw1xPCyX7I/AAAAAAAABfY/ErdSVUL57NkD2NBAl2YsZ95JvXJhBT85wCLcBGAsYHQ/s1600/Prof.%2Bdr.%2BNasir%2BUddin.jpg"),
                //     // ),
                //   ),
                // ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child:  Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 30.0,),
                          const Text(
                            "Admin",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "Ashik Enterprise",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launch("http://ashikenterprise.com/Login");
                                    })),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
              },
              child: Custom_List_Tile(icon: Icons.home, icon_name: "User Page")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const OrderEntryPage(),));
              },
              child: Custom_List_Tile(icon: Icons.assignment_rounded, icon_name: "Order Entry")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const StockListScreen(),));
              },
              child: Custom_List_Tile(icon: Icons.event_note_outlined, icon_name: "Stock List")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const OutletList(),));
              },
              child: Custom_List_Tile(icon: Icons.save_outlined, icon_name: "Outlet List")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const OrderListScreen(),));
              },
              child: Custom_List_Tile(icon: Icons.reorder, icon_name: "Order List")),
          // const Divider(height: 1.0,thickness: 1.0,),
          // InkWell(
          //     onTap: (){
          //      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderRecordScreen(),));
          //     },
          //     child: Custom_List_Tile(icon: Icons.receipt_long, icon_name: "Order Record")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryEntry(),));
              },
              child: Custom_List_Tile(icon: Icons.point_of_sale_sharp, icon_name: "Category Entry")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerEntryPage(),));
              },
              child: Custom_List_Tile(icon: Icons.dashboard_customize_outlined, icon_name: "Customer Entry")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RouteListScreen(),));
              },
              child: Custom_List_Tile(icon: Icons.route_rounded, icon_name: "Route List")),
          const Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerListPage(),));
              },
              child: Custom_List_Tile(icon: Icons.list_alt_outlined, icon_name: "Customer List")),
           const Divider(height: 1.0,thickness: 1.0,),
          // InkWell(
          //     onTap: (){
          //        //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactInfo(),));
          //     },
          //     child: Custom_List_Tile(icon: Icons.star_border_outlined, icon_name: "Rate Us")),
          // Divider(height: 1.0,thickness: 1.0,),
          InkWell(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage(),));
              },
              child: Custom_List_Tile(icon: Icons.logout_outlined, icon_name: "Logout")),
          const Divider(height: 1.0,thickness: 1.0,),

        ],
      ),
    );
  }
}
// drawer list text
class TextStylee{
  TextStyle MyTextStyle=GoogleFonts.abhayaLibre(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    //letterSpacing: 1,
    color: Colors.black,
  ) ;
}

// drawer list text
class ServiceTextStyle{
  TextStyle MyTextStyle=GoogleFonts.abhayaLibre(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    //letterSpacing: 1,
    color: Colors.black,
  ) ;
}

