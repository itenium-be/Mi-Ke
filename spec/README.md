Yunit
=====

Framework:  
https://github.com/Uberi/Yunit

Docs:  
https://github.com/Uberi/Yunit/blob/master/doc/Main.md

## Run tests

tests.ps1  
TODO: Add watchdog to auto-rerun tests on changes.  
TODO: Show some tray notification on errors.  
TODO: Create runner that accepts parameters: -Suite suiteName -Watch true/false -Porcelain  
TODO: Runner reads all ahk files and then does the Yunit.Use(YunitStdOut).Test(suiteName) once (watch out for paths troubles...)  


Yunit  
TODO: Add Yunit.that(expected, actual) so that there is a better error message!  
TODO: Add x(ignore) and f(force) prefixes?  
TODO: calculate totals (JUnit.ahk already does this)  
TODO: check output of Jest and do something like that? (add filename: A_ScriptName)  


Run testsuite:  
```
cd spec\business-tools\
AutoHotkey "format-mobile-number-tests.ahk" | more
```
