---
title: Installing the Dtk Shell Client
order: 10
---

## Installing the DTK Shell Client  {#installation}

The main method of interacting with your DTK Server will be via the DTK Shell Client.  The client provides an easy to use context based experience enabling infrastructure engineers to deliver a self serve IT operations environments.

### System Requirements {#system-reqs}

*   **Linux Operating System:** Ubuntu, Rhel, OSX, CentOS
*   **Ruby:** 1.9.x, 2.x (recommended), Rubygems required
*   **Git:** latest 2.x recommended
*   One or more SSH private/public key pairs (id_rsa.pub will be automatically be used as default on initial shell client login)


**NOTE:**  The DTK Shell Client leverages Git as its SCM tool and uses it to communicate with the file repositories for your various infrastructure development projects.  Upon the first login-in, the client expects you to have git already installed and your Git username and email configs set.  If these Git configs are not set, the shell client will display an error message and ask you to correct the issue.

    john@test-client:~$ git config --add --global user.name "User Name"
    john@test-client:~$ git config --add --global user.email user@corp.com

**NOTE:** The DTK Shell Client requires you to setup an SSH key to use for secure Git communication.  You must register at least one SSH Public key by adding it to your account.  By default, when you login, the shell client will attempt to use your default public key at id_rsa.pub, it none exist it will prompt you to create one.

    john@test-client:~$ ssh-keygen -t rsa


### Installation on Bare Machine Image {#installation}
#### **Ubuntu** {#installation-ubuntu}

*  Update your package system: `apt-get update`
*  Install Ruby and Rubygems: either via rvm or for example if from package running `apt-get install ruby1.9.3 rubygems`
*  Install Git: `apt-get install git-core`
*  Initial DTk gem: `gem install dtk-client --no-ri --no-rdoc`

### First time DTK Shell Client Login {#first-login}

<p>The first time you login to your DTK Shell it will ask you for the following pieces of information</p>
*  DTK Server Address:  <your instance name>.dtk.io
*  Username: The username you entered when you signed up for your DTK Network Account
*  Password:  The password you chose

OK, you should now have the DTK Shell Client installed, configured, and ready for use.  Read on in further Getting Started Guides to learn more about the various areas of the DTK framework as well as some tips and tricks for getting up to speed quickly.