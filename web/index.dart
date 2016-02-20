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
import 'package:polymer_mx/data_grid.dart';

import 'package:slickdart/slick.dart' as grid;
import 'package:slickdart/slick_custom.dart';

main() async {
  registerElem();
//  jqSelectBootstrap();
  await initPolymer();

//  print(iTag.options);
  new Timer(new Duration(seconds: 1), () {
    var box = querySelector("combo-box.week") as ComboBox;
    for (int i = 0; i < 3; ++i) box.addOption('$i@c');
    box.addOptions([
      {'label': 'tainan', 'data': 'zz'}
    ]);
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
    dynamicEl.detached();
    dynamicEl.remove();
    for (int i = 0; i < 1; i++) {
      ComboBox dynamicEl = document.createElement("combo-box");
      querySelector("body").append(dynamicEl);
      dynamicEl.destory();

      dynamicEl.remove();
      print('$i');
    }
  });

  new Future.delayed(new Duration(seconds: 3), () {
    print('dg---');
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
  });
}
