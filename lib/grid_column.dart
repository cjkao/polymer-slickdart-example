@HtmlImport('grid_column.html')
library mx.grid_column;

import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:polymer/polymer.dart';

@PolymerRegister('grid-column')
class GridColumn extends PolymerElement {
  GridColumn.created() : super.created();
  @property String field;
  @property String headerText;
  void attached() {
    print('${this.dataset["field"]} $headerText');
//    print('-->$field');
  }
}
