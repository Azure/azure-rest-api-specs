import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The provisioning state of the resource.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Updating,
  Deleting,
}

@doc("Level of the status.")
enum LevelType {
  Error,
  Warning,
  Information,
}

@doc("Scope at which the configuration will be installed.")
enum ScopeType {
  cluster,
  `namespace`,
}

@doc("Source Kind to pull the configuration data from.")
enum SourceKindType {
  GitRepository,
  Bucket,
  AzureBlob,
}

@doc("Compliance state of the cluster object.")
enum FluxComplianceState {
  Compliant,
  `Non-Compliant`,
  Pending,
  Suspended,
  Unknown,
}

@doc("Type of the operator")
enum OperatorType {
  Flux,
}

@doc("Scope at which the operator will be installed.")
enum OperatorScopeType {
  cluster,
  `namespace`,
}

@doc("The provisioning state of the resource provider.")
enum ProvisioningStateType {
  Accepted,
  Deleting,
  Running,
  Succeeded,
  Failed,
}

@doc("The compliance state of the configuration.")
enum ComplianceStateType {
  Pending,
  Compliant,
  Noncompliant,
  Installed,
  Failed,
}

@doc("Level of the message.")
enum MessageLevelType {
  Error,
  Warning,
  Information,
}

@doc("Specify whether to validate the Kubernetes objects referenced in the Kustomization before applying them to the cluster.")
enum KustomizationValidationType {
  none,
  client,
  server,
}

@doc("The identity type.")
@fixed
enum AKSIdentityType {
  SystemAssigned,
  UserAssigned,
}

@doc("Properties of an Extension resource")
model ExtensionProperties {
  @doc("Type of the Extension, of which this resource is an instance of.  It must be one of the Extension Types registered with Microsoft.KubernetesConfiguration by the Extension publisher.")
  extensionType?: string;

  @doc("Flag to note if this extension participates in auto upgrade of minor version, or not.")
  autoUpgradeMinorVersion?: boolean;

  @doc("ReleaseTrain this extension participates in for auto-upgrade (e.g. Stable, Preview, etc.) - only if autoUpgradeMinorVersion is 'true'.")
  releaseTrain?: string;

  @doc("User-specified version of the extension for this extension to 'pin'. To use 'version', autoUpgradeMinorVersion must be 'false'.")
  version?: string;

  @doc("Scope at which the extension is installed.")
  scope?: Scope;

  @doc("Configuration settings, as name-value pairs for configuring this extension.")
  configurationSettings?: Record<string>;

  @doc("Configuration settings that are sensitive, as name-value pairs for configuring this extension.")
  configurationProtectedSettings?: Record<string>;

  @doc("Currently installed version of the extension.")
  @visibility("read")
  currentVersion?: string;

  @doc("Status of installation of this extension.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Status from this extension.")
  statuses?: ExtensionStatus[];

  @doc("Error information from the Agent - e.g. errors during installation.")
  @visibility("read")
  errorInfo?: ErrorDetail;

  @doc("Custom Location settings properties.")
  @visibility("read")
  customLocationSettings?: Record<string>;

  @doc("Uri of the Helm package")
  @visibility("read")
  packageUri?: string;

  @doc("Identity of the Extension resource in an AKS cluster")
  aksAssignedIdentity?: ExtensionPropertiesAksAssignedIdentity;

  @doc("Flag to note if this extension is a system extension")
  @visibility("read")
  isSystemExtension?: boolean;
}

@doc("Scope of the extension. It can be either Cluster or Namespace; but not both.")
model Scope {
  @doc("Specifies that the scope of the extension is Cluster")
  cluster?: ScopeCluster;

  @doc("Specifies that the scope of the extension is Namespace")
  `namespace`?: ScopeNamespace;
}

@doc("Specifies that the scope of the extension is Cluster")
model ScopeCluster {
  @doc("Namespace where the extension Release must be placed, for a Cluster scoped extension.  If this namespace does not exist, it will be created")
  releaseNamespace?: string;
}

@doc("Specifies that the scope of the extension is Namespace")
model ScopeNamespace {
  @doc("Namespace where the extension will be created for an Namespace scoped extension.  If this namespace does not exist, it will be created")
  targetNamespace?: string;
}

@doc("Status from the extension.")
model ExtensionStatus {
  @doc("Status code provided by the Extension")
  code?: string;

  @doc("Short description of status of the extension.")
  displayStatus?: string;

  @doc("Level of the status.")
  level?: LevelType;

  @doc("Detailed message of the status from the Extension.")
  message?: string;

  @doc("DateLiteral (per ISO8601) noting the time of installation status.")
  time?: string;
}

@doc("Identity of the Extension resource in an AKS cluster")
model ExtensionPropertiesAksAssignedIdentity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: AKSIdentityType;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: "SystemAssigned";
}

@doc("Plan for the resource.")
model Plan {
  @doc("A user defined name of the 3rd Party Artifact that is being procured.")
  name: string;

  @doc("The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic")
  publisher: string;

  @doc("The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding. ")
  product: string;

  @doc("A publisher provided promotion code as provisioned in Data Market for the said product/artifact.")
  promotionCode?: string;

  @doc("The version of the desired product/artifact.")
  version?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The Extension Patch Request object.")
model PatchExtension {
  @doc("Updatable properties of an Extension Patch Request")
  properties?: PatchExtensionProperties;
}

@doc("Updatable properties of an Extension Patch Request")
model PatchExtensionProperties {
  @doc("Flag to note if this extension participates in auto upgrade of minor version, or not.")
  autoUpgradeMinorVersion?: boolean;

  @doc("ReleaseTrain this extension participates in for auto-upgrade (e.g. Stable, Preview, etc.) - only if autoUpgradeMinorVersion is 'true'.")
  releaseTrain?: string;

  @doc("Version of the extension for this extension, if it is 'pinned' to a specific version. autoUpgradeMinorVersion must be 'false'.")
  version?: string;

  @doc("Configuration settings, as name-value pairs for configuring this extension.")
  configurationSettings?: Record<string>;

  @doc("Configuration settings that are sensitive, as name-value pairs for configuring this extension.")
  configurationProtectedSettings?: Record<string>;
}

@doc("Properties to create a Flux Configuration resource")
model FluxConfigurationProperties {
  @doc("Scope at which the operator will be installed.")
  @visibility("read", "create")
  scope?: ScopeType;

  @doc("The namespace to which this configuration is installed to. Maximum of 253 lower case alphanumeric characters, hyphen and period only.")
  @visibility("read", "create")
  `namespace`?: string;

  @doc("Source Kind to pull the configuration data from.")
  sourceKind?: SourceKindType;

  @doc("Whether this configuration should suspend its reconciliation of its kustomizations and sources.")
  suspend?: boolean;

  @doc("Parameters to reconcile to the GitRepository source kind type.")
  gitRepository?: GitRepositoryDefinition;

  @doc("Parameters to reconcile to the Bucket source kind type.")
  bucket?: BucketDefinition;

  @doc("Parameters to reconcile to the AzureBlob source kind type.")
  azureBlob?: AzureBlobDefinition;

  @doc("Array of kustomizations used to reconcile the artifact pulled by the source type on the cluster.")
  kustomizations?: Record<KustomizationDefinition>;

  @doc("Key-value pairs of protected configuration settings for the configuration")
  configurationProtectedSettings?: Record<string>;

  @doc("Statuses of the Flux Kubernetes resources created by the fluxConfiguration or created by the managed objects provisioned by the fluxConfiguration.")
  @visibility("read")
  statuses?: ObjectStatusDefinition[];

  @doc("Public Key associated with this fluxConfiguration (either generated within the cluster or provided by the user).")
  @visibility("read")
  repositoryPublicKey?: string;

  @doc("Branch and/or SHA of the source commit synced with the cluster.")
  @visibility("read")
  sourceSyncedCommitId?: string;

  @doc("Datetime the fluxConfiguration synced its source on the cluster.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sourceUpdatedAt?: utcDateTime;

  @doc("Datetime the fluxConfiguration synced its status on the cluster with Azure.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusUpdatedAt?: utcDateTime;

  @doc("Combined status of the Flux Kubernetes resources created by the fluxConfiguration or created by the managed objects.")
  @visibility("read")
  complianceState?: FluxComplianceState;

  @doc("Status of the creation of the fluxConfiguration.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Error message returned to the user in the case of provisioning failure.")
  @visibility("read")
  errorMessage?: string;
}

@doc("Parameters to reconcile to the GitRepository source kind type.")
model GitRepositoryDefinition {
  @doc("The URL to sync for the flux configuration git repository.")
  url?: string;

  @doc("The maximum time to attempt to reconcile the cluster git repository source with the remote.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the cluster git repository source with the remote.")
  syncIntervalInSeconds?: int32;

  @doc("The source reference for the GitRepository object.")
  repositoryRef?: RepositoryRefDefinition;

  @doc("Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH")
  sshKnownHosts?: string;

  @doc("Plaintext HTTPS username used to access private git repositories over HTTPS")
  httpsUser?: string;

  @doc("Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS")
  httpsCACert?: string;

  @doc("Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.")
  localAuthRef?: string;
}

@doc("The source reference for the GitRepository object.")
model RepositoryRefDefinition {
  @doc("The git repository branch name to checkout.")
  branch?: string;

  @doc("The git repository tag name to checkout. This takes precedence over branch.")
  tag?: string;

  @doc("The semver range used to match against git repository tags. This takes precedence over tag.")
  semver?: string;

  @doc("The commit SHA to checkout. This value must be combined with the branch name to be valid. This takes precedence over semver.")
  commit?: string;
}

@doc("Parameters to reconcile to the Bucket source kind type.")
model BucketDefinition {
  @doc("The URL to sync for the flux configuration S3 bucket.")
  url?: string;

  @doc("The bucket name to sync from the url endpoint for the flux configuration.")
  bucketName?: string;

  @doc("Specify whether to use insecure communication when puling data from the S3 bucket.")
  insecure?: boolean;

  @doc("The maximum time to attempt to reconcile the cluster bucket source with the remote.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the cluster bucket source with the remote.")
  syncIntervalInSeconds?: int32;

  @doc("Plaintext access key used to securely access the S3 bucket")
  accessKey?: string;

  @doc("Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.")
  localAuthRef?: string;
}

@doc("Parameters to reconcile to the AzureBlob source kind type.")
model AzureBlobDefinition {
  @doc("The URL to sync for the flux configuration Azure Blob storage account.")
  url?: string;

  @doc("The Azure Blob container name to sync from the url endpoint for the flux configuration.")
  containerName?: string;

  @doc("The maximum time to attempt to reconcile the cluster Azure Blob source with the remote.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the cluster Azure Blob source with the remote.")
  syncIntervalInSeconds?: int32;

  @doc("Parameters to authenticate using Service Principal.")
  servicePrincipal?: ServicePrincipalDefinition;

  @doc("The account key (shared key) to access the storage account")
  accountKey?: string;

  @doc("The Shared Access token to access the storage container")
  sasToken?: string;

  @doc("Parameters to authenticate using a Managed Identity.")
  managedIdentity?: ManagedIdentityDefinition;

  @doc("Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.")
  localAuthRef?: string;
}

@doc("Parameters to authenticate using Service Principal.")
model ServicePrincipalDefinition {
  @doc("The client Id for authenticating a Service Principal.")
  clientId?: string;

  @doc("The tenant Id for authenticating a Service Principal")
  tenantId?: string;

  @doc("The client secret for authenticating a Service Principal")
  clientSecret?: string;

  @doc("Base64-encoded certificate used to authenticate a Service Principal ")
  clientCertificate?: string;

  @doc("The password for the certificate used to authenticate a Service Principal ")
  clientCertificatePassword?: string;

  @doc("Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the Client Certificate")
  clientCertificateSendChain?: boolean;
}

@doc("Parameters to authenticate using a Managed Identity.")
model ManagedIdentityDefinition {
  @doc("The client Id for authenticating a Managed Identity.")
  clientId?: string;
}

@doc("The Kustomization defining how to reconcile the artifact pulled by the source type on the cluster.")
model KustomizationDefinition {
  @doc("Name of the Kustomization, matching the key in the Kustomizations object map.")
  @visibility("read")
  name?: string;

  @doc("The path in the source reference to reconcile on the cluster.")
  path?: string;

  @doc("Specifies other Kustomizations that this Kustomization depends on. This Kustomization will not reconcile until all dependencies have completed their reconciliation.")
  dependsOn?: string[];

  @doc("The maximum time to attempt to reconcile the Kustomization on the cluster.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the Kustomization on the cluster.")
  syncIntervalInSeconds?: int32;

  @doc("The interval at which to re-reconcile the Kustomization on the cluster in the event of failure on reconciliation.")
  retryIntervalInSeconds?: int32;

  @doc("Enable/disable garbage collections of Kubernetes objects created by this Kustomization.")
  prune?: boolean;

  @doc("Enable/disable re-creating Kubernetes resources on the cluster when patching fails due to an immutable field change.")
  force?: boolean;
}

@doc("Statuses of objects deployed by the user-specified kustomizations from the git repository.")
model ObjectStatusDefinition {
  @doc("Name of the applied object")
  name?: string;

  @doc("Namespace of the applied object")
  `namespace`?: string;

  @doc("Kind of the applied object")
  kind?: string;

  @doc("Compliance state of the applied object showing whether the applied object has come into a ready state on the cluster.")
  complianceState?: FluxComplianceState;

  @doc("Object reference to the Kustomization that applied this object")
  appliedBy?: ObjectReferenceDefinition;

  @doc("List of Kubernetes object status conditions present on the cluster")
  statusConditions?: ObjectStatusConditionDefinition[];

  @doc("Additional properties that are provided from objects of the HelmRelease kind")
  helmReleaseProperties?: HelmReleasePropertiesDefinition;
}

@doc("Object reference to a Kubernetes object on a cluster")
model ObjectReferenceDefinition {
  @doc("Name of the object")
  name?: string;

  @doc("Namespace of the object")
  `namespace`?: string;
}

@doc("Status condition of Kubernetes object")
model ObjectStatusConditionDefinition {
  @doc("Last time this status condition has changed")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTransitionTime?: utcDateTime;

  @doc("A more verbose description of the object status condition")
  message?: string;

  @doc("Reason for the specified status condition type status")
  reason?: string;

  @doc("Status of the Kubernetes object condition type")
  status?: string;

  @doc("Object status condition type for this object")
  type?: string;
}

@doc("Properties for HelmRelease objects")
model HelmReleasePropertiesDefinition {
  @doc("The revision number of the last released object change")
  lastRevisionApplied?: int32;

  @doc("The reference to the HelmChart object used as the source to this HelmRelease")
  helmChartRef?: ObjectReferenceDefinition;

  @doc("Total number of times that the HelmRelease failed to install or upgrade")
  failureCount?: int32;

  @doc("Number of times that the HelmRelease failed to install")
  installFailureCount?: int32;

  @doc("Number of times that the HelmRelease failed to upgrade")
  upgradeFailureCount?: int32;
}

@doc("The Flux Configuration Patch Request object.")
model FluxConfigurationPatch {
  @doc("Updatable properties of an Flux Configuration Patch Request")
  properties?: FluxConfigurationPatchProperties;
}

@doc("Updatable properties of an Flux Configuration Patch Request")
model FluxConfigurationPatchProperties {
  @doc("Source Kind to pull the configuration data from.")
  sourceKind?: SourceKindType;

  @doc("Whether this configuration should suspend its reconciliation of its kustomizations and sources.")
  suspend?: boolean;

  @doc("Parameters to reconcile to the GitRepository source kind type.")
  gitRepository?: GitRepositoryPatchDefinition;

  @doc("Parameters to reconcile to the Bucket source kind type.")
  bucket?: BucketPatchDefinition;

  @doc("Parameters to reconcile to the AzureBlob source kind type.")
  azureBlob?: AzureBlobPatchDefinition;

  @doc("Array of kustomizations used to reconcile the artifact pulled by the source type on the cluster.")
  kustomizations?: Record<KustomizationPatchDefinition>;

  @doc("Key-value pairs of protected configuration settings for the configuration")
  configurationProtectedSettings?: Record<string>;
}

@doc("Parameters to reconcile to the GitRepository source kind type.")
model GitRepositoryPatchDefinition {
  @doc("The URL to sync for the flux configuration git repository.")
  url?: string;

  @doc("The maximum time to attempt to reconcile the cluster git repository source with the remote.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the cluster git repository source with the remote.")
  syncIntervalInSeconds?: int32;

  @doc("The source reference for the GitRepository object.")
  repositoryRef?: RepositoryRefDefinition;

  @doc("Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH")
  sshKnownHosts?: string;

  @doc("Plaintext HTTPS username used to access private git repositories over HTTPS")
  httpsUser?: string;

  @doc("Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS")
  httpsCACert?: string;

  @doc("Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.")
  localAuthRef?: string;
}

@doc("Parameters to reconcile to the Bucket source kind type.")
model BucketPatchDefinition {
  @doc("The URL to sync for the flux configuration S3 bucket.")
  url?: string;

  @doc("The bucket name to sync from the url endpoint for the flux configuration.")
  bucketName?: string;

  @doc("Specify whether to use insecure communication when puling data from the S3 bucket.")
  insecure?: boolean;

  @doc("The maximum time to attempt to reconcile the cluster bucket source with the remote.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the cluster bucket source with the remote.")
  syncIntervalInSeconds?: int32;

  @doc("Plaintext access key used to securely access the S3 bucket")
  accessKey?: string;

  @doc("Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.")
  localAuthRef?: string;
}

@doc("Parameters to reconcile to the AzureBlob source kind type.")
model AzureBlobPatchDefinition {
  @doc("The URL to sync for the flux configuration Azure Blob storage account.")
  url?: string;

  @doc("The Azure Blob container name to sync from the url endpoint for the flux configuration.")
  containerName?: string;

  @doc("The maximum time to attempt to reconcile the cluster Azure Blob source with the remote.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the cluster Azure Blob source with the remote.")
  syncIntervalInSeconds?: int32;

  @doc("Parameters to authenticate using Service Principal.")
  servicePrincipal?: ServicePrincipalPatchDefinition;

  @doc("The account key (shared key) to access the storage account")
  accountKey?: string;

  @doc("The Shared Access token to access the storage container")
  sasToken?: string;

  @doc("Parameters to authenticate using a Managed Identity.")
  managedIdentity?: ManagedIdentityPatchDefinition;

  @doc("Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.")
  localAuthRef?: string;
}

@doc("Parameters to authenticate using Service Principal.")
model ServicePrincipalPatchDefinition {
  @doc("The client Id for authenticating a Service Principal.")
  clientId?: string;

  @doc("The tenant Id for authenticating a Service Principal")
  tenantId?: string;

  @doc("The client secret for authenticating a Service Principal")
  clientSecret?: string;

  @doc("Base64-encoded certificate used to authenticate a Service Principal ")
  clientCertificate?: string;

  @doc("The password for the certificate used to authenticate a Service Principal ")
  clientCertificatePassword?: string;

  @doc("Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the Client Certificate")
  clientCertificateSendChain?: boolean;
}

@doc("Parameters to authenticate using a Managed Identity.")
model ManagedIdentityPatchDefinition {
  @doc("The client Id for authenticating a Managed Identity.")
  clientId?: string;
}

@doc("The Kustomization defining how to reconcile the artifact pulled by the source type on the cluster.")
model KustomizationPatchDefinition {
  @doc("The path in the source reference to reconcile on the cluster.")
  path?: string;

  @doc("Specifies other Kustomizations that this Kustomization depends on. This Kustomization will not reconcile until all dependencies have completed their reconciliation.")
  dependsOn?: string[];

  @doc("The maximum time to attempt to reconcile the Kustomization on the cluster.")
  timeoutInSeconds?: int32;

  @doc("The interval at which to re-reconcile the Kustomization on the cluster.")
  syncIntervalInSeconds?: int32;

  @doc("The interval at which to re-reconcile the Kustomization on the cluster in the event of failure on reconciliation.")
  retryIntervalInSeconds?: int32;

  @doc("Enable/disable garbage collections of Kubernetes objects created by this Kustomization.")
  prune?: boolean;

  @doc("Enable/disable re-creating Kubernetes resources on the cluster when patching fails due to an immutable field change.")
  force?: boolean;
}

@doc("Properties to create a Source Control Configuration resource")
model SourceControlConfigurationProperties {
  @doc("Url of the SourceControl Repository.")
  repositoryUrl?: string;

  @doc("The namespace to which this operator is installed to. Maximum of 253 lower case alphanumeric characters, hyphen and period only.")
  operatorNamespace?: string;

  @doc("Instance name of the operator - identifying the specific configuration.")
  operatorInstanceName?: string;

  @doc("Type of the operator")
  operatorType?: OperatorType;

  @doc("Any Parameters for the Operator instance in string format.")
  operatorParams?: string;

  @doc("Name-value pairs of protected configuration settings for the configuration")
  configurationProtectedSettings?: Record<string>;

  @doc("Scope at which the operator will be installed.")
  operatorScope?: OperatorScopeType;

  @doc("Public Key associated with this SourceControl configuration (either generated within the cluster or provided by the user).")
  @visibility("read")
  repositoryPublicKey?: string;

  @doc("Base64-encoded known_hosts contents containing public SSH keys required to access private Git instances")
  sshKnownHostsContents?: string;

  @doc("Option to enable Helm Operator for this git configuration.")
  enableHelmOperator?: boolean;

  @doc("Properties for Helm operator.")
  helmOperatorProperties?: HelmOperatorProperties;

  @doc("The provisioning state of the resource provider.")
  @visibility("read")
  provisioningState?: ProvisioningStateType;

  @doc("Compliance Status of the Configuration")
  @visibility("read")
  complianceStatus?: ComplianceStatus;
}

@doc("Properties for Helm operator.")
model HelmOperatorProperties {
  @doc("Version of the operator Helm chart.")
  chartVersion?: string;

  @doc("Values override for the operator Helm chart.")
  chartValues?: string;
}

@doc("Compliance Status details")
model ComplianceStatus {
  @doc("The compliance state of the configuration.")
  @visibility("read")
  complianceState?: ComplianceStateType;

  @doc("Datetime the configuration was last applied.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConfigApplied?: utcDateTime;

  @doc("Message from when the configuration was applied.")
  message?: string;

  @doc("Level of the message.")
  messageLevel?: MessageLevelType;
}

@doc("Supported operation of this resource provider.")
model ResourceProviderOperation {
  @doc("Operation name, in format of {provider}/{resource}/{operation}")
  name?: string;

  @doc("Display metadata associated with the operation.")
  display?: ResourceProviderOperationDisplay;

  @doc("The flag that indicates whether the operation applies to data plane.")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Origin of the operation")
  @visibility("read")
  origin?: string;
}

@doc("Display metadata associated with the operation.")
model ResourceProviderOperationDisplay {
  @doc("Resource provider: Microsoft KubernetesConfiguration.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;

  @doc("Type of operation: get, read, delete, etc.")
  operation?: string;

  @doc("Description of this operation.")
  description?: string;
}
