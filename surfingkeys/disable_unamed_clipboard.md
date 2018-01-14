# How to disable copying text into the clipboard when the unnamed register is set in ACE vim:

## Location of plugin:

The location of Opera's settings can be found as the `Profile` path from the `opera://about` page.

### MacOS:
+ `${HOME}/Library/Application Support/com.operasoftware.Opera/Extensions`

### Linux:
+ `${HOME}/.config/opera/Extensions`

## Edit editor.js
+ `find . -name "editor.js"`
+ Remove: `Clipboard.write(date.text)`
    + This file is minified so some care needs to be taken when editing
