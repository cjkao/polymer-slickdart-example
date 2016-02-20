@HtmlImport('data_grid.html')
library mx.data_grid;

import 'dart:html';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:polymer/polymer.dart';
import 'package:slickdart/slick_custom.dart';
import 'package:slickdart/slick.dart';
import 'package:csslib/parser.dart' show parseSelectorGroup, parse;
import 'dart:async';

/// A Polymer `<data-grid>` element.
@PolymerRegister('data-grid')
class DataGrid extends PolymerElement {
  /// Constructor used to create instance of MainApp.
  DataGrid.created() : super.created();

  ///direct control grid initialize
  SlickGrid get grid => _gw0.grid;
  JGrid _gw0;

  /// initialize grid by JGrid, a predefined grid tempalte
  void simpleInit(List data, List<Column> colDefs, {Map option}) {
    _gw0.init(data, colDefs, option: option);
    this.classes.add('resolved');
    var styleDom = new PolymerDom($['extStyle']).getDistributedNodes().first;
    String txt = styleDom?.text;
    if (txt.trim().length == 0) return;
    txt
        .replaceAll('\r', ' ')
        .replaceAll('\n', ' ')
        .split('}')
        .where((_) => _.trim().length > 0)
        .map((_) => '$_}')
        .forEach((_) => _gw0.setStyle(_));
    styleDom.text = '';
    styleDom.remove();
  }
  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
  void attached() {
    _gw0 = $['jgrid'];
  }

/**
 * enable column sort
 */
  List<Column> getColDefs(List<Column> cols) {
    List<Column> newCols = cols.map((col) => new Column.fromColumn(col)..sortable = true).toList();
    CheckboxSelectColumn checkboxCol = new CheckboxSelectColumn({'cssClass': "slick-cell-checkboxsel"});

    newCols.insert(0, checkboxCol.getColumnDefinition());
    return newCols;
  }
}
