@HtmlImport('data_grid.html')
library mx.data_grid;

import 'dart:html';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer_mx/grid_column.dart';

import 'package:polymer/polymer.dart';
import 'package:slickdart/slick_custom.dart';
import 'package:slickdart/slick.dart';
import 'package:csslib/parser.dart' show parseSelectorGroup, parse;
import 'dart:async';

/// A Polymer `<data-grid>` element.
/// dispatch 'itemClick' event on selected row change
@PolymerRegister('data-grid')
class DataGrid extends PolymerElement {
  /// Constructor used to create instance of MainApp.
  DataGrid.created() : super.created();

  ///direct control grid initialize
  SlickGrid get grid => _gw0.grid;
  JGrid _gw0;

  /// column can be defined by [grid_column] element
  /// initialize grid by JGrid, a predefined grid tempalte
  void polymerInit(data, [List<Column> colDefs = const [], Map option = const {}]) {
    //if (colDefs.length == 0) {
    var columnDoms = new PolymerDom($['gridColumn']).getDistributedNodes();
    columnDoms.forEach((GridColumn _) {
      print(_.dataset['field']); //gc.w
      print(_.width); //gc.w
      Column col = new Column();
      col
        ..field = _.dataset['field']
        ..width = _.width ?? 80
        ..resizable = _.resizable
        ..name = _.headerText ?? _.dataset['field'];
      colDefs.add(col);
    });
    //  }

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
    _gw0.grid.onSelectedRowsChanged.subscribe((Object e, Object parm) {
      var e = new CustomEvent('itemClick', detail: parm);
      this.dispatchEvent(e);
    });
  }

  /// Called when an instance of main-app is inserted into the DOM.
  void attached() {
    _gw0 = $['jgrid'];
  }

  void detached() {
    _gw0.detached();
  }
}
