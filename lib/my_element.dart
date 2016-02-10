@HtmlImport('my_element.html')
library my_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import "package:autonotify_observe/autonotify_observe.dart";

//import "package:polymer_datepicker/polymer_datepicker.dart";

@PolymerRegister('date-el')
class DateEl extends PolymerElement {
  @Property(notify: true)
  String color = 'red';

  void changeVal() {
    set('color', 'green');
    fire("change", detail: 'XZ');
  }

  @observable
  @property
  DateTime myDate;

  DateEl.created() : super.created();
}
