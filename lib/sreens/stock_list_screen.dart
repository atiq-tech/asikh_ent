import 'package:ashik_enterprise/provider/current_stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  double? totalStock;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentStockProvider.isLoading = true;
 Provider.of<CurrentStockProvider>(context,listen: false).getCurrentStock(context);
  }
  @override
  Widget build(BuildContext context) {
    final allCurrentStockData=Provider.of<CurrentStockProvider>(context).getCurrentStocklist;
    totalStock=allCurrentStockData.map((e) => e.stockValue).fold(0.0, (p, element) => p!+double.parse(element));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
          "Stock List",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          CurrentStockProvider.isLoading == true
              ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator(),),
          )
              :
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  //color: Colors.green.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTable(
                        headingRowHeight: 20.0,
                        dataRowHeight: 20.0,
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: const [
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Product Id'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Product Name'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Current Quantity'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Current Stock'))),
                          ),
                        ],
                        rows: List.generate(
                          allCurrentStockData.length,
                              (int index) =>  DataRow(
                            cells: <DataCell>[
                               DataCell(
                                Center(child: Text("${allCurrentStockData[index].productCode}")),
                              ),
                               DataCell(
                                Center(child: Text("${allCurrentStockData[index].productName}")),
                              ),
                              DataCell(
                                Center(child: Text("${allCurrentStockData[index].currentQuantity} ${allCurrentStockData[index].unitName}")),
                              ),
                           DataCell(
                                Center(child: Text("${allCurrentStockData[index].stockValue}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Total Stock Value   :    ",style:TextStyle(fontWeight: FontWeight.bold),),
                          Text("$totalStock"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
