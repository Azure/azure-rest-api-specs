## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
title: DeploymentsManagementClient
service-name: Deployments
client-flattened-annotation-target: disabled
uuid-as-string: true
add-inner: Deployment,Provider
graalvm-config-suffix: deployments
enable-sync-stack: false
```
