@HtmlImport('data_grid.html')
library mx.data_grid;

import 'dart:html';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:polymer/polymer.dart';
import 'package:slickdart/slick_custom.dart';
import 'package:slickdart/slick.dart';

/// A Polymer `<data-grid>` element.
//@CustomTag('main-app')
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
  }
  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
  void attached() {
    registerElem();
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

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//    super.ready();
//  }
}
