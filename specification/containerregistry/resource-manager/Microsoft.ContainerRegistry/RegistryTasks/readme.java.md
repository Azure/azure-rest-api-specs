## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
title: ContainerRegistryTasksManagementClient
modelerfour:
  lenient-model-deduplication: true
enable-sync-stack: false
rename-model: DockerBuildStep:DockerTaskStep
rename-operation-group: Registries:RegistryTasks
```
