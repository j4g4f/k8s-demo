# k8s-demo

## Initial Thoughts

Since this is my first time installing k8s on a Macbook (or anywhere other than a trial of Rancher), I decided on minikube.  The two main decision criteria I had were:

1.  It seems to be very widely used.
2.  As a project, it identifies itself as an ideal candidate for learning k8s.

### Installation

Installation of the basic items needed was trivial thanks to homebrew and docker desktop:

1.  Download and install Docker Desktop
2.  Install minikube:
    -  **brew install minikube**
3.  Install kubectl
    - **brew install kubectl**

### Validate Install

We can use the kubectl command to ensure that our cluster is up, and kubectl can connect to it:

>jgollner@Josephs-MacBook-Pro workspace % kubectl cluster-info \
\
Kubernetes control plane is running at https://127.0.0.1:49305

If minikube isn't running, the cluster will return an error state:

>jgollner@Josephs-MacBook-Pro workspace % kubectl cluster-info \
\
To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
The connection to the server localhost:8080 was refused - did you specify the right host or port?

### Setup Ingress

Minikube provides an nginx ingress controller addon that can be used to provide ingress services to a deployment.  While not suitable to a production application, it makes the act of opening a deployed service to external connections trivially easy.

To enable the addon, run:

>minikube addons enable ingress \
\
... \
\
🌟  The 'ingress' addon is enabled

Validate that the pod is running:

>kubectl get pods -n ingress-nginx \
\
**ingress-nginx-controller-cc8496874-cxh5n   0/1     Running     0          22s**

## Create the Application Service(s)

Now, we need to create our deployments for our applications.  kubernetes.io provides a nice, simple hello-world app for this purpose.  

**First, Create Deployments**
>kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0

>Output: \
deployment.apps/web created

>kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:1.0

>Output:\
deployment.apps/web2 created

**Second, Open Access on the Node**
>kubectl expose deployment web --port=8080 
--type=NodePort

>kubectl expose deployment web2 --port=8080 --type=NodePort

>Output: \
service/web exposed \
service/web2 exposed

**Third, Create Ingress Rules**

>kubectl apply -f service/networking/web-ingress.yaml

>Output: \
ingress.networking.k8s.io/example-ingress created

**Finally, Test the Services**

To test our services, we'll get the Cluster IP address, and use it in our browser:

>minikube ip \
\
Output: \
192.168.49.2

Test with the IP address recovered in the above step in your browser, e.g. http://192.168.49.2/ or http://192.168.49.2/v2

**Appendix**

https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/