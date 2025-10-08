@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Gradle startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass any JVM options to Gradle and Java processes.
@rem For more information, see https://docs.gradle.org/current/userguide/build_environment.html
set DEFAULT_JVM_OPTS=

set APP_NAME=Gradle
set APP_BASE_NAME=%~n0
set APP_HOME=%~dp0

@rem Use a rem below this point to large sections of text that contain
@rem text that looks like labels (e.g. :Abc) to avoid misinterpretation.
rem ##########################################################################

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem ##########################################################################

@rem Find the project's root directory
set PROJECT_DIR=%APP_HOME%

@rem Add the jar to the classpath
set CLASSPATH=%APP_HOME%gradle\wrapper\gradle-wrapper.jar

@rem Set the default JVM options
if "%JAVA_OPTS%" == "" set JAVA_OPTS=%DEFAULT_JVM_OPTS%

@rem Set the command line options
set GRADLE_OPTS=-Dorg.gradle.appname=%APP_BASE_NAME%

@rem Execute Gradle
"%JAVA_EXE%" %JAVA_OPTS% %GRADLE_OPTS% -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*

:fail
if "%OS%" == "Windows_NT" endlocal
exit /b 1