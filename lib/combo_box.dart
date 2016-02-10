@HtmlImport('combo_box.html')
library mx.combo_box;

import 'package:selectize/selectize.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:math';
import 'dart:js';
import 'dart:html';

@PolymerRegister('combo-box')
class ComboElement extends PolymerElement {
  int _nid = new Random().nextInt(1 << 32 - 1);
  Selectize _selectRoot;
  ComboElement.created() : super.created() {
    print('created');
  }
  _changeHandler(value) {
    var e = new CustomEvent('change', detail: value);
    this.dispatchEvent(e);
  }

  _initHandler() {
    this.classes.add('resolved');
  }

  _focusHandler() {
    _showLabel(true);
  }

  _blurHander() {
    //if blur and have selected itm
    if (_selectRoot.getValue() is String || _selectRoot.getValue().length > 0)
      _showLabel(true);
    else
      _showLabel(false);
  }

  void attached() {
    ($['body'] as SelectElement)
      ..id = "$_nid"
      ..attributes['placeholder'] = placeHolder;
    _getNodes(new PolymerDom($['pre-opt']).getDistributedNodes());

    //  print($['body'].id);
    _selectRoot = selectize(
        "#$_nid",
        new SelectOptions(
            maxItems: maxItem,
            onChange: allowInterop(_changeHandler),
            onInitialize: allowInterop(_initHandler),
            onFocus: allowInterop(_focusHandler),
            onBlur: allowInterop(_blurHander),
            plugins: ['restore_on_backspace', 'remove_button',])); //'drag_drop'
  }

  _showLabel(bool show) {
    if (show) {
      ($['label'] as SpanElement).classes.remove('hide');
    } else {
      ($['label'] as SpanElement).classes.add('hide');
    }
  }

  Options get options => _selectRoot.options;

  ///description when no select item
  @property String placeHolder;

  /// json string to data
  ///  [{label:"Red", data:"#FF0000"},
  ///   {label:"Green", data:"#00FF00"},
  //    {label:"Blue", data:"#0000FF"}];
  set dataProvider(List data) => addOptions(data);

  /// max selectable items
  @property int maxItem = 1;
  void createItem(value) {
    _selectRoot.createItem(value);
    _selectRoot.refreshItems();
  }

  void addSelectedItem(String value, [bool silent = true]) => _selectRoot.addItem(value, true);
  void removeSelectedItem(String value, [bool silent = true]) => _selectRoot.removeItem(value, true);

  void addOption(String data, [String label]) {
    _selectRoot.addOption(new OptValue(value: data, text: label ?? data));
  }

  ///  [optList] is string list
  ///  or OptValue list or Map of label and data list
  ///  [{label:'x', data:'zzz'},{}]
  void addOptions(List optList) {
    optList.forEach((_) {
      if (_ is String) {
        _selectRoot.addOption(new OptValue(value: _));
      } else if (_ is OptValue) {
        _selectRoot.addOption(_);
      } else if (_ is Map) {
        _selectRoot.addOption(new OptValue(value: _['data'], text: _['label'] ?? _['data']));
      }
    });
  }

  /// release event handler before dom element disappear
  ///
  void destory() {
    _selectRoot.destroy();
  }

  void detached() {
    super.detached();
    print('${localName}#$id was detached');
  }

  //move node to select
  void _getNodes(List _nodes) {
    for (int i = 0; i < _nodes.length; i++) {
      ($['body'] as SelectElement).append(_nodes[i]);
    }
  }
}
