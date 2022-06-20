Instavote - Example Voting App
=========

Architecture
-----

![Architecture diagram](architecture.png)

* A Python webapp which lets you vote between two options
* A Redis queue which collects new votes
* A .NET worker which consumes votes and stores them in…
* A Postgres database backed by a Docker volume
* A Node.js webapp which shows the results of the voting in real time


<b>Note</b>: The voting application only accepts one vote per client. It does not register votes if a vote has already been submitted from a client.

Continuous Integration Pipelines
-----
01. Create a secret (regcred) to allow Jenkins push images to Dockerhub:  
```
kubectl create secret -n jenkins docker-registry regcred \
--docker-server=https://index.docker.io/v1/ \
--docker-username=<dockerhub-username> --docker-password=<dockerhub-password> \
--docker-email=<dockerhub-email>
```

02. Create variables for SonarCloud tokens:
Add the following variables as secret text, in `Manage Jenkins > Manage Credentials > Global`:
- sonar-instavote-vote   = SonarCloud Token for Vote app
- sonar-instavote-worker = SonarCloud Token for Worker app
- sonar-instavote-result = SonarCloud Token for Result app

03. Create a new Jenkins Multibranch Pipeline <b>for each app</b> (vote,worker,result) with:
- Source as GitHub repo (eg. https://github.com/xvag/instavote-ci.git)
- Build mode "by Jenkinsfile" with Script Path pointing to the Jenkinsfile (eg. worker/Jenkinsfile)
