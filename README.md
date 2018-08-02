Spring Boot Demo
----------------

This repository is a model for development using Spring Boot in a Docker container.  This is intended as a starting point for new applications.  Ideally, anyone with or without development experience should be able to get this working while only having maven and java installed.

How do I run this locally?
-------------------

With this in your local repo, you can run "java -jar target/spring-demo-0.0.1-SNAPSHOT.jar".

How do I run this on OpenShift?
----------------------------

Running this application requires one command:

```
oc new-app https://github.your-corp.com/hosting-name/springapp.git --name=spring-demo
```

Subsequent image builds can be run with:

```
oc start-build spring-demo
```

And when you want to delete everything that this command created, run the command:

```
oc delete all -l app=spring-demo
```

Note that this requires the OpenShift CLI application and a project in OpenShift v3 previously setup.

How do I mature this application?
---------------------------------

#### CI/CD

At some point, you may want to set up Continuous Integration and Deployment with this application.  While the above method for running this on OpenShift is effective for prototyping, using Jenkins to create environments and trigger deployments may be more accurate in a team environment.  To set this up, your commands to create envrionments and trigger deployments become:

```
oc new-build --strategy=docker --binary=true --name={name} -l app={app}
oc start-build {name} --from-dir=. --follow=true
oc new-app -i {name} -l app={name}
oc expose svc {name}
```

...and... 

```
oc start-build {name} --from-dir=. --follow=true
```

...respectively.

One other important improvement would be to not perform the first half of the image build as defined in the Dockerfile every time a deployment is performed.  If time to deploy is to be optimized, the only part of the image build that should be performed in OpenShift should be moving the .jar file to the /opt/your-corp directory.  Docker Trusted Registry would be the recommended option to host the intermediate image.

#### Chaining Dockerfiles

While trying to use this for development, you may note that the build takes time to complete.  The majority of what exists in the Dockerfile does not change often.  Pretty much "COPY /src/main/resources/ /opt/your-corp/ \ COPY /target/*.jar /opt/your-corp/app.jar" is the only thing that changes every time the project builds.  To speed up build times, there should be two Dockerfiles, one with things that do not frequently change and one with things that frequently change.  The first Dockerfile and resultant image can be referred to as the base image.  The second Dockerfile will reference the base image in the "FROM" line of the Dockerfile.
