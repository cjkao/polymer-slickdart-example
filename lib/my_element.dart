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

@PolymerRegister('date-el')
class DateEl extends PolymerElement {
  @property String selected = '0';
  @property bool locked = true;
  @property int maxItem = 3;
  DateEl.created() : super.created();
  void attached() {
    print('my elem attached');

    ComboBox pg = $['pgCombo'];
    pg.addSelectedItem("5");
    pg.removeSelectedItem("4");
  }

  @Listen('dialogBtn.tap')
  void clickPage2(event, [_]) {
    //  ($['page2dialog'] as PaperDialog).close();
    ($['page2dialog'] as PaperDialog).open();
  }
}
