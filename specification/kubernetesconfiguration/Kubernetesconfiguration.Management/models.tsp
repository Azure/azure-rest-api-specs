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

/**
 * The provisioning state of the resource.
 */
union ProvisioningState {
  string,

  @doc("Succeeded")
  Succeeded: "Succeeded",

  @doc("Failed")
  Failed: "Failed",

  @doc("Canceled")
  Canceled: "Canceled",

  @doc("Creating")
  Creating: "Creating",

  @doc("Updating")
  Updating: "Updating",

  @doc("Deleting")
  Deleting: "Deleting",
}

/**
 * Level of the status.
 */
union LevelType {
  string,

  @doc("Error")
  Error: "Error",

  @doc("Warning")
  Warning: "Warning",

  @doc("Information")
  Information: "Information",
}

/**
 * Scope at which the configuration will be installed.
 */
union ScopeType {
  string,

  @doc("cluster")
  cluster: "cluster",

  @doc("namespace")
  nameSpace: "namespace",
}

/**
 * Source Kind to pull the configuration data from.
 */
union SourceKindType {
  string,

  @doc("GitRepository")
  GitRepository: "GitRepository",

  @doc("Bucket")
  Bucket: "Bucket",

  @doc("AzureBlob")
  AzureBlob: "AzureBlob",
}

/**
 * Compliance state of the cluster object.
 */
union FluxComplianceState {
  string,

  @doc("Compliant")
  Compliant: "Compliant",

  @doc("Non-Compliant")
  NonCompliant: "Non-Compliant",

  @doc("Pending")
  Pending: "Pending",

  @doc("Suspended")
  Suspended: "Suspended",

  @doc("Unknown")
  Unknown: "Unknown",
}

/**
 * Type of the operator
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
union OperatorType {
  string,
  Flux: "Flux",
}

/**
 * Scope at which the operator will be installed.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
union OperatorScopeType {
  string,
  cluster: "cluster",
  nameSpace: "namespace",
}

/**
 * The provisioning state of the resource provider.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
union ProvisioningStateType {
  string,
  Accepted: "Accepted",
  Deleting: "Deleting",
  Running: "Running",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

/**
 * The compliance state of the configuration.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
union ComplianceStateType {
  string,
  Pending: "Pending",
  Compliant: "Compliant",
  Noncompliant: "Noncompliant",
  Installed: "Installed",
  Failed: "Failed",
}

/**
 * Level of the message.
 */
union MessageLevelType {
  string,

  @doc("Message level : Error")
  Error: "Error",

  @doc("Message level : Warning")
  Warning: "Warning",

  @doc("Message level : Information")
  Information: "Information",
}

/**
 * Specify whether to validate the Kubernetes objects referenced in the Kustomization before applying them to the cluster.
 */
union KustomizationValidationType {
  string,

  @doc("No validation")
  none: "none",

  @doc("client side validation")
  client: "client",

  @doc("server side validation")
  server: "server",
}

/**
 * The identity type.
 */
@doc("IdentityType Enum")
union AKSIdentityType {
  string,

  @doc("System Assigned Identity")
  SystemAssigned: "SystemAssigned",

  @doc("User Assigned Identity")
  UserAssigned: "UserAssigned",
}

@secret
scalar protectedSettingValue extends string;

//@resourceBaseParametersOf(Resource)
model CustomBaseParameters<Resource extends Azure.ResourceManager.Foundations.ArmResourceBase> {
  ...ApiVersionParameter;

  // unless tenant or extension
  ...SubscriptionIdParameter;

  // unless tenant, subscription, location, or extension
  ...ResourceGroupParameter;

  @path
  @doc("providerName")
  providerName: "provider";

  @path
  @doc("clusterRp")
  clusterRp: string;

  @path
  @doc("clusterResourceName")
  clusterResourceName: string;

  @path
  @doc("clusterName")
  clusterName: string;
}

@doc("Operations path parameter")
model OperationsParameter {
  @segment("operations")
  @path
  @doc("operationId value")
  operationId: string;

  /**
   * Status of installation of this extension.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Properties of an Extension resource
 */
model ExtensionProperties {
  /**
   * Type of the Extension, of which this resource is an instance of.  It must be one of the Extension Types registered with Microsoft.KubernetesConfiguration by the Extension publisher.
   */
  extensionType?: string;

  /**
   * Flag to note if this extension participates in auto upgrade of minor version, or not.
   */
  autoUpgradeMinorVersion?: boolean = true;

  /**
   * ReleaseTrain this extension participates in for auto-upgrade (e.g. Stable, Preview, etc.) - only if autoUpgradeMinorVersion is 'true'.
   */
  releaseTrain?: string = "Stable";

  /**
   * User-specified version of the extension for this extension to 'pin'. To use 'version', autoUpgradeMinorVersion must be 'false'.
   */
  version?: string;

  /**
   * Scope at which the extension is installed.
   */
  scope?: Scope;

  /**
   * Configuration settings, as name-value pairs for configuring this extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  configurationSettings?: Record<string>;

  /**
   * Configuration settings that are sensitive, as name-value pairs for configuring this extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  configurationProtectedSettings?: Record<string>;

  /**
   * Currently installed version of the extension.
   */
  @visibility("read")
  currentVersion?: string;

  /**
   * Status of installation of this extension.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Status from this extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  statuses?: ExtensionStatus[];

  /**
   * Error information from the Agent - e.g. errors during installation.
   */
  @visibility("read")
  errorInfo?: ErrorDetail;

  /**
   * Custom Location settings properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @visibility("read")
  customLocationSettings?: Record<string>;

  /**
   * Uri of the Helm package
   */
  @visibility("read")
  packageUri?: string;

  /**
   * Identity of the Extension resource in an AKS cluster
   */
  aksAssignedIdentity?: ExtensionPropertiesAksAssignedIdentity;

  /**
   * Flag to note if this extension is a system extension
   */
  @visibility("read")
  isSystemExtension?: boolean;

  /**
   * autoUpgrade value for autoUpgradeV2
   */
  autoUpgradeChannel?: string;
}

/**
 * Scope of the extension. It can be either Cluster or Namespace; but not both.
 */
model Scope {
  /**
   * Specifies that the scope of the extension is Cluster
   */
  cluster?: ScopeCluster;

  /**
   * Specifies that the scope of the extension is Namespace
   */
  `namespace`?: ScopeNamespace;
}

/**
 * Specifies that the scope of the extension is Cluster
 */
model ScopeCluster {
  /**
   * Namespace where the extension Release must be placed, for a Cluster scoped extension.  If this namespace does not exist, it will be created
   */
  releaseNamespace?: string;
}

/**
 * Specifies that the scope of the extension is Namespace
 */
model ScopeNamespace {
  /**
   * Namespace where the extension will be created for an Namespace scoped extension.  If this namespace does not exist, it will be created
   */
  targetNamespace?: string;
}

/**
 * Status from the extension.
 */
model ExtensionStatus {
  /**
   * Status code provided by the Extension
   */
  code?: string;

  /**
   * Short description of status of the extension.
   */
  displayStatus?: string;

  /**
   * Level of the status.
   */
  level?: LevelType = LevelType.Information;

  /**
   * Detailed message of the status from the Extension.
   */
  message?: string;

  /**
   * DateLiteral (per ISO8601) noting the time of installation status.
   */
  time?: string;
}

/**
 * Identity of the Extension resource in an AKS cluster
 */
model ExtensionPropertiesAksAssignedIdentity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: AKSIdentityType;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * Plan for the resource.
 */
model Plan {
  /**
   * A user defined name of the 3rd Party Artifact that is being procured.
   */
  name: string;

  /**
   * The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic
   */
  publisher: string;

  /**
   * The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding.
   */
  product: string;

  /**
   * A publisher provided promotion code as provisioned in Data Market for the said product/artifact.
   */
  promotionCode?: string;

  /**
   * The version of the desired product/artifact.
   */
  version?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The Extension Patch Request object.
 */
model PatchExtension {
  /**
   * Updatable properties of an Extension Patch Request
   */
  properties?: PatchExtensionProperties;
}

/**
 * Updatable properties of an Extension Patch Request
 */
model PatchExtensionProperties {
  /**
   * Flag to note if this extension participates in auto upgrade of minor version, or not.
   */
  autoUpgradeMinorVersion?: boolean = true;

  /**
   * ReleaseTrain this extension participates in for auto-upgrade (e.g. Stable, Preview, etc.) - only if autoUpgradeMinorVersion is 'true'.
   */
  releaseTrain?: string = "Stable";

  /**
   * Version of the extension for this extension, if it is 'pinned' to a specific version. autoUpgradeMinorVersion must be 'false'.
   */
  version?: string;

  /**
   * Configuration settings, as name-value pairs for configuring this extension.
   */
  configurationSettings?: Record<string>;

  /**
   * Configuration settings that are sensitive, as name-value pairs for configuring this extension.
   */
  configurationProtectedSettings?: Record<string>;
}

/**
 * Properties to create a Flux Configuration resource
 */
model FluxConfigurationProperties {
  /**
   * Scope at which the operator will be installed.
   */
  @visibility("read", "create")
  scope?: ScopeType = ScopeType.cluster;

  /**
   * The namespace to which this configuration is installed to. Maximum of 253 lower case alphanumeric characters, hyphen and period only.
   */
  @visibility("read", "create")
  `namespace`?: string = "default";

  /**
   * Source Kind to pull the configuration data from.
   */
  sourceKind?: SourceKindType;

  /**
   * Whether this configuration should suspend its reconciliation of its kustomizations and sources.
   */
  suspend?: boolean = false;

  /**
   * Parameters to reconcile to the GitRepository source kind type.
   */
  gitRepository?: GitRepositoryDefinition;

  /**
   * Parameters to reconcile to the Bucket source kind type.
   */
  bucket?: BucketDefinition;

  /**
   * Parameters to reconcile to the AzureBlob source kind type.
   */
  azureBlob?: AzureBlobDefinition;

  /**
   * Array of kustomizations used to reconcile the artifact pulled by the source type on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  kustomizations?: Record<KustomizationDefinition>;

  /**
   * Key-value pairs of protected configuration settings for the configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  configurationProtectedSettings?: Record<protectedSettingValue>;

  /**
   * Statuses of the Flux Kubernetes resources created by the fluxConfiguration or created by the managed objects provisioned by the fluxConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @visibility("read")
  statuses?: ObjectStatusDefinition[];

  /**
   * Public Key associated with this fluxConfiguration (either generated within the cluster or provided by the user).
   */
  @visibility("read")
  repositoryPublicKey?: string;

  /**
   * Branch and/or SHA of the source commit synced with the cluster.
   */
  @visibility("read")
  sourceSyncedCommitId?: string;

  /**
   * Datetime the fluxConfiguration synced its source on the cluster.
   */
  @visibility("read")
  sourceUpdatedAt?: utcDateTime;

  /**
   * Datetime the fluxConfiguration synced its status on the cluster with Azure.
   */
  @visibility("read")
  statusUpdatedAt?: utcDateTime;

  /**
   * Whether flux configuration deployment should wait for cluster to reconcile the kustomizations.
   */
  waitForReconciliation?: boolean;

  /**
   * Maximum duration to wait for flux configuration reconciliation. E.g PT1H, PT5M, P1D
   */
  reconciliationWait?: string;

  /**
   * Combined status of the Flux Kubernetes resources created by the fluxConfiguration or created by the managed objects.
   */
  @visibility("read")
  complianceState?: FluxComplianceState = FluxComplianceState.Unknown;

  /**
   * Status of the creation of the fluxConfiguration.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Error message returned to the user in the case of provisioning failure.
   */
  @visibility("read")
  errorMessage?: string;
}

/**
 * Parameters to reconcile to the GitRepository source kind type.
 */
model GitRepositoryDefinition {
  /**
   * The URL to sync for the flux configuration git repository.
   */
  url?: string;

  /**
   * The maximum time to attempt to reconcile the cluster git repository source with the remote.
   */
  timeoutInSeconds?: int64 = 600;

  /**
   * The interval at which to re-reconcile the cluster git repository source with the remote.
   */
  syncIntervalInSeconds?: int64 = 600;

  /**
   * The source reference for the GitRepository object.
   */
  repositoryRef?: RepositoryRefDefinition;

  /**
   * Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH
   */
  sshKnownHosts?: string;

  /**
   * Plaintext HTTPS username used to access private git repositories over HTTPS
   */
  httpsUser?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "It is a breaking change for our existing SDKs"
  /**
   * Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS
   */
  httpsCACert?: string;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  localAuthRef?: string;
}

/**
 * The source reference for the GitRepository object.
 */
model RepositoryRefDefinition {
  /**
   * The git repository branch name to checkout.
   */
  branch?: string;

  /**
   * The git repository tag name to checkout. This takes precedence over branch.
   */
  tag?: string;

  /**
   * The semver range used to match against git repository tags. This takes precedence over tag.
   */
  semver?: string;

  /**
   * The commit SHA to checkout. This value must be combined with the branch name to be valid. This takes precedence over semver.
   */
  commit?: string;
}

/**
 * Parameters to reconcile to the Bucket source kind type.
 */
model BucketDefinition {
  /**
   * The URL to sync for the flux configuration S3 bucket.
   */
  url?: string;

  /**
   * The bucket name to sync from the url endpoint for the flux configuration.
   */
  bucketName?: string;

  /**
   * Specify whether to use insecure communication when puling data from the S3 bucket.
   */
  insecure?: boolean = true;

  /**
   * The maximum time to attempt to reconcile the cluster bucket source with the remote.
   */
  timeoutInSeconds?: int64 = 600;

  /**
   * The interval at which to re-reconcile the cluster bucket source with the remote.
   */
  syncIntervalInSeconds?: int64 = 600;

  /**
   * Plaintext access key used to securely access the S3 bucket
   */
  accessKey?: string;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  localAuthRef?: string;
}

/**
 * Parameters to reconcile to the AzureBlob source kind type.
 */
model AzureBlobDefinition {
  /**
   * The URL to sync for the flux configuration Azure Blob storage account.
   */
  url?: string;

  /**
   * The Azure Blob container name to sync from the url endpoint for the flux configuration.
   */
  containerName?: string;

  /**
   * The maximum time to attempt to reconcile the cluster Azure Blob source with the remote.
   */
  timeoutInSeconds?: int64 = 600;

  /**
   * The interval at which to re-reconcile the cluster Azure Blob source with the remote.
   */
  syncIntervalInSeconds?: int64 = 600;

  /**
   * Parameters to authenticate using Service Principal.
   */
  servicePrincipal?: ServicePrincipalDefinition;

  /**
   * The account key (shared key) to access the storage account
   */
  accountKey?: string;

  /**
   * The Shared Access token to access the storage container
   */
  sasToken?: string;

  /**
   * Parameters to authenticate using a Managed Identity.
   */
  managedIdentity?: ManagedIdentityDefinition;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  localAuthRef?: string;
}

/**
 * Parameters to authenticate using Service Principal.
 */
model ServicePrincipalDefinition {
  /**
   * The client Id for authenticating a Service Principal.
   */
  clientId?: string;

  /**
   * The tenant Id for authenticating a Service Principal
   */
  tenantId?: string;

  /**
   * The client secret for authenticating a Service Principal
   */
  @secret
  clientSecret?: string;

  /**
   * Base64-encoded certificate used to authenticate a Service Principal
   */
  @secret
  clientCertificate?: string;

  /**
   * The password for the certificate used to authenticate a Service Principal
   */
  @secret
  clientCertificatePassword?: string;

  /**
   * Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the Client Certificate
   */
  clientCertificateSendChain?: boolean = false;
}

/**
 * Parameters to authenticate using a Managed Identity.
 */
model ManagedIdentityDefinition {
  /**
   * The client Id for authenticating a Managed Identity.
   */
  clientId?: string;
}

/**
 * The Kustomization defining how to reconcile the artifact pulled by the source type on the cluster.
 */
model KustomizationDefinition {
  /**
   * Name of the Kustomization, matching the key in the Kustomizations object map.
   */
  @visibility("read")
  name?: string;

  /**
   * The path in the source reference to reconcile on the cluster.
   */
  path?: string = "";

  /**
   * Specifies other Kustomizations that this Kustomization depends on. This Kustomization will not reconcile until all dependencies have completed their reconciliation.
   */
  dependsOn?: string[];

  /**
   * The maximum time to attempt to reconcile the Kustomization on the cluster.
   */
  timeoutInSeconds?: int64 = 600;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster.
   */
  syncIntervalInSeconds?: int64 = 600;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster in the event of failure on reconciliation.
   */
  retryIntervalInSeconds?: int64;

  /**
   * Enable/disable garbage collections of Kubernetes objects created by this Kustomization.
   */
  prune?: boolean = false;

  /**
   * Enable/disable re-creating Kubernetes resources on the cluster when patching fails due to an immutable field change.
   */
  force?: boolean = false;

  /**
   * Enable/disable health check for all Kubernetes objects created by this Kustomization.
   */
  wait?: boolean = true;

  /**
   * Used for variable substitution for this Kustomization after kustomize build.
   */
  postBuild?: PostBuildDefinition;
}

/**
 * The postBuild definitions defining variable substitutions for this Kustomization after kustomize build.
 */
model PostBuildDefinition {
  /**
   * Key/value pairs holding the variables to be substituted in this Kustomization.
   */
  substitute?: Record<string>;

  /**
   * Array of ConfigMaps/Secrets from which the variables are substituted for this Kustomization.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  substituteFrom?: SubstituteFromDefinition[];
}

/**
 * Array of ConfigMaps/Secrets from which the variables are substituted for this Kustomization.
 */
model SubstituteFromDefinition {
  /**
   * Define whether it is ConfigMap or Secret that holds the variables to be used in substitution.
   */
  kind?: string;

  /**
   * Name of the ConfigMap/Secret that holds the variables to be used in substitution.
   */
  name?: string;

  /**
   * Set to True to proceed without ConfigMap/Secret, if it is not present.
   */
  optional?: boolean = false;
}

/**
 * Statuses of objects deployed by the user-specified kustomizations from the git repository.
 */
model ObjectStatusDefinition {
  /**
   * Name of the applied object
   */
  name?: string;

  /**
   * Namespace of the applied object
   */
  `namespace`?: string;

  /**
   * Kind of the applied object
   */
  kind?: string;

  /**
   * Compliance state of the applied object showing whether the applied object has come into a ready state on the cluster.
   */
  complianceState?: FluxComplianceState = FluxComplianceState.Unknown;

  /**
   * Object reference to the Kustomization that applied this object
   */
  appliedBy?: ObjectReferenceDefinition;

  /**
   * List of Kubernetes object status conditions present on the cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  statusConditions?: ObjectStatusConditionDefinition[];

  /**
   * Additional properties that are provided from objects of the HelmRelease kind
   */
  helmReleaseProperties?: HelmReleasePropertiesDefinition;
}

/**
 * Object reference to a Kubernetes object on a cluster
 */
model ObjectReferenceDefinition {
  /**
   * Name of the object
   */
  name?: string;

  /**
   * Namespace of the object
   */
  `namespace`?: string;
}

/**
 * Status condition of Kubernetes object
 */
model ObjectStatusConditionDefinition {
  /**
   * Last time this status condition has changed
   */
  lastTransitionTime?: utcDateTime;

  /**
   * A more verbose description of the object status condition
   */
  message?: string;

  /**
   * Reason for the specified status condition type status
   */
  reason?: string;

  /**
   * Status of the Kubernetes object condition type
   */
  status?: string;

  /**
   * Object status condition type for this object
   */
  type?: string;
}

/**
 * Properties for HelmRelease objects
 */
model HelmReleasePropertiesDefinition {
  /**
   * The revision number of the last released object change
   */
  lastRevisionApplied?: int64;

  /**
   * The reference to the HelmChart object used as the source to this HelmRelease
   */
  helmChartRef?: ObjectReferenceDefinition;

  /**
   * Total number of times that the HelmRelease failed to install or upgrade
   */
  failureCount?: int64;

  /**
   * Number of times that the HelmRelease failed to install
   */
  installFailureCount?: int64;

  /**
   * Number of times that the HelmRelease failed to upgrade
   */
  upgradeFailureCount?: int64;
}

/**
 * The Flux Configuration Patch Request object.
 */
model FluxConfigurationPatch {
  /**
   * Updatable properties of an Flux Configuration Patch Request
   */
  properties?: FluxConfigurationPatchProperties;
}

/**
 * Updatable properties of an Flux Configuration Patch Request
 */
model FluxConfigurationPatchProperties {
  /**
   * Source Kind to pull the configuration data from.
   */
  sourceKind?: SourceKindType;

  /**
   * Whether this configuration should suspend its reconciliation of its kustomizations and sources.
   */
  suspend?: boolean;

  /**
   * Parameters to reconcile to the GitRepository source kind type.
   */
  gitRepository?: GitRepositoryPatchDefinition;

  /**
   * Parameters to reconcile to the Bucket source kind type.
   */
  bucket?: BucketPatchDefinition;

  /**
   * Parameters to reconcile to the AzureBlob source kind type.
   */
  azureBlob?: AzureBlobPatchDefinition;

  /**
   * Array of kustomizations used to reconcile the artifact pulled by the source type on the cluster.
   */
  kustomizations?: Record<KustomizationPatchDefinition>;

  /**
   * Key-value pairs of protected configuration settings for the configuration
   */
  configurationProtectedSettings?: Record<string>;
}

/**
 * Parameters to reconcile to the GitRepository source kind type.
 */
model GitRepositoryPatchDefinition {
  /**
   * The URL to sync for the flux configuration git repository.
   */
  url?: string;

  /**
   * The maximum time to attempt to reconcile the cluster git repository source with the remote.
   */
  timeoutInSeconds?: int64;

  /**
   * The interval at which to re-reconcile the cluster git repository source with the remote.
   */
  syncIntervalInSeconds?: int64;

  /**
   * The source reference for the GitRepository object.
   */
  repositoryRef?: RepositoryRefDefinition;

  /**
   * Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH
   */
  sshKnownHosts?: string;

  /**
   * Plaintext HTTPS username used to access private git repositories over HTTPS
   */
  httpsUser?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "It is a breaking change for our existing SDKs"
  /**
   * Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS
   */
  httpsCACert?: string;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  localAuthRef?: string;
}

/**
 * Parameters to reconcile to the Bucket source kind type.
 */
model BucketPatchDefinition {
  /**
   * The URL to sync for the flux configuration S3 bucket.
   */
  url?: string;

  /**
   * The bucket name to sync from the url endpoint for the flux configuration.
   */
  bucketName?: string;

  /**
   * Specify whether to use insecure communication when puling data from the S3 bucket.
   */
  insecure?: boolean;

  /**
   * The maximum time to attempt to reconcile the cluster bucket source with the remote.
   */
  timeoutInSeconds?: int64;

  /**
   * The interval at which to re-reconcile the cluster bucket source with the remote.
   */
  syncIntervalInSeconds?: int64;

  /**
   * Plaintext access key used to securely access the S3 bucket
   */
  accessKey?: string;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  localAuthRef?: string;
}

/**
 * Parameters to reconcile to the AzureBlob source kind type.
 */
model AzureBlobPatchDefinition {
  /**
   * The URL to sync for the flux configuration Azure Blob storage account.
   */
  url?: string;

  /**
   * The Azure Blob container name to sync from the url endpoint for the flux configuration.
   */
  containerName?: string;

  /**
   * The maximum time to attempt to reconcile the cluster Azure Blob source with the remote.
   */
  timeoutInSeconds?: int64;

  /**
   * The interval at which to re-reconcile the cluster Azure Blob source with the remote.
   */
  syncIntervalInSeconds?: int64;

  /**
   * Parameters to authenticate using Service Principal.
   */
  servicePrincipal?: ServicePrincipalPatchDefinition;

  /**
   * The account key (shared key) to access the storage account
   */
  accountKey?: string;

  /**
   * The Shared Access token to access the storage container
   */
  sasToken?: string;

  /**
   * Parameters to authenticate using a Managed Identity.
   */
  managedIdentity?: ManagedIdentityPatchDefinition;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  localAuthRef?: string;
}

/**
 * Parameters to authenticate using Service Principal.
 */
model ServicePrincipalPatchDefinition {
  /**
   * The client Id for authenticating a Service Principal.
   */
  clientId?: string;

  /**
   * The tenant Id for authenticating a Service Principal
   */
  tenantId?: string;

  /**
   * The client secret for authenticating a Service Principal
   */
  @secret
  clientSecret?: string;

  /**
   * Base64-encoded certificate used to authenticate a Service Principal
   */
  @secret
  clientCertificate?: string;

  /**
   * The password for the certificate used to authenticate a Service Principal
   */
  @secret
  clientCertificatePassword?: string;

  /**
   * Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the Client Certificate
   */
  clientCertificateSendChain?: boolean;
}

/**
 * Parameters to authenticate using a Managed Identity.
 */
model ManagedIdentityPatchDefinition {
  /**
   * The client Id for authenticating a Managed Identity.
   */
  clientId?: string;
}

/**
 * The Kustomization defining how to reconcile the artifact pulled by the source type on the cluster.
 */
model KustomizationPatchDefinition {
  /**
   * The path in the source reference to reconcile on the cluster.
   */
  path?: string;

  /**
   * Specifies other Kustomizations that this Kustomization depends on. This Kustomization will not reconcile until all dependencies have completed their reconciliation.
   */
  dependsOn?: string[];

  /**
   * The maximum time to attempt to reconcile the Kustomization on the cluster.
   */
  timeoutInSeconds?: int64;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster.
   */
  syncIntervalInSeconds?: int64;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster in the event of failure on reconciliation.
   */
  retryIntervalInSeconds?: int64;

  /**
   * Enable/disable garbage collections of Kubernetes objects created by this Kustomization.
   */
  prune?: boolean;

  /**
   * Enable/disable re-creating Kubernetes resources on the cluster when patching fails due to an immutable field change.
   */
  force?: boolean;

  /**
   * Enable/disable health check for all Kubernetes objects created by this Kustomization.
   */
  wait?: boolean;

  /**
   * Used for variable substitution for this Kustomization after kustomize build.
   */
  postBuild?: PostBuildDefinition;
}

/**
 * Properties to create a Source Control Configuration resource
 */
model SourceControlConfigurationProperties {
  /**
   * Url of the SourceControl Repository.
   */
  repositoryUrl?: string;

  /**
   * The namespace to which this operator is installed to. Maximum of 253 lower case alphanumeric characters, hyphen and period only.
   */
  operatorNamespace?: string = "default";

  /**
   * Instance name of the operator - identifying the specific configuration.
   */
  operatorInstanceName?: string;

  /**
   * Type of the operator
   */
  operatorType?: OperatorType;

  /**
   * Any Parameters for the Operator instance in string format.
   */
  operatorParams?: string;

  /**
   * Name-value pairs of protected configuration settings for the configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  configurationProtectedSettings?: Record<string>;

  /**
   * Scope at which the operator will be installed.
   */
  operatorScope?: OperatorScopeType = OperatorScopeType.cluster;

  /**
   * Public Key associated with this SourceControl configuration (either generated within the cluster or provided by the user).
   */
  @visibility("read")
  repositoryPublicKey?: string;

  /**
   * Base64-encoded known_hosts contents containing public SSH keys required to access private Git instances
   */
  sshKnownHostsContents?: string;

  /**
   * Option to enable Helm Operator for this git configuration.
   */
  enableHelmOperator?: boolean;

  /**
   * Properties for Helm operator.
   */
  helmOperatorProperties?: HelmOperatorProperties;

  /**
   * The provisioning state of the resource provider.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateType;

  /**
   * Compliance Status of the Configuration
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;
}

/**
 * Properties for Helm operator.
 */
model HelmOperatorProperties {
  /**
   * Version of the operator Helm chart.
   */
  chartVersion?: string;

  /**
   * Values override for the operator Helm chart.
   */
  chartValues?: string;
}

/**
 * Compliance Status details
 */
model ComplianceStatus {
  /**
   * The compliance state of the configuration.
   */
  @visibility("read")
  complianceState?: ComplianceStateType;

  /**
   * Datetime the configuration was last applied.
   */
  lastConfigApplied?: utcDateTime;

  /**
   * Message from when the configuration was applied.
   */
  message?: string;

  /**
   * Level of the message.
   */
  messageLevel?: MessageLevelType;
}