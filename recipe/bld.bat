@echo on

set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%;%RECIPE_DIR%

:: Configure.
cmake -S . -B build -G "NMake Makefiles JOM" %CMAKE_ARGS%
if errorlevel 1 exit 1

:: Build.
cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

:: Test.
cmake --build build --target test --parallel %CPU_COUNT%
if errorlevel 1 exit 1

:: Install.
cmake --install build --parallel %CPU_COUNT%
if errorlevel 1 exit 1
