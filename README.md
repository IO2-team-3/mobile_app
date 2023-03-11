# mobile_app

## Getting Started (Windows)
IMPORTANT! Installing an emulator is **not** obligatory.
You can use your physical device but you have to turn on the _developer options_ first, and after connecting to the computer with an USB, allow for USB debugging.
### Installation
1. Follow the steps in the official [Flutter installation guide](https://docs.flutter.dev/get-started/install/windows).
2. Install the official Flutter extension for VS Code; [see here](https://docs.flutter.dev/get-started/editor).

### Running the app (emulator)
In VS Code, at the bottom-right you should see a button with the name of the currently selected device (most probably Windows).
Click on that button and select the previously installed emulator from the drop-down list.
After the emulator starts, go to `main.dart` file and select `Run` or `Debug` above the `main()` function.


If you prefer using the command line, type the following (exemplary command output is also shown)
```
> flutter emulators
1 available emulator:

Pixel_2_API_33 • Pixel 2 API 33 • Google • android
...

> flutter emulators --launch Pixel_2_API_33 

> flutter devices
4 connected devices:

sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64 • Android 13 (API 33) (emulator)
...

> flutter run -d emulator-5554
```
To terminate the session type `q`.

### Running the app (physical device)
After the device is connected, and permission for USB debugging is granted, run the following (exemplary command output is also shown)
```
> flutter devices
5 connected devices:

RMX3370 (mobile) • 6d51daf5 • android-arm64 • Android 13 (API 33)
...

> flutter run -d 6d51daf5
```
To terminate the session type `q`.

You can do the same from VS Code.
The steps are analogous to those in the case of running on an emulator.

### Troubleshooting
Installing Android Studio
* If you get an error `Missing essential plugin XYZ some plugin ...`, go to `C:\Users\ABC\AppData\Roaming\Google\AndroidStudioXXX` and delete the `disabled_plugins.txt` file.
*  If you get an error about a failed `HAXM` installation, don't worry -- you can live without it.

Installing VS Code extension
* If you get an error about VS Code being unable to install the extension, go to `C:\Users\ABC\AppData\Roaming\Code\CachedExtensionVSIXs` and remove all files with dart/flutter in the name.

Running the app on an emulator 
* If you get an error about your Android emulator being offline, go to Android Studio device manager and `wipe data` from the device.
