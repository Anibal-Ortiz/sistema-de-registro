#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass any JVM options to Gradle and Java processes.
# For more information, see https://docs.gradle.org/current/userguide/build_environment.html
DEFAULT_JVM_OPTS=""

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
    [ -n "$APP_HOME" ] &&
        APP_HOME=`cygpath --unix "$APP_HOME"`
    [ -n "$JAVA_HOME" ] &&
        JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

# Attempt to find Java
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum number of open file descriptors
if [ "$cygwin" = "false" -a "$darwin" = "false" -a "$nonstop" = "false" ] ; then
    if [ "$MAX_FD" = "maximum" ] || [ "$MAX_FD" = "max" ] ; then
        # Use the maximum available
        MAX_FD_LIMIT=`ulimit -H -n`
        if [ $? -eq 0 ] ; then
            if [ "$MAX_FD_LIMIT" != 'unlimited' ] ; then
                ulimit -n $MAX_FD_LIMIT
            fi
        fi
    else
        ulimit -n $MAX_FD
    fi
fi

# Add the jar to the classpath
CLASSPATH="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"

# Set the default JVM options
if [ -z "$JAVA_OPTS" ]; then
    JAVA_OPTS="$DEFAULT_JVM_OPTS"
fi

# Set the command line options
GRADLE_OPTS="-Dorg.gradle.appname=$APP_BASE_NAME"

# Split up the JVM options string into an array, following the shell quoting and substitution rules
#
# This is a bit of a hack, but it's the only way to get shell quoting and substitution
# rules respected when we pass the JVM options to the java command.
#
# It's done by echoing the string and then reading it back into an array.
#
# The "x" is added to the beginning of the string to prevent echo from interpreting
# a string like "-e" as a command line option.
#
# The "z" is added to the end of the string to prevent the last word from being
# interpreted as a command line option.
#
# The "eval" is used to evaluate the string, which will perform the quoting and substitution.
#
# The "set --" is used to set the positional parameters to the words in the string.
#
# The "shift" is used to remove the "x" from the beginning of the array.
#
# The "while" loop is used to remove the "z" from the end of the array.
#
# The "set --" at the end is used to set the positional parameters to the words in the array.
#
# See https://stackoverflow.com/questions/10067266/how-to-split-a-string-into-an-array-in-bash
#
# As a compromise, this is not implemented for now. It's a bit of a hack, and it's not clear
# that it's worth the complexity.
#
# See https://github.com/gradle/gradle/issues/16872
#
# In the meantime, we'll just pass the string to the java command.
#

# Execute Gradle
exec "$JAVACMD" "$JAVA_OPTS" "$GRADLE_OPTS" -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"