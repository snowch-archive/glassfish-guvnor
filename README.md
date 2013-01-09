glassfish-guvnor
================

A script to build a glassfish version of the Drools Guvnor war.

Tested with Guvnor 5.4 Final and Glassfish 3.1.2.2 (build 5)


steps
=====

Install Buildr - http://buildr.apache.org/installing.html

Download guvnor 5.4 - http://download.jboss.org/drools/release/5.4.0.Final/guvnor-distribution-5.4.0.Final.zip

Unzip guvnor-distribution-5.4.0.Final.zip

Edit buildfile, change path of bean_jar to your unzipped guvnor

Run "buildr clean package"

Deploy target/guvnor-distribution-1.0.0.war to Glassfish

thanks
======

Thanks to realityforge where this project was forked from.
