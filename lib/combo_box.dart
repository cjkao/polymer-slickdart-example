@HtmlImport('combo_box.html')
library mx.combo_box;

import 'package:selectize/selectize.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:math';
import 'dart:js';
import 'dart:html';

///
///  populate [CustomEvent] change event when change selected element
///  pre-selected item will not pop event
///
///
@PolymerRegister('combo-box')
class ComboBox extends PolymerElement {
  int _nid = new Random().nextInt(1 << 32 - 1);
  Selectize _selectRoot;
  @property String removeButton;
  @property String dragDrop;
  @property String restoreOnBackspace;
  @Property(notify: true, reflectToAttribute: true) String valueList = '';
//  @Property(notify: true, reflectToAttribute: true) get valueList {
//    _valueList=_selectRoot?.items?.toString();
//    return _valueList;
//  }

  @Property(observer: 'lockChange') bool lock = false;

  /// max selectable items
  @property int maxItem = 1;

  @reflectable lockChange(bool newLock, bool oldLock) {
    if (newLock == true) {
      _selectRoot?.lock();
    } else {
      _selectRoot?.unlock();
    }
  }

  Object _observeHandle;
  ComboBox.created() : super.created() {
    print('created');
  }
  _changeHandler(value) {
    var e = new CustomEvent('change', detail: value);
    //this.attributes['value'] = value ?? '';
    this.dispatchEvent(e);
    this.valueList = value;
    //  set(valueList, value);
    //  var e2 = new CustomEvent('value-list-changed');
    //  this.dispatchEvent(e2);
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
    print('attached $lock');
    _observeHandle = Polymer.dom(this.$['pre-opt']).observeNodes((PolymerDomMutation info) {
      print('observe  $info');
      info.addedNodes.forEach((Node node) {
        ($['body'] as SelectElement).append(node);
        if (node is OptionElement) {
          _selectRoot.addOption(new OptValue(value: node.value, text: node.label));
          if (node.selected) _selectRoot.addItem(node.value, true);
          _showLabel(true);
        }
      });
    });

    ($['body'] as SelectElement)
      ..id = "$_nid"
      ..attributes['placeholder'] = placeHolder;
    //_getNodes(new PolymerDom($['pre-opt']).getDistributedNodes());
    var plugins = [];
    if (removeButton != null) plugins.add('remove_button');
    if (dragDrop != null) plugins.add('drag_drop');
    if (restoreOnBackspace != null) plugins.add('restore_on_backspace');
    //  print($['body'].id);
    _selectRoot = selectize(
        "#$_nid",
        new SelectOptions(
            maxItems: maxItem,
            onChange: allowInterop(_changeHandler),
            onInitialize: allowInterop(_initHandler),
            onFocus: allowInterop(_focusHandler),
            onBlur: allowInterop(_blurHander),
            plugins: plugins)); //'drag_drop'['restore_on_backspace', 'remove_button',]
    if (lock) _selectRoot.lock();
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
//n  @property String values;

  ///  json string to data to show options
  ///  [{label:"Red", data:"#FF0000"},
  ///   {label:"Green", data:"#00FF00"},
  ///    {label:"Blue", data:"#0000FF"}];
  set dataProvider(List data) => addOptions(data);

  ///item m
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
  void destory() {
    _selectRoot.destroy();
  }

  void detached() {
    super.detached();
    if (_observeHandle != null) new PolymerDom($['content']).unobserveNodes(_observeHandle);
    print('${localName}#$id was detached');
  }
}
