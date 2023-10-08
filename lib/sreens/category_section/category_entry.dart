import 'package:ashik_enterprise/common_widget/custom_appbar.dart';
import 'package:ashik_enterprise/provider/all_category_provider.dart';
import 'package:ashik_enterprise/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryEntry extends StatefulWidget {
  const CategoryEntry({super.key});

  @override
  State<CategoryEntry> createState() => _CategoryEntryState();
}

class _CategoryEntryState extends State<CategoryEntry> {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllCategoryProvider>(context,listen: false).getCategory();
  }
  @override
  Widget build(BuildContext context) {
    //get Category
    final allCategoryLData = Provider.of<AllCategoryProvider>(context).allCategoryList;

    return Scaffold(
      appBar: CustomAppBar(title: "Category Entry"),
      body: SingleChildScrollView(
        //controller: mainScrollController,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 115.0,
                width: double.infinity,
                // margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
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
                      offset:
                          Offset(0, 3), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Category Name",
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
                              controller: _categoryNameController,
                              decoration: InputDecoration(
                                hintText: "Enter Category Name",
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400),
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
                            "Description",
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
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText: "Enter Category Description",
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400),
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Utils.closeKeyBoard(context);
                          if(_categoryNameController.text==''){
                            Utils.errorSnackBar(context, "Category name is required");
                          }
                          else if(_descriptionController.text==''){
                            Utils.errorSnackBar(context, "Description field is required");
                          }
                          else{
                            setState(() {
                              customerEntryBtnClk = true;
                            });
                            Provider.of<AllCategoryProvider>(context,listen: false).getCategory();
                          }
                        },
                        child: Container(
                          height: 35.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //     color: const Color.fromARGB(255, 173, 241, 179),
                            //     width: 2.0),
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(
                                    0, 3), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: Center(
                              child: customerEntryBtnClk
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                  : const Text(
                                      "Submit",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Center(
                  child: Text(
                    'Category Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            const SizedBox(height: 4.0),
            // CustomerListProvider.isCustomerTypeChange
            //     ? Center(child: CircularProgressIndicator(),)
            //     :
            Container(
              height: MediaQuery.of(context).size.height / 1.43,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  // controller: _listViewScrollController,
                  // physics: _physics,
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
                            label: Expanded(child: Center(child: Text('SL No.'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Category Name'))),
                          ),
                          DataColumn(
                            label: Expanded(child: Center(child: Text('Description'))),
                          ),
                        ],
                        rows: List.generate(
                          allCategoryLData.length,
                              (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCategoryLData[index].productCategorySlNo}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCategoryLData[index].productCategoryName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allCategoryLData[index].productCategoryDescription}')),
                              ),
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

  bool customerEntryBtnClk = false;
}
