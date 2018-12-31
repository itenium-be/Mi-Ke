Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

A few fancy ones:

**Control+Win+Z**: Zips the entire folder, or just the selected files, in Windows Explorer.
([windows-explorer-zip-directory](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-windows-explorer/windows-explorer-zip-directory.ahk))  
**Control+Win+Alt+D**: Minimize all windows on monitor of active Window. Press again to restore.
([windows-min-max](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-other/windows-min-max.ahk))  
**Control+Alt+D**: Open Windows Explorer and select last downloaded file ([windows-explorer](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-windows-explorer/windows-explorer.ahk))  

# What

A script running in the background (tray icon) with little productivity boosters.

- Hotstrings to reduce amount of typing (atm -> at the moment)
- Shortcuts to start programs (win+o -> open solitaire.exe)
- Enhancements to programs (cmd, windows explorer, ...)
- Random scripts to do something I often do (did?) manually
- Dev tooling (encode/decode, prettify/uglify, convert, ...)

See the [Github Pages](https://itenium.be/Mi-Ke) for a listing of
all shortcuts and their default bindings.  
Or don't: the information on the site is pretty outdated.



# Install


## From source

Requires [Autohotkey_L](https://autohotkey.com/download).

PowerShell:
```ps
git clone https://github.com/itenium-be/Mi-Ke
cd Mi-Ke

# Start
.\mike.ahk
```

Personal customization (optional):  
```ps
# Add some custom config & examples
.\init.ps1

# If you do not want examples run the following instead
.\init.ps1 -bare
```

## Persist

To start Mi-Ke when Windows starts:

Put a `mike.ahk.lnk` in `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.  
In the right click contextmenu of the Mi-Ke tray icon there is also an option to do this for you.

More step by step instructions can be found
in the [official docs FAQ](https://www.autohotkey.com/docs/FAQ.htm#Startup)


### Mi-Ke doesn't work in Visual Studio

The scripts aren't working only when Visual Studio (or any other app) is running as administrator.  
The solution would be to also start Mi-Ke as administrator when you want the scripts to be available
in these applications.

More info:  
https://stackoverflow.com/questions/1890351/why-is-visual-studio-catching-key-events-before-autohotkey


# Known Issues

Binding `AppsKey & X` (with x any character) breaks AppsKey in Cmder.


# Tests

- Are in `spec`
- Need to end in `-tests.ahk`

Run tests:  
```ps1
.\tests.ps1
```

Framework:  
https://github.com/itenium-be/Yunit

Docs:  
https://github.com/Uberi/Yunit/blob/master/doc/Main.md
