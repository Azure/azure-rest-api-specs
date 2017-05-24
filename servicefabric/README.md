# Service Fabric REST Client API Specifications

## Description

[Service Fabric](http://aka.ms/ServiceFabric) is a distributed systems platform that makes it easy to package, deploy, and manage scalable and reliable microservices. Service Fabric also addresses the significant challenges in developing and managing cloud applications. Developers and administrators can avoid complex infrastructure problems and focus on implementing mission-critical, demanding workloads that are scalable, reliable, and manageable. Service Fabric represents the next-generation middleware platform for building and managing these enterprise-class, tier-1, cloud-scale applications.

This specification in this folder documents the [Service Fabric Client APIs](https://docs.microsoft.com/en-us/rest/api/servicefabric) that allows managing applications, services, containers and other entities deployed in the cluster. These APIs are provided by Service Fabric itself and are always available anywhere Service Fabric runs, whether that's in Azure, on-premises, or another cloud. This APIs is the primary way of interacting with your Service Fabric cluster to deploy, upgrade, delete, and query your applications and services. 

The [`arm-servicefabric`](../arm-servicefabric) folder documents the [Service Fabric Resource Manager APIs](https://docs.microsoft.com/en-us/rest/api/servicefabric) that allows you to create and manage Service Fabric cluster in Azure. A Service Fabric cluster is a network-connected set of virtual or physical machines into which your microservices are deployed and managed.  Once a cluster is created you can manage and deploy applications, services and containers in the cluster using Service Fabric Client APIs. 

## Version
Each swagger spec is tied to one version of Service Fabric runtime. The version of the swagger specification matches the version of the Service Fabric runtime. Each Service Fabric REST API is independently versioned through `api-version` parameter. 