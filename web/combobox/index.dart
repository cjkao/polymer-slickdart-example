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

  new Timer(new Duration(seconds: 1), () {
    var dynamicEl = document.createElement("combo-box");
    dynamicEl.setAttribute("id", "my-element-id");
    querySelector("body").append(dynamicEl);
    querySelector('combo-box').on['change'].listen((Event _) {
      print('value change');
      if (_ is CustomEvent) print(_.detail);
    });
    dynamicEl.destory();
  });
  ComboElement dynamicEl = document.createElement("combo-box");
  querySelector("body").append(dynamicEl);
  dynamicEl.destory();
  dynamicEl.remove();
}
