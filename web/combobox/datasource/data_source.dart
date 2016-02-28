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

@PolymerRegister('combo-data-source')
class ComboDataSource extends PolymerElement {
  /// selected combobox value
  @property String comboValue = '';

  ///initialize combo data provider
  @property List comboSource = [
    {'label': "Red", 'value': "#FF0000"},
    {'label': "Green", 'value': "#00FF00"},
    {'label': "Blue", 'value': "#0000FF"}
  ];

  ///change data provider
  @Listen('btn.tap') changeCombo(event, _) {
    var src = [
      {'label': "Red_1", 'value': "red"},
      {'label': "Green_2", 'value': "green"},
      {'label': "Blue_3", 'value': "blue"}
    ];
    set('comboSource', src);
  }

  ///empty data provider
  @Listen('btnEmpty.tap') emptyCombo(event, _) {
    set('comboSource', null);
  }

  ComboDataSource.created() : super.created();
  void attached() {}
}
