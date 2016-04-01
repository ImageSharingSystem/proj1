export CLASSPATH=$CLASSPATH\:/oracle/jdbc/lib/ojdbc6.jar:/usr/local/catalina/lib/servlet-api.jar
export CLASSPATH=$CLASSPATH\:.\:/cshome/$USER/catalina/webapps/proj1/WEB-INF/lib/ojdbc6.jar
export CLASSPATH=$CLASSPATH\:.\:/cshome/$USER/catalina/webapps/proj1/WEB-INF/lib/commons-fileupload.jar
export CLASSPATH=$CLASSPATH\:.\:/cshome/$USER/catalina/webapps/proj1/WEB-INF/lib/commons-io.jar

JAVAC=javac
sources = $(wildcard *.java)
classes = $(sources:.java=.class)

all: $(classes)

clean :
	rm -f *.class

%.class : %.java
	$(JAVAC) $<
