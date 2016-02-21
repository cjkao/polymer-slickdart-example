library samplegrid;

export 'package:polymer/init.dart';
import 'package:polymer_mx/data_grid.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_mx/combo_box.dart';
import 'package:slickdart/slick.dart' as grid;
import 'package:slickdart/slick_custom.dart';
import 'package:slickdart/slick_selectionmodel.dart';
import 'package:slickdart/slick_column.dart';

main() async {
  registerElem();
  await initPolymer();
  new Future.delayed(new Duration(seconds: 1), () {
    DataGrid dg = querySelector('data-grid.simple-grid');
    List data = [];
    for (var i = 0; i < 500; i++) {
      data.add({'title': i + 1, 'start': "01/01/2009", 'finish': "01/05/2009", 'effortDriven': (i % 5 == 0)});
    }
    List columns = [];
    CheckboxSelectColumn checkboxCol = new CheckboxSelectColumn({'cssClass': "slick-cell-checkboxsel"});
    columns.insert(0, checkboxCol.getColumnDefinition());
    var opt = new grid.GridOptions()
      ..enableColumnReorder = true
      ..explicitInitialization = false
      ..multiColumnSort = false
      ..enableAddRow = true
      ..frozenColumn = 1;
    print('init');
    PaperInput pInput = document.querySelector('#pgInput');
    dg.polymerInit(data, columns, opt.toJson());
    dg.on['itemClick'].listen((CustomEvent _) {
      //detail is {rows: [14], grid: Instance of 'SlickGrid'}
      pInput.value = _.detail['rows'];
    });
    RowSelectionModel rsm = new RowSelectionModel({'selectActiveRow': true});
    dg.grid.onSelectedRowsChanged.subscribe((var e, args) {
      rsm.getSelectedRows().forEach(print);
    });
    dg.grid.setSelectionModel(rsm);
    //dg.grid.registerPlugin(checkboxCol);
    dg.grid.invalidate();
    dg.grid.render();
  });
}
