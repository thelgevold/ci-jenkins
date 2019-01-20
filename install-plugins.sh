docker exec -it jenkins bash -c 'cat /root/.jenkins/secrets/initialAdminPassword' > tmp.txt
AUTH=$(cat tmp.txt | tr -d "\n" | tr -d "\r")
rm tmp.txt
CMD="java -jar ~/.jenkins/war/WEB-INF/jenkins-cli.jar"
CMD="$CMD -auth admin:$AUTH -s http://127.0.0.1:8080/ install-plugin"

declare -a plugins=("workflow-aggregator" "blueocean" "github" "locale")

for plugin in "${plugins[@]}"
do
  docker exec -it jenkins bash -c "$CMD $plugin"
done