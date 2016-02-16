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
  @property String selected = '0';
  @property String comboValue = '';
  @property bool locked = true;
  @property int maxItem = 3;

//  @reflectable
  @Listen('first-combo.change')
  pizzaChange(Event e, var detail) {
    print('header $detail');
    //change property to reflect binding
    set('comboValue', detail.toString());
  }

  DateEl.created() : super.created();
  void attached() {
    print('my elem attached');

    ComboBox pg = $['pgCombo'];
    pg.addSelectedItem("5");
    pg.removeSelectedItem("4");
    HttpRequest.getString('gss1983_Code-small.csv').then((data) {
      var csv = new grid.CsvAdapter(data);
      DataGrid dg = $['right-grid'];
      dg.simpleInit(csv.data, csv.columns, option: {'frozenRow': 1, 'frozenColumn': 0});
    });
  }

  //listen child event
  @Listen('dialogBtn.tap')
  void clickPage2(event, [_]) {
    ($['page2dialog'] as PaperDialog).open();
  }
}
