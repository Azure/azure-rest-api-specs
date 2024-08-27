## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: servicefabric
  package-name: azure-mgmt-servicefabric
  namespace: azure.mgmt.servicefabric
  test-scenario:
    - name: Put a cluster with minimum parameters
    - name: Put a cluster with maximum parameters
    - name: Put an application with maximum parameters
    - name: Put an application with minimum parameters
    - name: Put an application type
    - name: Put a service with minimum parameters
    - name: Put a service with maximum parameters
    - name: Put an application type version
    - name: Get an application type version
    - name: Get a service
    - name: Get a list of application type version resources
    - name: Get a list of service resources
    - name: Get cluster version by environment
    - name: Get an application type
    - name: Get an application
    - name: List cluster versions by environment
    - name: Get a list of application type name resources
    - name: Get a list of application resources
    - name: Get cluster version
    - name: Get a cluster
    - name: List cluster versions
    - name: List cluster by resource group
    - name: List clusters
    - name: Patch a service
    - name: Patch an application
    - name: Patch a cluster
    - name: Delete an application type version
    - name: Delete a service
    - name: Delete an application type
    - name: Delete an application
    - name: Delete a cluster
```