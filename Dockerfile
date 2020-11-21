FROM azul/zulu-openjdk-alpine:11

RUN wget -O h2-1.4.196.jar https://repo1.maven.org/maven2/com/h2database/h2/1.4.196/h2-1.4.196.jar

COPY sample.mv.db /root/

CMD ["java", "-cp", ".:h2-1.4.196.jar", "org.h2.tools.Server", "-webAllowOthers"]