Lightweight dockerization of [Apache Zeppelin](http://zeppelin.incubator.apache.org/) project.
The image is created starting from [master branch](https://github.com/apache/incubator-zeppelin) source built by the following command:
```shell
mvn clean package -Pspark-1.5 -Dspark.version=1.5.2 -Dhadoop.version=2.6.0 -Phadoop-2.6 -DskipTests
```
Enjoy!
