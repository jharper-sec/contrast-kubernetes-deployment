# Contrast Kubernetes Deployment Examples

# Introduction
This repository is dedicated to providing working examples of how to add Contrast instrumentation to applications running in Kubernetes clusters.

# Kubernetes Deployment Models
There are currently three deployment models planned to be covered by the examples in this repository:
* Single Application Image Deployment (build-time)
* Base(Parent) Image Deployment (build-time)
* Init Container Deployment (runtime)

## Pros & Cons of Deployment Models
Each deployment method has tradeoffs. It is important to understand these tradeoffs before implementing one of the above deployment methods.

### Application Image Deployment
Deploying to an application image is probably the easiest method of getting the agent deployed. This may be suitable for quickly getting Contrast up as a one-off deployment, such as during a POV. However, if implementing at any kind of scale, you will likely want to choose one of the following options instead. Another downside of this option is that  modifications and updates require rebuilding the application image.

### Base Image Deployment
If you are already using base container images for your applications, deploying the Contrast agent within these images can be a quick way to scalably roll out using this existing infrastructure. The main downside to this option is that updating the agent requires rebuilding the base image and any images that inherit from that base image.

### Init Container Deployment
Deploying using an init container is the most scalable of the above options. It does not require changing any `Dockerfile` manifests and if using `kustomize` to patch in agents you don't even have to modify Kubernetes deployment manifests. You can also easily apply agent updates without rebuilding your applications. The main downside to this approach is if you are also running the application within non-Kubernetes environments, such as developers running Docker locally, the agent will need to be made available by other means.

# Languages Implemented
The following table provides an overview and links to examples that are currently implemented by language.

| Language     | App Image     | Base Image     | Init Container                 |
| --------     | ------------- | -------------- | ------------------------------ |
| [Java](java) | No            | No             | [**Yes**](java/init_container) |
| .NET Core    | No            | No             | No                             |
| Node.js      | No            | No             | No                             |
| Ruby         | No            | No             | No                             |
| Python       | No            | No             | No                             |
| Golang       | No            | No             | No                             |
