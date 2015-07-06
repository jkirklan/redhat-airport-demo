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
2. Install rhc `sudo gem install rhc`
3. `rhc setup`
4. Login with your OpenShift account
5. Generating a token will allow you to login without a password for a day
6. Upload your SSH key to allow authentication to your remote server
7. Set your domain name

For more details: Go [here](https://developers.openshift.com/en/getting-started-osx.html#rhc-setup)

Create JBoss EAP Application:

1. Ensure RHC command line tools are set up
2. To create the application use `rhc app-create *appname* jbosseap`
3. The application will generate in the current working directory

**iOS Setup:**

1. cd into /redhat-airport-demo/Xcode/RedHat
2. `sudo gem uninstall cocoapods`
3. `sudo gem install cocoapods`
4. `pod setup`
5. `pod update`
6. Open RedHat.xcworkspace
7. Build and Run

**Digital Signage/Webview Setup:**

Front End Dependencies:
* Node.js
* Bower
* Grunt
* Gulp

Digital Signage Directory:

1. Install bower components with `bower install`
2. Install node modules with `npm install`
3. Run client with `grunt watch`
4. Build production files with `grunt compile`

Webview Directory:

1. Install bower components with `bower install`
2. Install node modules with `npm install`
3. Run client with `gulp serve`
4. Build production files with `gulp build`

### Deployment ###

**Building Project**

1. Install [Maven](https://maven.apache.org/download.cgi)
2. Pull Java Project from bitbucket/github
3. Build the mobile app files and place the html/js files in src/main/webapp. Build the signage and place it in src/main/webapp/signage 
4. Using the command line navigate to the root of the project (Where the pom.xml is)
5. Run command `mvn clean install`
6. Upon Success a [projectname].war file will be generated in the target folder

**Using SFTP client (Filezilla):**

Host: sftp://redhatairportdemo-fguanlao.rhcloud.com
Username: 556e1ae34382ece1dd00010a

The id_rsa generated when you created the project will need to be added:
1. Open FileZilla
2. Go to FileZilla > Settings > SFTP
3. Select "Add keyfile..."
4. Select where you saved the "id_rsa" key

**Deploying to OpenShift**

1. Using FileZilla connect to the JBoss Server 
2. On the server navigate to */var/lib/openshift/556e1ae34382ece1dd00010a/app-root/dependencies/jbosseap/deployments/*
3. Delete any ROOT.war or ROOT.war.deployed if it exists
4. On your local side navigate to the "/target" folder in the java project folder
5. Rename the [projectname].war file to ROOT.war
6. Drag the war file to the server
7. You will know it's deployed when a ROOT.war.deployed generates

### Contact ###
