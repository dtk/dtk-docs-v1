---
title: Creating First Target
order: 20
---

In order to deploy Assemblies/Services in your own IT environments you must have 1 or more Providers.  This page will outline how to get started with your first provider, you can consult the Providers section for more usage and documentation details.  As a matter of better practices, we recommend using IAM users for granting access to your dtk instance when deploying dtk powered Services in your own AWS environment.

## Setting up an AWS IAM User  {#setting-up-aws-iam}

If you don't have an AWS account yet you can sign up for one at http://aws.amazon.com

Your DTK Server and shell client are able to carry out automation and infrastructure tasks on your behalf.  In order to perform these tasks in an authorized manner our system needs access credentials.  The preferred method for AWS users is to use their Identity and Access Management tool (IAM).  We recommend creating a "instance name".dtk.io user (ie: "john.dtk.io"), which will allow you to manage at an administrative level via the AWS Management Console which people and processes have access to your account.

To setup a new IAM user for your DTK instance login into your AWS account and navigate in the management console to the IAM section under "Deployment & Management"

![AWS IAM Console]({{site.assetsBaseDir}}/img/aws/aws-iam-01.png "AWS IAM Console")

If this is your first IAM account you are creating we recommend creating both a group and user for your DTK Server.  If you already have a group created you like to use for third party services you can add the user to it.  The create group popup screen looks like the following:

![AWS IAM Create Group]({{site.assetsBaseDir}}/img/aws/aws-iam-create-group-01.png "AWS IAM Create Group")

It will then ask you to enter some settings for your group template

*  **Select Policy Template:** We recommend selecting "Power User Access" and require either that or "Administrator Access"

When you select your User Type it will present you with a new popup providing the policy information

![AWS IAM Create Group Policy]({{site.assetsBaseDir}}/img/aws/aws-iam-create-group-policy-01.png "AWS IAM Create Group Policy")

Finally you will be prompted with the Create confirmation dialogue, click "Create"

Next you will create a new user and add it to your pre-existing, or newly created group.  Click on "Users" on the left side of the IAM dashboard and click the "Create New User" button at the top.  You will be presented with a dialogue to enter one or more user names, as well as a choice to "Generate an access key for each user".  Enter your DTK Server instance name (ie: "john.dtk.io") and make sure you have checked the box to generate an access key:

![AWS IAM Create Policy Confirmation]({{site.assetsBaseDir}}/img/aws/aws-iam-create-group-policy-01_0.png "AWS IAM Create Policy Confirmation")

You should then be presented with a final confirmation dialogue, make sure to write down your Security Credential or click on the "Download Credentials" button at the bottom left:

![AWS IAM Download Creds]({{site.assetsBaseDir}}/img/aws/aws-iam-create-group-policy-01_0.png "AWS IAM Download Creds")



## Adding a Provider {#adding-provider}


While logged into the dtk-shell and should be at the `dtk:/>` prompt.  You can add your first provider by navigating to the Provider context:

`dtk:/>cd provider`

The DTK currently supports the following Provider types:

*   Amazon Web Services (AWS)
*   Physical

You can add, edit, remove Providers from the shell client under the providers context


Lets setup an initial AWS Provider to get you going.  You can navigate to the run the `create-provider-ec2` command and provide the appropriate parameters:



{% highlight bash linenos %}
dtk:/provider>create-provider-ec2 dev1 --keypair dtk-aws-key --security-group dtk,dev1
 Enter 'IAAS Credentials':
        Key: AKGAYGJ..
        Secret: xI7....

Status: OK
{% endhighlight %}


Where `dev1` is the **PROVIDER-NAME**, `--keypair dtk-aws-key` is a keypair your AWS account has a reference to add to the nodes that will be launched under this provider, and `--security-group dtk,dev1` being a comma separated list of security groups to assign to all targets created for this Provider (NOTE: `--keypair` and `--security-group` are temporarily required for legacy customer/version support).

After executing the `create-provider-ec2` command it will prompt you for AWS key/secret credentials to use in AWS API calls.  We recommend using AWS IAM users to grant your DTK Instance access to your AWS Provider.  For details on how to setup an IAM user if you are unfamiliar you can see the "Setting up an AWS IAM User"



Next you need a Target to deploy Service Instances to.  Targets can be thought of as a "network container" for your running services.  We will create an initial VPC target in this example.  In the current implementation you will need to pre-create a VPC and make note of the subnet you would like to use to deploy to. (NOTE: current Target deployment is restricted to a single subnet)


Navigate to the Target context by running `cd /target` then create an ec2 vpc target:


{% highlight bash linenos %}
dtk:/target>create-target-ec2-vpc dev1-target-01 --provider dev1 --region us-east-1 --subnet subnet-f7c9 --keypair dtk-aws-key --security-group dtk-01
Status: OK
{% endhighlight %}

Finally you can set your newly created target as your "default target" so that any service instance deployed will use that target:


{% highlight bash linenos %}
dtk:/target>set-default-target dev1-target-01
Status: OK
{% endhighlight %}

OK, you should now have your first working Target to deploy Services to.  Read on in further Getting Started Guides to learn more about the various areas of the DTK framework as well as some tips and tricks for getting up to speed quickly.