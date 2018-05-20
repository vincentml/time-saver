# Time Saver

This project does two things. 
First, it is a time saver for a task that is frequently done.
Second, it provides me a way to experiment with [Saxon-JS](http://www.saxonica.com/saxon-js/index.xml) and [BaseX](http://basex.org/).

## Getting Started

Double-click on gradlew.bat, or from the command prompt, run:

```
.\gradlew basexStart
```

Then point a web browser to http://localhost:8984/

## Developing

XSLT has to be compiled before it can be run in a web browser by Saxon-JS. To compile XSLT for Saxon-JS, open the XSLT in [oXygen XML Editor](https://www.oxygenxml.com/), go to the _Tools_ menu, then _Compile XSLT stylesheet for Saxon_.

So far has only been tested using the Chrome browser.

## WordPress Updates to Excel

This form converts the text of the WordPress Updates page to a spreadsheet. The spreadsheet can the be used in Excel to make notes while applying updates to a WordPress site. 

Usage:

1. Go to a WordPress dashboard and navigate to the Updates page. Select everything on this page, and copy. 

2. Paste into the _WordPress Updates Page to Excel_ form, and press Convert.

3. This will produce a CSV file which can be opened and edited in Excel.
