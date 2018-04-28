Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

Two fancy ones:

**Control+Win+Z**: Zips the entire folder, or just the selected files, in Windows Explorer.
([apps/windows-explorer-zip-directory](https://github.com/itenium-be/Mi-Ke/blob/master/scripts/apps/windows-explorer-zip-directory.ahk))  
**Win+Alt+D**: Minimize all windows on monitor of active Window. Press again to restore.
([windows-min-max](https://github.com/itenium-be/Mi-Ke/blob/master/scripts/windows-min-max.ahk))  

# What

A script running in the background (tray icon) with little productivity boosters.

- Hotstrings to reduce amount of typing (atm -> at the moment)
- Shortcuts to start programs (win+o -> open solitaire.exe)
- Enhancements to programs (cmd, windows explorer, ...)
- Random scripts to do something I often do (did?) manually

See the [Github Pages](http://itenium.be/Mi-Ke) for a listing of
all shortcuts and their default bindings.



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
