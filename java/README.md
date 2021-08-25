# Java Agent Examples

# Introduction
This repository

# Deployment Models
* Single Application Image Deployment (build-time)
* Base(Parent) Image Deployment (build-time)
* [Init Container Deployment (runtime)](init_container/README.md)

The Contrast Java agent adds either Contrast Assess or Contrast Protect analysis to Java based applications. The agent analyzes Java web applications built on traditional application servers, and newer Java web applications such as those built with Netty, Play or Spring Boot. If there's a JVM, the Java agent can provide security insights.

As your application runs, the Java agent's sensors gather information about the application's security, architecture and libraries. You can see the results of the agent's analysis in Contrast.

# Prerequisites
Please review the following Java Agent documentation before proceeding:
* [Supported Technologies](https://docs.contrastsecurity.com/en/java-supported-technologies.html)
* [Installation](https://docs.contrastsecurity.com/en/install-the-java-agent.html)
* [Configuration](https://docs.contrastsecurity.com/en/java-configuration.html)

The examples in this repository also assume:
* Kubernetes version >= v1.14
* Docker (to build images)
