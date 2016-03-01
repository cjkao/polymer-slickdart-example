@HtmlImport('parent.html')
library test.combo.parent;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_radio_button.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_mx/combo_box.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';

@PolymerRegister('combo-el')
class ComboEl extends PolymerElement {
  ///host value, bind selected item in comboBox and host value
  @property String comboValue = '';
  @property List comboValueArr;
  @property bool locked = true;
  @Listen('changeComboBtn.tap') changeCombo(event, _) {
    //we try to change combo value, beware, combo box must not locked
    set('comboValue', '4');
  }

  ///give combo box with wrong value result no value change
  @Listen('xComboBtn.tap') xchangeCombo(event, _) {
    set('comboValue', '114');
  }

  @Listen('multiComboBtn.tap') changeComboList(event, _) {
    set('comboValueArr', ['Pizza_F', 'Pizza_E']);
    //  ($['ripple'] as PaperRipple).holdDown = true;
    //  new Future.delayed(new Duration(milliseconds: 100), () => $['ripple'].holdDown = false);
  }

  ComboEl.created() : super.created();
  void attached() {
    print('combo el attached');

    new Future.delayed(new Duration(seconds: 1), () {
      //    ComboBox pg = $['pgCombo'];
      //    pg.addSelectedItem("5");
      //    pg.removeSelectedItem("4");
    });
  }
}
