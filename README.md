Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

Two fancy ones:

**Control+Win+Z**: Zips the entire folder, or just the selected files, in Windows Explorer. (apps/windows-explorer-zip-directory)  
**Win+Alt+D**: Minimize all windows on monitor of active Window. Press again to restore. (windows-min-max)  

# What

A script running in the background (tray icon) with little productivity boosters.

- Hotstrings to reduce amount of typing (atm -> at the moment)
- Shortcuts to start programs (win+o -> open solitaire.exe)
- Enhancements to programs (cmd, windows explorer, ...)
- Random scripts to do something I often do (did?) manually

See the [Github Pages](http://laoujin.github.io/Mi-Ke) for a listing of
all shortcuts and their default bindings.



# Install


## From source

Requires [Autohotkey_L](https://autohotkey.com/download).

PowerShell:
```ps
git clone https://github.com/Laoujin/Mi-Ke
cd Mi-Ke

# Create an initial setup with some examples
.\init.ps1

# If you do not want examples run the following instead
# It will create the file(s) required to start only
.\init.ps1 -bare

# Start
.\mike.ahk
```


## Persist

To start Mi-Ke when Windows starts:

Put a `mike.ahk.lnk` in `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.  
In the right click contextmenu of the Mi-Ke tray icon there is also an option to do this for you.

More step by step instructions can be found
in the [official docs FAQ](https://www.autohotkey.com/docs/FAQ.htm#Startup)


## Executable

Download the zip from the [release tab](https://github.com/Laoujin/Mi-Ke/releases).  
- Extract it
- Run mike.exe
- Much win

ATTN: While you'll be able to customize the shortcuts in mike.ini,
you will not be able to define any hotstrings and have the script
pick them up.
