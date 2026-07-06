mvn clean package | Out-File -FilePath .\mvn.txt -Encoding utf8
cp .\target\web-zy12.war ..\tomcat_webapps\
shutdown.bat
sleep 5
startup.bat
