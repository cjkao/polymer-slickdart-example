@HtmlImport('my_element.html')
library my_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_spinner.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_dialog_scrollable.dart';
import 'package:polymer_elements/paper_dialog.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/neon_animation/animations/fade_out_animation.dart';
import 'package:polymer_mx/combo_box.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';
import 'package:slickdart/slick.dart' as grid;
import 'package:polymer_mx/data_grid.dart';
import 'package:polymer_mx/grid_column.dart';

@PolymerRegister('date-el')
class DateEl extends PolymerElement {
  @Property(observer: 'pageChanged') String selected = '0';
  @property String comboValue = '';
  @property String popComboValue = '';
  @property bool locked = true;
  @property int maxItem = 3;
  bool gridInit = false;
//  @reflectable
  @Listen('first-combo.change')
  pizzaChange(Event e, var detail) {
    set('comboValue', detail.toString());
  }

  @Listen('popCombo.change')
  popComboChange(Event e, var detail) {
    set('popComboValue', detail);
  }

  @Listen('mpages.change') pageChanged(int newValue, int oldValue) {
    if (newValue == 3 && !gridInit) {
      //forth page
      HttpRequest.getString('gss1983_Code-small.csv').then((data) {
        var csv = new grid.CsvAdapter(data);
        DataGrid dg = $['right-grid'];
        dg.polymerInit(csv.data, csv.columns, {'frozenRow': 1, 'frozenColumn': 0});
      });
    }
  }

  DateEl.created() : super.created();
  void attached() {
    print('my elem attached');

    new Future.delayed(new Duration(seconds: 1), () {
      ComboBox pg = $['pgCombo'];
      pg.addSelectedItem("5");
      pg.removeSelectedItem("4");
    });
  }

  //listen child event
  @Listen('dialogBtn.tap')
  void clickPage2(event, [_]) {
    ($['page2dialog'] as PaperDialog).open();
  }
}
