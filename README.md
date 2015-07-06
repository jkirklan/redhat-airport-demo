### Summary ###

This repository is for the RedHat Airport demo. Each component(iOS, Java, Angular) is currently separate. The deployment instructions are below.

### Technologies ###

* JBoss EAP(Weld CDI, RESTEasy, Hibernate)
* OpenShift
* JBoss Unified Push Server
* Hybrid iOS
* Estimote Beacons
* Apple Push Notification Server
* JavaScript(Webview)
* AngularJS (Digital Signage)
* Jenkins

### Setup ###

**Java/Red Hat Setup:**

Install RHC

1. Make sure you have [ruby installed](https://www.ruby-lang.org/en/documentation/installation/) and ensure it is update to date
2. Install rhc **sudo gem install rhc**
3. **rhc setup**
4. Login with your OpenShift account
5. Generating a token will allow you to login without a password for a day
6. Upload your SSH key to allow authentication to your remote server
7. Set your domain name

For more details: Go [here](https://developers.openshift.com/en/getting-started-osx.html#rhc-setup)

Create JBoss EAP Application:

1. Ensure RHC command line tools are set up
2. To create the application use **rhc app-create *appname* jbosseap**
3. The application will generate in the current working directory

**iOS Setup:**

1. cd into /redhat-airport-demo/Xcode/RedHat
2. sudo gem uninstall cocoapods
3. sudo gem install cocoapods
4. pod setup
5. pod update
6. Open RedHat.xcworkspace
7. Build and Run

* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact