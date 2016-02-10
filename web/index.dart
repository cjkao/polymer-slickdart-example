library sampleTodo;

export 'package:polymer/init.dart';
import 'package:polymer_mx/my_element.dart';
import 'package:polymer_mx/combo_box.dart';
import 'package:polymer_mx/data_grid.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';
import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';

import 'package:slickdart/slick.dart' as grid;

main() async {
//  jqSelectBootstrap();
  await initPolymer();
  var box = querySelector("combo-box") as ComboElement;
//  box.dataProvider = {};
  for (int i = 0; i < 3; ++i) box.addOption('$i@c');
  box.addOptions([
    {'label': 'tainan', 'data': 'zz'}
  ]);
  ComboElement pg = querySelector('#pgCombo');
  pg.addSelectedItem("5");
  pg.removeSelectedItem("4");
//  var el2 = document.querySelector("combo-box");
//  print(iTag.options);
  new Timer(new Duration(seconds: 1), () {
    //  querySelector("#acc").remove();
    var dynamicEl = document.createElement("combo-box");
    dynamicEl.setAttribute("id", "my-element-id");
    querySelector("body").append(dynamicEl);
    querySelector('combo-box').on['change'].listen((Event _) {
      print('value change');
      if (_ is CustomEvent) print(_.detail);

      ///not always custom event
    });
    dynamicEl.destory();
//      dynamicEl.remove();
  });
  for (int i = 0; i < 1; i++) {
    ComboElement dynamicEl = document.createElement("combo-box");
    querySelector("body").append(dynamicEl);
    dynamicEl.destory();

    dynamicEl.remove();
    print('$i');
  }
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

  dg.simpleInit(data, columns, option: opt.toJson());

  HttpRequest.getString('gss1983_Code-small.csv').then((data) {
    var csv = new grid.CsvAdapter(data);
    DataGrid dg = querySelector('data-grid.right-grid');
    dg.simpleInit(csv.data, csv.columns, option: {'frozenRow': 1});
  });
}
