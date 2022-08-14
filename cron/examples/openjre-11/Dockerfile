FROM openjdk:11-bullseye

COPY HelloWorld.java /

RUN javac HelloWorld.java
RUN jar cfe HelloWorld.jar HelloWorld *.class

FROM hub.cstcloud.cn/scalebox/cron:openjre-11

COPY --from=0 HelloWorld.jar /
COPY cron-run.sh /usr/local/bin
# java -jar HelloWorld.jar