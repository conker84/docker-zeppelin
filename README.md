Lightweight dockerization of [Apache Zeppelin](http://zeppelin.incubator.apache.org/) project.
The image is created starting from [master branch](https://github.com/apache/incubator-zeppelin) source built by the following command:
```shell
mvn clean package -Pspark-1.6 -Phadoop-2.4 -Ppyspark -DskipTests
```

Simple instructions to build the project

1. Build the project from GitHub:

  ```shell
      docker build -t conker84/zeppelin https://github.com/conker84/docker-zeppelin.git
  ```
2. Run the project:

  ```shell
      docker run -i -t -p 8080:8080 -p 8081:8081 conker84/zeppelin
  ```
3. Open the browser at **http://your_docker_machine_ip:8080**

Enjoy!
