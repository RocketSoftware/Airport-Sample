# Airport Sample

This sample is a Visual Studio native graphical console application that enables you to view the geographical location and the distance between airports. It shows how to use native COBOL to handle indexed data files. The information about the airport codes is stored in the airports.dat file.

This sample also demonstrates using the Micro Focus Unit Testing Framework for unit testing the Airport sample.

## Structure
The sample is structured into three projects:
* `src/aircode` - The program containing the business logic.
* `src/airport` - The program containing the UI logic.
* `test/AirportTests` - Unit tests for the **aircode** program.

The files include:
* `src/airport/airports.dat` - Data file with all airport records.
* `src/airport/Application.config` - Config file that defines the location of the .dat file to be used.

## Running the Sample

### Command line (msbuild)
1. Open a Developer Command Prompt for VS 2022.
2. Execute `msbuild Airport.sln /p:Configuration=Debug /p:Platform=x64` to build the sample.
3. Open a Visual COBOL or Enterprise Developer Command Prompt (64-bit).
4. Execute `cd bin\x64\Debug` to navigate to the directory containing the built binaries.
5. Execute `.\airport.exe` to run the sample.
6. Execute `mfurun AirportTests.mfu` to run all the tests.

### Visual Studio
1. Open Airport.sln.
2. Build the solution and start debugging.
3. Follow the instructions on the console. To see the available airport codes view the airports.dat file by opening it using the Data File Editor.
4. Open the "Micro Focus Unit Testing" tool window and click "Run All" to run all the unit tests.
5. To run the unit tests with code coverage, first edit the project properties of aircode and AirportTests, select the COBOL tab and check "Enable code coverage". Then click "Run with Code Coverage" in the "Micro Focus Unit Testing" tool window.

## License

Copyright (C) 2023 Micro Focus. All Rights Reserved.
This software may be used, modified, and distributed
(provided this notice is included without modification)
solely for internal demonstration purposes with other
Micro Focus software, and is otherwise subject to the EULA at
https://www.microfocus.com/en-us/legal/software-licensing.

THIS SOFTWARE IS PROVIDED "AS IS" AND ALL IMPLIED
WARRANTIES, INCLUDING THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE,
SHALL NOT APPLY.
TO THE EXTENT PERMITTED BY LAW, IN NO EVENT WILL
MICRO FOCUS HAVE ANY LIABILITY WHATSOEVER IN CONNECTION
WITH THIS SOFTWARE.
