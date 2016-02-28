@HtmlImport('combo_box.html')
library mx.combo_box;

import 'package:selectize/selectize.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:math';
import 'dart:js';
import 'dart:html';
import 'dart:async';

///
///  populate [CustomEvent] change event when change selected element
///  pre-selected item will not pop event
///  max options is 100000
///
@PolymerRegister('combo-box')
class ComboBox extends PolymerElement {
  int _nid = new Random().nextInt(1 << 32 - 1);
  Selectize _selectRoot;
  @property String removeButton;
  @property String dragDrop;
  @property String restoreOnBackspace;
  @Property(notify: true, reflectToAttribute: true, observer: 'itemChange') List valueList;

  /// single value, always first value
  @Property(notify: true) Object value;
  @Property(observer: 'lockChange') bool lock = false;

  /// max selectable items
  @property int maxItem = 1;

  ///description when no select item
  @property String placeHolder;

  ///  json string to data to show options
  ///  [{label:"Red", value:"#FF0000"},
  ///   {label:"Green", value:"#00FF00"},
  ///    {label:"Blue", value:"#0000FF"}];
  @Property(observer: 'providerChange') List dataProvider;

  @reflectable providerChange(List data, List oldList) {
    if (_selectRoot == null) {
      return new Future.delayed(new Duration(seconds: 1), () => providerChange(data, oldList));
    }
    _selectRoot.clearOptions();
    if (data != null) addOptions(data);
  }

  /// parent to this child  control, but mixed with interal change event
  @reflectable itemChange(newValue, oldValue) {
    if (lock) {
      print('you need to un-lock combo');
      return;
    }
    //  print('item change $newValue');
    _selectRoot?.setValue(newValue, true);
  }

  ///internal change and reflect to combobox
  _changeHandler(List value) {
    var e = new CustomEvent('change', detail: value);
    this.dispatchEvent(e);
    set('valueList', value);
    set('value', value?.first);
  }

  /// parent to this combo, state control
  @reflectable lockChange(bool newLock, bool oldLock) {
    if (newLock == true) {
      _selectRoot?.lock();
    } else {
      _selectRoot?.unlock();
    }
  }

  Object _observeHandle;
  ComboBox.created() : super.created() {
    //  print('created');
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
      ..attributes['placeholder'] = placeHolder ?? '';
    var plugins = [];
    if (removeButton != null) plugins.add('remove_button');
    if (dragDrop != null) plugins.add('drag_drop');
    if (restoreOnBackspace != null) plugins.add('restore_on_backspace');
    _selectRoot = selectize(
        "#$_nid",
        new SelectOptions(
            maxOptions: 100000,
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

  ///item m
  void createItem(value) {
    _selectRoot.createItem(value);
    _selectRoot.refreshItems();
  }

  void addSelectedItem(String value, [bool silent = true]) => _selectRoot.addItem(value, true);
  void removeSelectedItem(String value, [bool silent = true]) => _selectRoot.removeItem(value, true);

  void addOption(String value, [String label]) {
    _selectRoot.addOption(new OptValue(value: value, text: label ?? value));
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
        _selectRoot.addOption(new OptValue(value: _['value'], text: _['label'] ?? _['value']));
      }
    });
  }

  void clearOptions() => _selectRoot.clearOptions();

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
