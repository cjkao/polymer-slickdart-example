# POLYMER + SLICKDART + Selectize

A starter template for a polymer.dart web app.

## Creating new elements

The `polymer` package includes a utility to generate new elements. From
within this project, run:


# layout guide
1. page height:100%
2. specify page content height explicit
3. grid with lazy initialize for IE

`pub run polymer:new_element <name>`

#combo box guide
1. combobox throw CustomEvent "change", can be `@Listen`
