@HtmlImport('data_source.html')
library test.combo.data.source;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_radio_button.dart';
import 'package:polymer_mx/combo_box.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';
import "package:observe/observe.dart";
import "package:polymer_autonotify/polymer_autonotify.dart" show AutonotifyBehavior;

class MyModel extends Observable {
  @observable List comboSource;
  @observable String comboValue;
  @observable List comboList;
}

@PolymerRegister('combo-data-source')
class ComboDataSource extends PolymerElement with AutonotifyBehavior, Observable {
  @observable
  @property
  MyModel model;

  ///initialize combo data provider
  //@property List comboSource;

  ///change data provider
  @Listen('btn.tap') changeCombo(event, _) {
    var src = [
      {'label': "Red_1", 'value': "red"},
      {'label': "Green_2", 'value': "green"},
      {'label': "Blue_3", 'value': "blue"}
    ];
    model.comboSource = src;
  }

  @Listen('btnhex.tap') changeComboHex(event, _) {
    var src = [
      {'label': "Red FF0000", 'value': "#FF0000"},
      {'label': "Green 00FF00", 'value': "#00FF00"},
      {'label': "Blue 0000FF", 'value': "#0000FF"}
    ];
    model.comboSource = src;
  }

  ///empty data provider
  @Listen('btnEmpty.tap') emptyCombo(event, _) {
    model.comboSource = null;
  }

  ComboDataSource.created() : super.created();
  void attached() {
    model = new MyModel();
  }
}
