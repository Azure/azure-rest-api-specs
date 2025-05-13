## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
service-name: Machine Learning
title: Azure Machine Learning Workspaces
resource-collection-associations:
- resource: ComponentContainer
  collection: ComponentContainers
- resource: DataContainer
  collection: DataContainers
- resource: EnvironmentContainer
  collection: EnvironmentContainers
- resource: ModelContainer
  collection: ModelContainers
- resource: CodeContainer
  collection: CodeContainers
- resource: CodeVersion
  collection: CodeVersions
- resource: ComponentVersion
  collection: ComponentVersions
- resource: DataVersionBase
  collection: DataVersions
- resource: EnvironmentVersion
  collection: EnvironmentVersions
- resource: ModelVersion
  collection: ModelVersions
remove-inner: WorkspaceUpdateParameters
```
