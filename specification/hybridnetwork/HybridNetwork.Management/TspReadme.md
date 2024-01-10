

``` yaml
library-name: HybridNetwork
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/eccca594dd50892ada8220fe7b1587c12cc5c871/specification/hybridnetwork/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

#mgmt-debug:
#  show-serialized-names: true

 

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


rename-mapping:
  HelmInstallOptions: HelmInstallConfig
  HelmUpgradeOptions: HelmUpgradeConfig
  HelmMappingRuleProfileOptions: HelmMappingRuleProfileConfig 
  Resources: ComponentKubernetesResources
  Status: ComponentStatus
  DaemonSet: KubernetesDaemonSet
  DaemonSet.desired: DesiredNumberOfPods
  DaemonSet.ready: ReadyNumberOfPods
  DaemonSet.current: CurrentNumberOfPods
  DaemonSet.upToDate: UpToDateNumberOfPods
  DaemonSet.available: AvailableNumberOfPods
  Deployment: KubernetesDeployment
  Deployment.desired: DesiredNumberOfPods
  Deployment.ready: ReadyNumberOfPods
  Deployment.current: CurrentNumberOfPods
  Deployment.upToDate: UpToDateNumberOfPods
  Deployment.available: AvailableNumberOfPods
  Pod: KubernetesPod
  Pod.desired: DesiredNumberOfContainers
  Pod.ready: ReadyNumberOfContainers
  ReplicaSet: KubernetesReplicaSet
  ReplicaSet.desired: DesiredNumberOfPods
  ReplicaSet.ready: ReadyNumberOfPods
  ReplicaSet.current: CurrentNumberOfPods
  StatefulSet: KubernetesStatefulSet
  StatefulSet.desired: DesiredNumberOfPods
  StatefulSet.ready: ReadyNumberOfPods

directive:
- from: publisher.json
  where: $.definitions.ArtifactStorePropertiesFormat.properties.storageResourceId
  transform: $["x-ms-format"] = "arm-id";
- from: common.json
  where: $.definitions.AzureStorageAccountCredential.properties.storageAccountId
  transform: $["x-ms-format"] = "arm-id";
- from: common.json
  where: $.definitions.SecretDeploymentResourceReference.properties.id
  transform: $["x-ms-format"] = "arm-id";
- from: common.json
  where: $.definitions.OpenDeploymentResourceReference.properties.id
  transform: $["x-ms-format"] = "arm-id";
- from: networkFunction.json
  where: $.definitions.NetworkFunctionPropertiesFormat.properties.nfviId
  transform: $["x-ms-format"] = "arm-id";

```
