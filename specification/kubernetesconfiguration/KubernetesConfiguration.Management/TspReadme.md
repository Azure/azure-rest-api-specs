

``` yaml
library-name: KubernetesConfiguration
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/e812b54127fad6c9bc2407b33980b0fe385b7717/specification/kubernetesconfiguration/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false
deserialize-null-collection-as-null-value: true

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


prepend-rp-prefix:
  - ProvisioningState
  - ProvisioningStateType

rename-mapping:
  Extension: KubernetesClusterExtension
  Scope: KubernetesClusterExtensionScope
  ScopeType: KubernetesConfigurationScope
  SourceKindType: KubernetesConfigurationSourceKind
  ExtensionStatus: KubernetesClusterExtensionStatus
  LevelType: KubernetesClusterExtensionStatusLevel
  SourceControlConfiguration: KubernetesSourceControlConfiguration
  FluxConfiguration: KubernetesFluxConfiguration
  FluxConfiguration.properties.suspend: IsReconciliationSuspended
  FluxComplianceState: KubernetesFluxComplianceState
  SourceControlConfiguration.properties.enableHelmOperator: IsHelmOperatorEnabled
  AzureBlobDefinition: KubernetesAzureBlob
  GitRepositoryDefinition: KubernetesGitRepository
  BucketDefinition: KubernetesBucket
  ManagedIdentityDefinition.clientId: -|uuid
  BucketDefinition.insecure: UseInsecureCommunication
  BucketPatchDefinition: KubernetesBucketUpdateContent
  BucketPatchDefinition.insecure: UseInsecureCommunication
  GitRepositoryPatchDefinition: KubernetesGitRepositoryUpdateContent
  AzureBlobPatchDefinition: KubernetesAzureBlobUpdateContent
  KustomizationPatchDefinition: KustomizationUpdateContent
  ComplianceStatus: KubernetesConfigurationComplianceStatus
  ComplianceStatus.lastConfigApplied: LastConfigAppliedOn
  ComplianceStateType: KubernetesConfigurationComplianceStateType
  ServicePrincipalDefinition.clientId: -|uuid
  ServicePrincipalPatchDefinition.clientId: -|uuid
  ServicePrincipalDefinition: KubernetesServicePrincipal
  ServicePrincipalPatchDefinition: KubernetesServicePrincipalUpdateContent
  ManagedIdentityDefinition: KubernetesAzureBlobManagedIdentity
  ManagedIdentityPatchDefinition: KubernetesAzureBlobManagedIdentityUpdateContent
  MessageLevelType: KubernetesConfigurationMesageLevel
  ObjectReferenceDefinition: KubernetesObjectReference
  ObjectStatusConditionDefinition: KubernetesObjectStatusCondition
  ObjectStatusDefinition: KubernetesObjectStatus
  OperatorScopeType: KubernetesOperatorScope
  OperatorType: KubernetesOperator
  RepositoryRefDefinition: KubernetesGitRepositoryRef
  HelmReleasePropertiesDefinition: HelmReleaseProperties
  KustomizationDefinition: Kustomization

directive:
  - remove-operation: OperationStatus_Get
  - remove-operation: OperationStatus_List
  - remove-operation: FluxConfigOperationStatus_Get

```
