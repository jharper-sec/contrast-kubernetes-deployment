# Java - Init Container Deployment

# Introduction
The Init Container method of deploying the Contrast Java Agent to the WebGoat application. Kustomize is used in this example to apply changes without modifying the original Kubernetes manifests.

# Implementation
An Init Container is a specialized container that run before the app container in the Pod.

For this example, the Init Container contains the Contrast Java agent. When the Pod starts, the Init Container is run before the app and does the following before exiting:
1. Mounts a shared volume to the Init Container.
1. Copies the `contrast-agent.jar` file from the Init Container to the shared volume.

When the Init Container exits, the app container starts and does the following:
1. Mounts the `contrast-agent.jar` from the shared volume containing the agent.
1. Mounts the `contrast_security.yaml` configuration from a Kubernetes Secret.
1. Uses environment variables set within the deployment to specify the location of the agent and the configuration files.

![](../../images/kubernetes-init-containers-java-agent.png)

## Kustomize
Kubernetes >= v1.14 ships with Kustomize. Kustomize allows us to dynamically patch in the Contrast Java Agent and configuration files as an overlay without actually modifying the Kubernetes deployment manifest, which is neat.

In our example, we have an unmodified deployment in `base` folder along with a `kustomization.yaml` file. This Kustomize file is just a reference used by the overlays to determine which `base` resource(s) to apply transformations on (in this case just the `deployment.yaml` file).
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - deployment.yaml
```

In the `overlay/contrast/kustomization.yaml` example file, we are doing the following:
* Patching in modifications from the `contrast-java-agent.yaml`
* Generating a Kubernetes Secret object from the `contrast_security.yaml` file.
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
- ../../base
patchesStrategicMerge:
  - contrast-java-agent.yaml
secretGenerator:
  - name: contrast-security
    files:
    - contrast_security.yaml
```

# Running the example

## Building Images
You first need to build the images locally, as these are not currently deployed to an image repository. The `docker` folder contains the image manifests. The following command will build the `contrast/webgoat` application image and the `contrast/java-agent` agent image.
```bash
./docker/build_images.sh
```

## Download the `contrast_security.yaml` file
After those images are built, you will need to make sure you download a valid `contrast_security.yaml` file into the `overlays/contrast` folder. This will be used when generating a Kubernetes Secret using the Kustomize `secretGenerator`. There are two other side benefits of using Kustomize here:
1. Kustomize will generate a unique hash when creating the secret. If the `contrast_security.yaml` configuration is modified the hash will change and the Deployment will use the new configuration.
1. You don't have to create a separate Secret object definition, as this is done during `apply`. Without Kustomize you would need to copy the `contrast_security.yaml` config to a Secret object, meaning you would have to manage the config in two places.

## Deploy using Kustomize
Running the following command will `apply` using Kustomize, patching in the modifications made within the `contrast-java-agent.yaml` file and generating the secret from `contrast_security.yaml`.
```bash
kubectl apply -k overlays/contrast
```

## Delete Deployment
After you are finished, you can run the following command to destroy the created resources:
```bash
kubectl delete -k overlays/contrast
```