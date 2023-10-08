// import 'package:ashik_enterprise/hive/hive_adapter.dart';
// import 'package:ashik_enterprise/order_section/model/product_list_model.dart';
// import 'package:ashik_enterprise/utils/const_model.dart';
// import 'package:ashik_enterprise/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
//
//
// class MyCartScreen extends StatefulWidget {
//   const MyCartScreen({super.key,});
//
//   @override
//   State<MyCartScreen> createState() => _MyCartScreenState();
// }
//
// class _MyCartScreenState extends State<MyCartScreen> {
//   List<Product> productBox = [];
//   int boxQty = 0;
//   int qty = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     productBox = Hive.box<Product>('product').values.toList();
//     print("bbbbbbbbbbbbbbb${productBox.length}");
//   }
// //double grandTotal = 0;
//   @override
//   Widget build(BuildContext context) {
//     // grandTotal = productBox.fold(0, (previousValue, element) => previousValue+double.parse(
//     //     "${element.total}"));
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//             child: Icon(Icons.arrow_back,color: Colors.white,)),
//         title: const Text(
//           "My Cart",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child:
//         productBox.isEmpty
//             ? const Center(
//           child:
//           Text(
//             "No items available",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//        )
//             :
//           Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Cart Items"),
//                 TextButton(
//                     onPressed: () {
//                       Utils.showCustomDialog(context,
//                           child: Container(
//                             height: 200,
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               children: [
//                                 const Text(
//                                   "Are you sure?",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 const Text(
//                                   "Do you what to remove all of the cart items?"
//                                       " Once you remove all this item you can add"
//                                       " again from product list.",
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     SizedBox(
//                                       height: 40,
//                                       width: 80,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: const Text("No"),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     SizedBox(
//                                       height: 40,
//                                       width: 80,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           productBox.clear();
//                                           Hive.box<Product>('product').clear();
//                                           setState(() {
//
//                                           });
//                                           Navigator.pop(context);
//                                         },
//                                         child: const Text("Yes",style: TextStyle(color: Colors.white),),
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.red,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                       );
//                     },
//                     child: const Text(
//                       "Remove All",
//                       style: TextStyle(color: Colors.red),
//                     ))
//               ],
//             ),
//             Expanded(
//               child: ListView.separated(
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     children: [
//                       Card(
//                         child: ListTile(
//                           leading: Container(
//                             height: 60,
//                             width: 60,
//                             decoration: BoxDecoration(
//                                 color: Colors.transparent,
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                       "http://ashik.expressretailbd.com/uploads/products/${productBox?[index].productImage}"),
//                                 )),
//                           ),
//                           title: Text("${productBox?[index].productName}"),
//                           subtitle:
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Rate: ${productBox?[index].salesRate}"),
//                               Text("Box: ${productBox?[index].boxQuantity}"),
//                               Text("Pcs: ${productBox?[index].quantity}"),
//                             ],
//                           ),
//                           trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text("Total: \n${productBox?[index].total}",style: TextStyle(fontSize: 14.0)),
//                                 // IconButton(
//                                 //   icon: const Icon(Icons.add_circle),
//                                 //   onPressed: () {
//                                 //     setState(() {
//                                 //
//                                 //     });
//                                 //     // value.updateProduct(
//                                 //     //     value.cart[index],
//                                 //     //     value.cart[index].quantity! +
//                                 //     //         1);
//                                 //     // model.removeProduct(model.cart[index]);
//                                 //   },
//                                 // ),
//                                 // Text(
//                                 //   "${value.cart[index].quantity}",
//                                 //   style:
//                                 //   const TextStyle(fontSize: 14),
//                                 // ),
//                                 // IconButton(
//                                 //   icon:
//                                 //   const Icon(Icons.remove_circle),
//                                 //   onPressed: () {
//                                 //     print('asdfhkasjd ${value.cart[index].quantity}');
//                                 //     if(value.cart[index].quantity!>0){
//                                 //       value.updateProduct(
//                                 //           value.cart[index],
//                                 //           value.cart[index].quantity! -
//                                 //               1);
//                                 //     }
//                                 //     // model.removeProduct(model.cart[index]);
//                                 //   },
//                                 // ),
//                               ]),
//                         ),
//                       ),
//                       Positioned(
//                         right: 10,
//                         top: 8,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                              productBox.removeAt(index);
//                              Hive.box<Product>('product').deleteAt(index);
//                             });
//                           },
//                           child: const Icon(
//                             Icons.close,
//                             size: 20,
//                             color: Colors.red,
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return const SizedBox(
//                     height: 15,
//                   );
//                 },
//                 itemCount:productBox.length
//                 //addToCartProviderList.length,
//               ),
//             ),
//             // Container(
//             //     padding: const EdgeInsets.all(8.0),
//             //     child: Text("Total: ৳${grandTotal}",
//             //       // "Total: ৳${Provider.of<AdddTtoCartProvider>(context,
//             //       //     listen: true)
//             //       //     .totalCartValue}",
//             //       style: const TextStyle(
//             //           fontSize: 18.0, fontWeight: FontWeight.bold),
//             //     )),
//             // SizedBox(
//             //   width: double.infinity,
//             //   height: 45,
//             //   child: ElevatedButton(
//             //     style: ElevatedButton.styleFrom(
//             //       primary: Colors.indigo, // Set your desired background color here
//             //     ),
//             //     child: const Text("All ORDER",style: TextStyle(color: Colors.white)),
//             //     onPressed: () {
//             //
//             //     },
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
