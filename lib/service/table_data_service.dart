import 'package:admin_dashboard/dto/table_data.dart';

///Provider for the issue table
abstract class TableDataProviderInterface {
  ///Constructor
  TableDataProviderInterface(this.repoName);
  ///Name of the repository
  String repoName;
  ///Issues opened within the last 6 months
  Future<TableData> getOpenInLastSixMonths();
  ///To be implemented
  Future<TableData> getSecondTable();
}

///Dummy table data provider
class DummyTableDataProvider extends TableDataProviderInterface {
  ///Constructor
  DummyTableDataProvider(String repoName) : super(repoName);

  @override
  Future<TableData> getOpenInLastSixMonths() async{
    return TableData().add(TableDataRow().addValue('Name', 'Bug fix').
    addValue('Open', '3 days'),)
        .add(TableDataRow().addValue('Name', 'Enhancement').
    addValue('Open', '7 days'),)
        .add(TableDataRow().addValue('Name', 'Feature').
    addValue('Open', '1 month'),)
        .add(TableDataRow().addValue('Name', 'Help wanted').
    addValue('Open', '4 months'),);
  }

  @override
  Future<TableData> getSecondTable() async{
    return TableData().add(TableDataRow().addValue('Name', 'Bug fix').
    addValue('Open', '3 days'),)
        .add(TableDataRow().addValue('Name', 'Enhancement').
    addValue('Open', '7 days'),)
        .add(TableDataRow().addValue('Name', 'Feature').
    addValue('Open', '1 month'),)
        .add(TableDataRow().addValue('Name', 'Help wanted').
    addValue('Open', '4 months'),);
  }

}
