#!/bin/sh
JAVA_LIB=../lib
TOMCAT_LIB=/opt/tomcat/lib
WEBAPP_CLASSES=classes
OLD_PWD=`pwd`

case "$1" in
clean)
	find $WEBAPP_CLASSES -name "*.class" -exec rm {} \;	
	;;

compile)
	cd $WEBAPP_CLASSES/
	javac -classpath $(echo . $JAVA_LIB/*.jar $TOMCAT_LIB/*.jar | sed 's/ /:/g') edu/usc/sirlab/*.java edu/usc/sirlab/db/*.java edu/usc/sirlab/kml/*.java edu/usc/sirlab/tools/*.java 
	cd $OLD_PWD
	;;
*)
	echo -e "Usage: $0 {compile | clean}"
	;;
esac
