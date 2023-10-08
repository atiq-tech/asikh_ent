import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomerListProvider.isCustomerTypeChange = true;
    Provider.of<CustomerListProvider>(context, listen: false).getCustomerList(context,customerType: "");
  }
  @override
  Widget build(BuildContext context) {
    final allCustomerData=Provider.of<CustomerListProvider>(context).customerList.where((element) => element.customerName!=null).toList();
    return Scaffold(
        appBar: CustomAppBar(title: "Customer List",),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomerListProvider.isCustomerTypeChange == true
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator(),),
            )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: DataTable(
                            headingRowHeight: 20.0,
                            dataRowHeight: 20.0,
                            showCheckboxColumn: true,
                            border: TableBorder.all(color: Colors.black54, width: 1),
                            columns: const [
                              DataColumn(
                                label: Expanded(child: Center(child: Text('SI.'))),
                              ),
                              DataColumn(
                                label: Expanded(child: Center(child: Text('Customer Id'))),
                              ),
                              DataColumn(
                                label: Expanded(child: Center(child: Text('Customer Name'))),
                              ),
                              DataColumn(
                                label: Expanded(child: Center(child: Text('Address'))),
                              ),
                              DataColumn(
                                label: Expanded(child: Center(child: Text('Contact No'))),
                              ),
                            ],
                            rows: List.generate(
                                allCustomerData.length,
                                  (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(child: Text("${index + 1}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${allCustomerData[index].customerCode}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${allCustomerData[index].customerName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${allCustomerData[index].customerAddress} ${allCustomerData[index].districtName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text(
                                        "${allCustomerData[index].customerMobile}")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        )
    );
  }
}
