#! /bin/bash
# tool to test a .java file with JUnit

javac -cp .:/usr/share/java/junit4.jar $1
java -cp .:/usr/share/java/junit4.jar org.junit.runner.JUnitCore ${1%%.java}
