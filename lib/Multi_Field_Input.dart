@HtmlImport('Multi_Field_Input.html')
library mx.combo_box;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input_behavior.dart';
import 'package:polymer_elements/paper_input.dart';
import 'dart:math';
import 'dart:js';
import 'dart:html';

@PolymerRegister('multi-field-input')
class MultiFieldInput extends PaperInput {
  int _nid = new Random().nextInt(1 << 32 - 1);

  MultiFieldInput.created() : super.created() {
    print('created');
  }

  /// max selectable items
}
