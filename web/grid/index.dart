library samplegrid;

export 'package:polymer/init.dart';
import 'package:polymer_mx/data_grid.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';

import 'package:polymer_mx/combo_box.dart';
import 'package:slickdart/slick.dart' as grid;
import 'package:slickdart/slick_custom.dart';

main() async {
  registerElem();
  await initPolymer();
  new Future.delayed(new Duration(seconds: 1), () {
    DataGrid dg = querySelector('data-grid.simple-grid');
    List data = [];
    for (var i = 0; i < 500; i++) {
      data.add({'title': i + 1, 'start': "01/01/2009", 'finish': "01/05/2009", 'effortDriven': (i % 5 == 0)});
    }
    List columns = [
      new grid.Column.fromMap({'name': "id", 'field': "title", 'sortable': true}),
      new grid.Column.fromMap({'name': "start", 'field': "start"}),
      new grid.Column.fromMap({'field': "finish"}),
      new grid.Column.fromMap({'field': "effortDriven"}),
    ];
    var opt = new grid.GridOptions()
      ..enableColumnReorder = true
      ..explicitInitialization = false
      ..multiColumnSort = false
      ..frozenColumn = 1;
    print('init');
    dg.simpleInit(data, columns, option: opt.toJson());
  });
}
