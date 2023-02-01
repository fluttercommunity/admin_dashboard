import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/page/issue_details_mobile.dart';
import 'package:admin_dashboard/page/issue_details_web.dart';
import 'package:flutter/material.dart';

///Class that handles everything concerning the data in the table
class TableData {

  ///List of TableData elements in the rows
  List<TableDataRow> rowList = [];

  Map<String,bool> flags = {};
  ///Sorts the rows in ascending order
  void sort(String columnName){
    rowList.sort((TableDataRow a, TableDataRow b) =>
        (a.elements[columnName]??'').compareTo(b.elements[columnName]??''),);
  }
  ///Sorts the rows in descending order
  void reverseSort(String columnName){
    rowList.sort((TableDataRow a, TableDataRow b) =>
        (b.elements[columnName]??'').compareTo(a.elements[columnName]??''),);
  }
  ///Adds new entry to table
  TableData add(TableDataRow row){
    if(flags.isEmpty){
      for(final title in row.elements.keys){
        flags.update(title, (value) => true, ifAbsent: () => true);
      }
    }
    rowList.add(row);
    return this;
  }

  ///Returns a widget that is scrollable and that also uses the SilverGrid to
  ///return the table
  CustomScrollView getCustomScrollViewWide(WideIssueWidgetState parent){
    var length = 1;
    final childrenList = <Widget>[];
    if(rowList.isEmpty){
      childrenList.add(const Text(Constants.noData,
        style: TextStyle(color: Colors.white),),);
    } else{
      length = rowList[0].elements.keys.length;
      for(final title in rowList[0].elements.keys){
        childrenList.add(
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                final flag = flags[title]??true;
                if(flag) {
                  parent.sort(title);
                }else{
                  parent.reverseSort(title);
                }
                flags[title] = !flag;
              },
              child: Text(title,
                style: const TextStyle(fontStyle: FontStyle.italic,
                    color: Colors.lightBlueAccent,),
              ),
            ),


        );


      }
      for(final row in rowList){
        for(final value in row.elements.values){
          childrenList.add(Container(
              alignment: Alignment.center,
              child: Text(value.length>20?'${value.substring(0,20)}...':value,
                style: const TextStyle(fontStyle: FontStyle.italic,
                    color: Colors.white,),
              ),),);
        }

      }
    }

    final result = CustomScrollView(slivers: [
      SliverGrid.count(
        childAspectRatio: 4,
        crossAxisCount: length,
        children: childrenList,),

    ],
    );
    return result;
  }
  ///Returns a widget that is scrollable and that also uses the SilverGrid to
  ///return the table for narrow devices
  CustomScrollView getCustomScrollViewNarrow(NarrowIssueWidgetState parent){
    var length = 1;
    final childrenList = <Widget>[];
    if(rowList.isEmpty){
      childrenList.add(const Text(Constants.noData,
        style: TextStyle(color: Colors.white),),);
    } else{
      length = rowList[0].elements.keys.length;
      for(final title in rowList[0].elements.keys){
        childrenList.add(
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              final flag = flags[title]??true;
              if(flag) {
                parent.sort(title);
              }else{
                parent.reverseSort(title);
              }
              flags[title] = !flag;
            },
            child: Text(title,
              style: const TextStyle(fontStyle: FontStyle.italic,
                color: Colors.lightBlueAccent,),
            ),
          ),


        );


      }
      for(final row in rowList){
        for(final value in row.elements.values){
          childrenList.add(Container(
            alignment: Alignment.center,
            child: Text(value.length>20?'${value.substring(0,20)}...':value,
              style: const TextStyle(fontStyle: FontStyle.italic,
                color: Colors.white,),
            ),),);
        }

      }
    }

    final result = CustomScrollView(slivers: [
      SliverGrid.count(
        childAspectRatio: 4,
        crossAxisCount: length,
        children: childrenList,),

    ],
    );
    return result;
  }

}

///Adds value to the row of a table
class TableDataRow{
  ///elements in the table
  Map<String,String> elements = {};
  ///Adds values to the table row
  TableDataRow addValue(String key, String value){
    //this doesn't write if the key does already exists so use update
    //with ifAbsentinstead
    elements.update(key, (value) => value, ifAbsent: () => value);
    return this;
  }
}
