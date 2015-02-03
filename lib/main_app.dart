// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:paper_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:slickdart/slick_custom.dart';
import 'package:slickdart/slick.dart';

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  @observable String reversed = '';

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created()
  {
    registerElem();  
  }
  

  void reverseText(Event event, Object object, PaperInput target) {
    reversed = target.value.split('').reversed.join('');
  }

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
    
    JGrid gw0=this.shadowRoot.querySelector('$GRID_TAG');
       HttpRequest.getString('gss1983_Code-small.csv').then((data) {
           CsvAdapter csv = new CsvAdapter(data);
           var cols = getColDefs(csv.columns);
           gw0.init(csv.data,cols, option:{'frozenRow':1});
    });
  }
  
  


/**
 * enable column sort
 */
List<Column> getColDefs(List<Column> cols) {
  List<Column> newCols = cols.map((col) => new Column.fromColumn(col)..sortable=true).toList();
  CheckboxSelectColumn checkboxCol = new CheckboxSelectColumn({
    'cssClass': "slick-cell-checkboxsel"
  });

  newCols.insert(0, checkboxCol.getColumnDefinition());
  return newCols;
}

    
  
  

       
       
//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//    super.ready();
//  }
}
