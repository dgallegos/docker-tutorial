# Containers

## Containers and DevOps
> *“DevOps is about recognizing*

> *that the backing infrastructure is not separate from your application,*

> *but a vital part of it.”*


This is one of the fundamentals ideas about what makes containers great. Containers help sync your software with the infrastructure it relies on in versioned, consistent, and practical manner.

### History of Containers
Without going to deep into the history of containers. I'll state that some of the intial concepts of a container came around in the late 70s. 

Around 2008 LXC Linux Containers project implemented most of the initial software containers are built on today.

There are multiple Containerization platforms, just like VirtualBox vs VMware, there's Docker, RKT, and other platforms out there.

Today we're going to focus on Docker, which we'll get into later.

### Container Benefits

 - Infrastructure is Version Controlled
 - Environment Consistency between Developer/QA/UAT/Production
 - Operational Efficiency - Resources can be better managed

### Infrastructure is Version Controlled
When we build our containers, we will explicitly define the "distro" used (if any is required), the software dependencies (yum/apt-get), include any configuration files necessary, and include our application. Your application will be built with all the dependencies it needs and only the dependencies it needs. 

This file of instructions can be version controlled, along with the final image that's created.

### Environment Consistency
Containers encapsulate all the necessary application files and software dependencies and serve as a building block that can be deployed on any compute resource regardless of software, operating system, or hardware configurations. You can run the same container on your Ubuntu laptop and on your Red Hat Enterprise Linux production servers. 

 Whatever you package as a container locally will deploy and run the same way whether in testing or production. This is beneficial because you can deploy an application reliably and consistently regardless of environment. This helps you avoid manually configuring each serverr.

 - Has anyone ever asked the question what version of the JRE is running on a server?
 - Has anyone ever had a situation where something was installed on the production server that is causing the application to run differently in another environment?
 - Has anyone ever added a dependecy to their local envirionment, then forget to push it out to the servers?

### Operational Efficiency
With containers, you can specify the exact amount of memory, disk space, and CPU to be used by a container on an instance. Containers also have a reduced footprint compared to Virtual Machines.

 - Has anyone ever had multiple applications running on a VM and one application begins consuming all the CPU cycles or memory, starving the other applications?

## Difference Between Container and Virtual Machine

### Virtualization vs Container
![alt text](https://github.com/dgallegos/docker-tutorial/blob/master/lessons/images/container-vs-vm.png "Container vs VM")

 - VMs require Operating System, Dependencies, and Application
 - Containers only require Dependencies, and Applications. OS not required

### Container Benefits
 - Less Resource Overhead
 - Very quick boot times, which allow scaling more easily
 - Simpler Application Deployment
 - Explicitly Maintain System Configuration

## What's Docker?
Let's look at what Docker is next, [What's Docker?](https://github.com/dgallegos/docker-tutorial/blob/master/lessons/docker.md)


# References
-----
[What are Containers?](https://aws.amazon.com/what-are-containers/)

[Container vs VMs: What's the difference?](https://blog.netapp.com/blogs/containers-vs-vms/)
