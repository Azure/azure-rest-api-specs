import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridNetwork;

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Converging: "Converging",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelling: "Cancelling",
}

/**
 * The configuration group schema state.
 */
union VersionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preview: "Preview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deprecated: "Deprecated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidationFailed: "ValidationFailed",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Publisher Scope.
 */
union PublisherScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Private: "Private",
}

/**
 * The resource reference arm id type.
 */
union IdType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Open: "Open",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secret: "Secret",
}

/**
 * The secret type which indicates if secret or not.
 */
union ConfigurationGroupValueConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secret: "Secret",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Open: "Open",
}

/**
 * The NFVI type.
 */
union NfviType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureArcKubernetes: "AzureArcKubernetes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureCore: "AzureCore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureOperatorNexus: "AzureOperatorNexus",
}

/**
 * The secret type which indicates if secret or not.
 */
union NetworkFunctionConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secret: "Secret",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Open: "Open",
}

/**
 * The http method of the request.
 */
union HttpMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Post: "Post",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Put: "Put",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Get: "Get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Patch: "Patch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Delete: "Delete",
}

/**
 * The component resource deployment status.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deployed: "Deployed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uninstalled: "Uninstalled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Superseded: "Superseded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uninstalling: "Uninstalling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Pending-Install`: "Pending-Install",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Pending-Upgrade`: "Pending-Upgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Pending-Rollback`: "Pending-Rollback",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Downloading: "Downloading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Installing: "Installing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Reinstalling: "Reinstalling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rollingback: "Rollingback",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Upgrading: "Upgrading",
}

/**
 * The status of a Pod.
 */
union PodStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Terminating: "Terminating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotReady: "NotReady",
}

/**
 * The type of pod event.
 */
union PodEventType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Normal: "Normal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
}

/**
 * The network function type.
 */
union NetworkFunctionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualNetworkFunction: "VirtualNetworkFunction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ContainerizedNetworkFunction: "ContainerizedNetworkFunction",
}

/**
 * The resource element template type.
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArmResourceDefinition: "ArmResourceDefinition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NetworkFunctionDefinition: "NetworkFunctionDefinition",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * The artifact store type.
 */
union ArtifactStoreType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureContainerRegistry: "AzureContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageAccount: "AzureStorageAccount",
}

/**
 * The backing resource network access type.
 */
union BackingResourcePublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The replication strategy.
 */
union ArtifactReplicationStrategy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SingleReplication: "SingleReplication",
}

/**
 * The artifact manifest state.
 */
union ArtifactManifestState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uploading: "Uploading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uploaded: "Uploaded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidationFailed: "ValidationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
}

/**
 * The artifact type.
 */
union ArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OCIArtifact: "OCIArtifact",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VhdImageFile: "VhdImageFile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArmTemplate: "ArmTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageFile: "ImageFile",
}

/**
 * The credential type.
 */
union CredentialType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureContainerRegistryScopedToken: "AzureContainerRegistryScopedToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageAccountToken: "AzureStorageAccountToken",
}

/**
 * The artifact state.
 */
union ArtifactState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preview: "Preview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deprecated: "Deprecated",
}

/**
 * Name of this Sku
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
}

/**
 * The SKU tier based on the SKU name.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
}

/**
 * The type of long-running operation the user wants to cancel, such as 'Put'.
 */
union LongRunningOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Put: "Put",
}

/**
 * The application enablement.
 */
union ApplicationEnablement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The network function type.
 */
union ContainerizedNetworkFunctionNFVIType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureArcKubernetes: "AzureArcKubernetes",
}

/**
 * The network function type.
 */
union VirtualNetworkFunctionNFVIType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureCore: "AzureCore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureOperatorNexus: "AzureOperatorNexus",
}

/**
 * The artifact type.
 */
union AzureArcKubernetesArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HelmPackage: "HelmPackage",
}

/**
 * The artifact type.
 */
union AzureCoreArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VhdImageFile: "VhdImageFile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArmTemplate: "ArmTemplate",
}

/**
 * The artifact type.
 */
union AzureOperatorNexusArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageFile: "ImageFile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArmTemplate: "ArmTemplate",
}

/**
 * The template type.
 */
union TemplateType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArmTemplate: "ArmTemplate",
}

/**
 * The configuration generation type.
 */
union ConfigurationGenerationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HandlebarTemplate: "HandlebarTemplate",
}

/**
 * Configuration group schema properties.
 */
model ConfigurationGroupSchemaPropertiesFormat {
  /**
   * The provisioning state of the Configuration group schema resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The configuration group schema version state.
   */
  @visibility(Lifecycle.Read)
  versionState?: VersionState;

  /**
   * Description of what schema can contain.
   */
  description?: string;

  /**
   * Name and value pairs that define the configuration value. It can be a well formed escaped JSON string.
   */
  schemaDefinition?: string;
}

/**
 * Tags object for patch operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Publisher configuration group schema update request definition.
 */
model ConfigurationGroupSchemaVersionUpdateState {
  /**
   * The configuration group schema state.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  versionState?: VersionState;
}

/**
 * Hybrid configuration group value properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("configurationType")
model configurationGroupValuePropertiesFormat {
  /**
   * The provisioning state of the site resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The publisher name for the configuration group schema.
   */
  @visibility(Lifecycle.Read)
  publisherName?: string;

  /**
   * The scope of the publisher.
   */
  @visibility(Lifecycle.Read)
  publisherScope?: PublisherScope;

  /**
   * The configuration group schema name.
   */
  @visibility(Lifecycle.Read)
  configurationGroupSchemaName?: string;

  /**
   * The location of the configuration group schema offering.
   */
  @visibility(Lifecycle.Read)
  configurationGroupSchemaOfferingLocation?: string;

  /**
   * The configuration group schema resource reference.
   */
  configurationGroupSchemaResourceReference?: DeploymentResourceIdReference;

  /**
   * The value which indicates if configuration values are secrets
   */
  configurationType: ConfigurationGroupValueConfigurationType;
}

/**
 * The azure resource reference which is used for deployment.
 */
@discriminator("idType")
model DeploymentResourceIdReference {
  /**
   * The resource reference arm id type.
   */
  idType: IdType = IdType.Open;
}

/**
 * Network function properties.
 */
@discriminator("configurationType")
model NetworkFunctionPropertiesFormat {
  /**
   * The provisioning state of the network function resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The publisher name for the network function.
   */
  publisherName?: string;

  /**
   * The scope of the publisher.
   */
  publisherScope?: PublisherScope;

  /**
   * The network function definition group name for the network function.
   */
  networkFunctionDefinitionGroupName?: string;

  /**
   * The network function definition version for the network function.
   */
  networkFunctionDefinitionVersion?: string;

  /**
   * The location of the network function definition offering.
   */
  networkFunctionDefinitionOfferingLocation?: string;

  /**
   * The network function definition version resource reference.
   */
  networkFunctionDefinitionVersionResourceReference?: DeploymentResourceIdReference;

  /**
   * The nfvi type for the network function.
   */
  nfviType?: NfviType;

  /**
   * The nfviId for the network function.
   */
  nfviId?: string;

  /**
   * Indicates if software updates are allowed during deployment.
   */
  allowSoftwareUpdate?: boolean;

  /**
   * The value which indicates if NF  values are secrets
   */
  configurationType: NetworkFunctionConfigurationType;

  /**
   * The role configuration override values from the user.
   */
  roleOverrideValues?: string[];
}

/**
 * Payload for execute request post call.
 */
model ExecuteRequestParameters {
  /**
   * The endpoint of service to call.
   */
  serviceEndpoint: string;

  /**
   * The request metadata.
   */
  requestMetadata: RequestMetadata;
}

/**
 * Request metadata of execute request post call payload.
 */
model RequestMetadata {
  /**
   * The relative path of the request.
   */
  relativePath: string;

  /**
   * The http method of the request.
   */
  httpMethod: HttpMethod;

  /**
   * The serialized body of the request.
   */
  serializedBody: string;

  /**
   * The api version of the request.
   */
  apiVersion?: string;
}

/**
 * The component properties of the network function.
 */
model ComponentProperties {
  /**
   * The provisioning state of the component resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The JSON-serialized deployment profile of the component resource.
   */
  @visibility(Lifecycle.Read)
  deploymentProfile?: string;

  /**
   * The deployment status of the component resource.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: DeploymentStatusProperties;
}

/**
 * The deployment status properties of the network function component.
 */
model DeploymentStatusProperties {
  /**
   * The status of the component resource.
   */
  status?: Status;

  /**
   * The resource related to the component resource.
   */
  resources?: Resources;

  /**
   * The next expected update of deployment status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExpectedUpdateAt?: utcDateTime;
}

/**
 * The resources of the network function component.
 */
model Resources {
  /**
   * Deployments that are related to component resource.
   */
  deployments?: Deployment[];

  /**
   * Pods related to component resource.
   */
  pods?: Pod[];

  /**
   * Replica sets related to component resource.
   */
  replicaSets?: ReplicaSet[];

  /**
   * Stateful sets related to component resource.
   */
  statefulSets?: StatefulSet[];

  /**
   * Daemonsets related to component resource.
   */
  daemonSets?: DaemonSet[];
}

/**
 * Helm Deployment status properties.
 */
model Deployment {
  /**
   * The name of the deployment.
   */
  name?: string;

  /**
   * The namespace of the deployment.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Number of ready pods.
   */
  ready?: int32;

  /**
   * Number of upto date pods.
   */
  upToDate?: int32;

  /**
   * Number of available pods.
   */
  available?: int32;

  /**
   * Creation Time of deployment.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Helm Pod status properties.
 */
model Pod {
  /**
   * The name of the Pod.
   */
  name?: string;

  /**
   * The namespace of the Pod.
   */
  `namespace`?: string;

  /**
   * Desired number of containers
   */
  desired?: int32;

  /**
   * Number of ready containers.
   */
  ready?: int32;

  /**
   * The status of a pod.
   */
  status?: PodStatus;

  /**
   * Creation Time of Pod.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Last 5 Pod events.
   */
  @identifiers(#[])
  events?: PodEvent[];
}

/**
 * Pod Event  properties.
 */
model PodEvent {
  /**
   * The type of pod event.
   */
  type?: PodEventType;

  /**
   * Event reason.
   */
  reason?: string;

  /**
   * Event message.
   */
  message?: string;

  /**
   * Event Last seen.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeenTime?: utcDateTime;
}

/**
 * Helm ReplicaSet status properties.
 */
model ReplicaSet {
  /**
   * The name of the replicaSet.
   */
  name?: string;

  /**
   * The namespace of the replicaSet.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Number of ready pods.
   */
  ready?: int32;

  /**
   * Number of current pods.
   */
  current?: int32;

  /**
   * Creation Time of replicaSet.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Helm StatefulSet status properties.
 */
model StatefulSet {
  /**
   * The name of the statefulset.
   */
  name?: string;

  /**
   * The namespace of the statefulset.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Number of ready pods.
   */
  ready?: int32;

  /**
   * Creation Time of statefulset.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Helm DaemonSet status properties.
 */
model DaemonSet {
  /**
   * The name of the daemonSet.
   */
  name?: string;

  /**
   * The namespace of the daemonSet.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Current number of pods
   */
  current?: int32;

  /**
   * Number of Ready pods
   */
  ready?: int32;

  /**
   * Number of  upto date pods
   */
  upToDate?: int32;

  /**
   * Number of available pods.
   */
  available?: int32;

  /**
   * Creation Time of daemonSet.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Network function definition group properties.
 */
model NetworkFunctionDefinitionGroupPropertiesFormat {
  /**
   * The provisioning state of the network function definition groups resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The network function definition group description.
   */
  description?: string;
}

/**
 * Network function definition version properties.
 */
@discriminator("networkFunctionType")
model NetworkFunctionDefinitionVersionPropertiesFormat {
  /**
   * The provisioning state of the network function definition version resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The network function definition version state.
   */
  @visibility(Lifecycle.Read)
  versionState?: VersionState;

  /**
   * The network function definition version description.
   */
  description?: string;

  /**
   * The deployment parameters of the network function definition version.
   */
  deployParameters?: string;

  /**
   * The network function type.
   */
  networkFunctionType: NetworkFunctionType;
}

/**
 * Publisher network function definition version update request definition.
 */
model NetworkFunctionDefinitionVersionUpdateState {
  /**
   * The network function definition version state.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  versionState?: VersionState;
}

/**
 * network service design group properties.
 */
model NetworkServiceDesignGroupPropertiesFormat {
  /**
   * The provisioning state of the network service design groups resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The network service design group description.
   */
  description?: string;
}

/**
 * network service design version properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model networkServiceDesignVersionPropertiesFormat {
  /**
   * The provisioning state of the network service design version resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The network service design version state.
   */
  @visibility(Lifecycle.Read)
  versionState?: VersionState;

  /**
   * The network service design version description.
   */
  description?: string;

  /**
   * The configuration schemas to used to define the values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationGroupSchemaReferences?: Record<ReferencedResource>;

  /**
   * The nfvis from the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nfvisFromSite?: Record<NfviDetails>;

  /**
   * List of resource element template
   */
  @identifiers(#["name"])
  resourceElementTemplates?: ResourceElementTemplate[];
}

/**
 * Reference to another resource.
 */
model ReferencedResource {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * The nfvi details.
 */
model NfviDetails {
  /**
   * The nfvi name.
   */
  name?: string;

  /**
   * The nfvi type.
   */
  type?: string;
}

/**
 * The resource element template object.
 */
@discriminator("type")
model ResourceElementTemplate {
  /**
   * Name of the resource element template.
   */
  name?: string;

  /**
   * The resource element template type.
   */
  type: Type;

  /**
   * The depends on profile.
   */
  dependsOnProfile?: DependsOnProfile;
}

/**
 * Depends on profile definition.
 */
model DependsOnProfile {
  /**
   * Application installation operation dependency.
   */
  installDependsOn?: string[];

  /**
   * Application deletion operation dependency.
   */
  uninstallDependsOn?: string[];

  /**
   * Application update operation dependency.
   */
  updateDependsOn?: string[];
}

/**
 * Publisher network service design version update request definition.
 */
model NetworkServiceDesignVersionUpdateState {
  /**
   * The network service design version state.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  versionState?: VersionState;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * publisher properties.
 */
model PublisherPropertiesFormat {
  /**
   * The provisioning state of the publisher resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The publisher scope.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scope?: PublisherScope;
}

/**
 * Artifact store properties.
 */
model ArtifactStorePropertiesFormat {
  /**
   * The provisioning state of the application groups resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The artifact store type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storeType?: ArtifactStoreType;

  /**
   * The artifact store backing resource network access type
   */
  backingResourcePublicNetworkAccess?: BackingResourcePublicNetworkAccess;

  /**
   * The replication strategy.
   */
  replicationStrategy?: ArtifactReplicationStrategy;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedResourceGroupConfiguration?: ArtifactStorePropertiesFormatManagedResourceGroupConfiguration;

  /**
   * The created storage resource id
   */
  @visibility(Lifecycle.Read)
  storageResourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ArtifactStorePropertiesFormatManagedResourceGroupConfiguration {
  /**
   * The managed resource group name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name?: string;

  /**
   * The managed resource group location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * List of network fabric controller ids.
 */
model ArtifactStoreNetworkFabricControllerEndPoints {
  /**
   * list of network fabric controllers.
   */
  @identifiers(#["id"])
  networkFabricControllerIds?: ReferencedResource[];
}

/**
 * List of manual private endpoints.
 */
model ArtifactStoreNetworkFabricControllerEndPointsList
  is Azure.Core.Page<ArtifactStoreNetworkFabricControllerEndPoints>;

/**
 * List of manual private endpoints.
 */
model ArtifactStorePrivateEndPointsFormat {
  /**
   * list of private endpoints.
   */
  @identifiers(#["id"])
  manualPrivateEndPointConnections?: ReferencedResource[];
}

/**
 * List of manual private endpoints.
 */
model ArtifactStorePrivateEndPointsListResult
  is Azure.Core.Page<ArtifactStorePrivateEndPointsFormat>;

/**
 * Artifact manifest properties.
 */
model ArtifactManifestPropertiesFormat {
  /**
   * The provisioning state of the ArtifactManifest resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The artifact manifest state.
   */
  @visibility(Lifecycle.Read)
  artifactManifestState?: ArtifactManifestState;

  /**
   * The artifacts list.
   */
  @identifiers(#["artifactName", "artifactType", "artifactVersion"])
  artifacts?: ManifestArtifactFormat[];
}

/**
 * Manifest artifact properties.
 */
model ManifestArtifactFormat {
  /**
   * The artifact name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactName?: string;

  /**
   * The artifact type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactType?: ArtifactType;

  /**
   * The artifact version.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactVersion?: string;
}

/**
 * The artifact manifest credential definition.
 */
@discriminator("credentialType")
model ArtifactAccessCredential {
  /**
   * The credential type.
   */
  credentialType: CredentialType;
}

/**
 * The artifact manifest updating request payload. Only the 'Uploaded' state is allowed for updates. Other states are used for internal state transitioning.
 */
model ArtifactManifestUpdateState {
  /**
   * The artifact manifest state.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactManifestState?: ArtifactManifestState;
}

/**
 * The proxy artifact overview.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProxyArtifactListOverview
  extends Azure.ResourceManager.CommonTypes.ProxyResource {}

/**
 * The proxy artifact overview.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProxyArtifactVersionsListOverview
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Proxy Artifact overview properties.
   */
  @visibility(Lifecycle.Read)
  properties?: ProxyArtifactOverviewPropertiesValue;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProxyArtifactOverviewPropertiesValue {
  /**
   * The artifact type.
   */
  artifactType?: ArtifactType;

  /**
   * The artifact version.
   */
  artifactVersion?: string;

  /**
   * The artifact state
   */
  artifactState?: ArtifactState;
}

/**
 * The artifact updating request payload.
 */
model ArtifactChangeState {
  /**
   * Artifact update state properties.
   */
  properties?: ArtifactChangeStateProperties;
}

/**
 * The artifact update state properties.
 */
model ArtifactChangeStateProperties {
  /**
   * The artifact state
   */
  artifactState?: ArtifactState;
}

/**
 * Site properties.
 */
model SitePropertiesFormat {
  /**
   * The provisioning state of the site resource. **TODO**: Confirm if this is needed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of NFVIs
   */
  @identifiers(#["name"])
  nfvis?: NFVIs[];

  /**
   * The list of site network services on the site.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  siteNetworkServiceReferences?: ReferencedResource[];
}

/**
 * The NFVI object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("nfviType")
model NFVIs {
  /**
   * Name of the nfvi.
   */
  name?: string;

  /**
   * The NFVI type.
   */
  nfviType: NfviType;
}

/**
 * Site network service properties.
 */
model SiteNetworkServicePropertiesFormat {
  /**
   * The provisioning state of the site network service resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Managed resource group configuration.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The site details
   */
  siteReference?: ReferencedResource;

  /**
   * The publisher name for the site network service.
   */
  @visibility(Lifecycle.Read)
  publisherName?: string;

  /**
   * The scope of the publisher.
   */
  @visibility(Lifecycle.Read)
  publisherScope?: PublisherScope;

  /**
   * The network service design group name for the site network service.
   */
  @visibility(Lifecycle.Read)
  networkServiceDesignGroupName?: string;

  /**
   * The network service design version for the site network service.
   */
  @visibility(Lifecycle.Read)
  networkServiceDesignVersionName?: string;

  /**
   * The location of the network service design offering.
   */
  @visibility(Lifecycle.Read)
  networkServiceDesignVersionOfferingLocation?: string;

  /**
   * The network service design version resource reference.
   */
  networkServiceDesignVersionResourceReference?: DeploymentResourceIdReference;

  /**
   * The goal state of the site network service resource. This has references to the configuration group value objects that describe the desired state of the site network service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  desiredStateConfigurationGroupValueReferences?: Record<ReferencedResource>;

  /**
   * The network service design version for the site network service.
   */
  @visibility(Lifecycle.Read)
  lastStateNetworkServiceDesignVersionName?: string;

  /**
   * The last state of the site network service resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  lastStateConfigurationGroupValueReferences?: Record<ReferencedResource>;
}

/**
 * Managed resource group configuration.
 */
model ManagedResourceGroupConfiguration {
  /**
   * Managed resource group name.
   */
  name?: string;

  /**
   * Managed resource group location.
   */
  location?: string;
}

/**
 * Sku, to be associated with a SiteNetworkService.
 */
model Sku {
  /**
   * Name of this Sku
   */
  name: SkuName;

  /**
   * The SKU tier based on the SKU name.
   */
  @visibility(Lifecycle.Read)
  tier?: SkuTier;
}

/**
 * Cancels an ongoing long-running operation, only Put is supported now
 */
model CancelInformation {
  /**
   * The ARM id of the siteNetworkService resource.
   */
  siteNetworkServiceReference: ReferencedResource;

  /**
   * The type of long-running operation the user wants to cancel, such as 'Put'.
   */
  longRunningOperation?: LongRunningOperation;
}

/**
 * Reference to an Azure ARC custom location resource.
 */
model CustomLocationResourceId {
  /**
   * Azure ARC custom location resource ID.
   */
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[eE][xX][tT][eE][nN][dD][eE][dD][lL][oO][cC][aA][tT][iI][oO][nN]/[cC][uU][sS][tT][oO][mM][lL][oO][cC][aA][tT][iI][oO][nN][sS]/[^/?#]+$")
  id?: string;
}

/**
 * Network function application definition.
 */
model NetworkFunctionApplication {
  /**
   * The name of the network function application.
   */
  name?: string;

  /**
   * Depends on profile definition.
   */
  dependsOnProfile?: DependsOnProfile;
}

/**
 * Artifact profile properties.
 */
model ArtifactProfile {
  /**
   * The reference to artifact store.
   */
  artifactStore?: ReferencedResource;
}

/**
 * Mapping rule profile properties.
 */
model MappingRuleProfile {
  /**
   * The application enablement.
   */
  applicationEnablement?: ApplicationEnablement;
}

/**
 * The azure container registry scoped token credential definition.
 */
model AzureContainerRegistryScopedTokenCredential
  extends ArtifactAccessCredential {
  /**
   * The username of the credential.
   */
  username?: string;

  /**
   * The credential value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  acrToken?: string;

  /**
   * The Acr server url
   */
  acrServerUrl?: string;

  /**
   * The repositories that could be accessed using the current credential.
   */
  repositories?: string[];

  /**
   * The UTC time when credential will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The credential type.
   */
  credentialType: "AzureContainerRegistryScopedToken";
}

/**
 * The azure storage account credential definition.
 */
model AzureStorageAccountCredential extends ArtifactAccessCredential {
  /**
   * The storage account Id
   */
  storageAccountId?: string;

  /**
   * The containers that could be accessed using the current credential.
   */
  @identifiers(#[])
  containerCredentials?: AzureStorageAccountContainerCredential[];

  /**
   * The UTC time when credential will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The credential type.
   */
  credentialType: "AzureStorageAccountToken";
}

/**
 * The azure storage account container credential definition.
 */
model AzureStorageAccountContainerCredential {
  /**
   * The storage account container name
   */
  containerName?: string;

  /**
   * The storage account container sas uri
   */
  containerSasUri?: string;
}

/**
 * Secret deployment resource id reference.
 */
model SecretDeploymentResourceReference extends DeploymentResourceIdReference {
  /**
   * Resource ID.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  id?: string;

  /**
   * The resource reference arm id type.
   */
  idType: "Secret";
}

/**
 * Non secret deployment resource id reference.
 */
model OpenDeploymentResourceReference extends DeploymentResourceIdReference {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * The resource reference arm id type.
   */
  idType: "Open";
}

/**
 * The ConfigurationValue with secrets.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationValueWithSecrets
  extends configurationGroupValuePropertiesFormat {
  /**
   * Name and value pairs that define the configuration value secrets. It can be a well formed escaped JSON string.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  secretConfigurationValue?: string;

  /**
   * The value which indicates if configuration values are secrets
   */
  configurationType: "Secret";
}

/**
 * The ConfigurationValue with no secrets.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationValueWithoutSecrets
  extends configurationGroupValuePropertiesFormat {
  /**
   * Name and value pairs that define the configuration value. It can be a well formed escaped JSON string.
   */
  configurationValue?: string;

  /**
   * The value which indicates if configuration values are secrets
   */
  configurationType: "Open";
}

/**
 * NetworkFunction with secrets.
 */
model NetworkFunctionValueWithSecrets extends NetworkFunctionPropertiesFormat {
  /**
   * The JSON-serialized secret deployment values from the user. This contains secrets like passwords,keys etc
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  secretDeploymentValues?: string;

  /**
   * The value which indicates if NF  values are secrets
   */
  configurationType: "Secret";
}

/**
 * NetworkFunction with no secrets.
 */
model NetworkFunctionValueWithoutSecrets
  extends NetworkFunctionPropertiesFormat {
  /**
   * The JSON-serialized deployment values from the user.
   */
  deploymentValues?: string;

  /**
   * The value which indicates if NF  values are secrets
   */
  configurationType: "Open";
}

/**
 * Containerized network function network function definition version properties.
 */
model ContainerizedNetworkFunctionDefinitionVersion
  extends NetworkFunctionDefinitionVersionPropertiesFormat {
  /**
   * Containerized network function template.
   */
  networkFunctionTemplate?: ContainerizedNetworkFunctionTemplate;

  /**
   * The network function type.
   */
  networkFunctionType: "ContainerizedNetworkFunction";
}

/**
 * Containerized network function template.
 */
@discriminator("nfviType")
model ContainerizedNetworkFunctionTemplate {
  /**
   * The network function type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  nfviType: ContainerizedNetworkFunctionNFVIType;
}

/**
 * Virtual network function network function definition version properties.
 */
model VirtualNetworkFunctionNetworkFunctionDefinitionVersion
  extends NetworkFunctionDefinitionVersionPropertiesFormat {
  /**
   * Virtual network function template.
   */
  networkFunctionTemplate?: VirtualNetworkFunctionTemplate;

  /**
   * The network function type.
   */
  networkFunctionType: "VirtualNetworkFunction";
}

/**
 * Virtual network function template.
 */
@discriminator("nfviType")
model VirtualNetworkFunctionTemplate {
  /**
   * The network function type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  nfviType: VirtualNetworkFunctionNFVIType;
}

/**
 * Azure Arc kubernetes network function template.
 */
model AzureArcKubernetesNetworkFunctionTemplate
  extends ContainerizedNetworkFunctionTemplate {
  /**
   * Network function applications.
   */
  @identifiers(#["name"])
  networkFunctionApplications?: AzureArcKubernetesNetworkFunctionApplication[];

  /**
   * The network function type.
   */
  nfviType: "AzureArcKubernetes";
}

/**
 * Azure arc kubernetes network function application definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("artifactType")
model AzureArcKubernetesNetworkFunctionApplication
  extends NetworkFunctionApplication {
  /**
   * The artifact type.
   */
  artifactType: AzureArcKubernetesArtifactType;
}

/**
 * Azure arc kubernetes helm application configurations.
 */
model AzureArcKubernetesHelmApplication
  extends AzureArcKubernetesNetworkFunctionApplication {
  /**
   * Azure arc kubernetes artifact profile.
   */
  artifactProfile?: AzureArcKubernetesArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureArcKubernetesDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "HelmPackage";
}

/**
 * Azure arc kubernetes artifact profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureArcKubernetesArtifactProfile extends ArtifactProfile {
  /**
   * Helm artifact profile.
   */
  helmArtifactProfile?: HelmArtifactProfile;
}

/**
 * Helm artifact profile.
 */
model HelmArtifactProfile {
  /**
   * Helm package name.
   */
  helmPackageName?: string;

  /**
   * Helm package version range.
   */
  helmPackageVersionRange?: string;

  /**
   * The registry values path list.
   */
  registryValuesPaths?: string[];

  /**
   * The image pull secrets values path list.
   */
  imagePullSecretsValuesPaths?: string[];
}

/**
 * Azure arc kubernetes deploy mapping rule profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureArcKubernetesDeployMappingRuleProfile extends MappingRuleProfile {
  /**
   * The helm mapping rule profile.
   */
  helmMappingRuleProfile?: HelmMappingRuleProfile;
}

/**
 * Helm mapping rule profile
 */
model HelmMappingRuleProfile {
  /**
   * Helm release namespace.
   */
  releaseNamespace?: string;

  /**
   * Helm release name.
   */
  releaseName?: string;

  /**
   * Helm package version.
   */
  helmPackageVersion?: string;

  /**
   * Helm release values.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  values?: string;

  /**
   * The helm deployment options
   */
  options?: HelmMappingRuleProfileOptions;
}

/**
 * The helm deployment options
 */
model HelmMappingRuleProfileOptions {
  /**
   * The helm deployment install options
   */
  @doc("The helm deployment install options")
  installOptions?: HelmInstallOptions;

  /**
   * The helm deployment upgrade options
   */
  @doc("The helm deployment upgrade options")
  upgradeOptions?: HelmUpgradeOptions;
}

/**
 * The helm deployment install options
 */
model HelmInstallOptions {
  /**
   * The helm deployment atomic options
   */
  atomic?: string;

  /**
   * The helm deployment wait options
   */
  wait?: string;

  /**
   * The helm deployment timeout options
   */
  timeout?: string;
}

/**
 * The helm deployment install options
 */
model HelmUpgradeOptions {
  /**
   * The helm deployment atomic options
   */
  atomic?: string;

  /**
   * The helm deployment wait options
   */
  wait?: string;

  /**
   * The helm deployment timeout options
   */
  timeout?: string;
}

/**
 * Azure virtual network function template.
 */
model AzureCoreNetworkFunctionTemplate extends VirtualNetworkFunctionTemplate {
  /**
   * Network function applications.
   */
  @identifiers(#["name"])
  networkFunctionApplications?: AzureCoreNetworkFunctionApplication[];

  /**
   * The network function type.
   */
  nfviType: "AzureCore";
}

/**
 * Azure virtual network function application definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("artifactType")
model AzureCoreNetworkFunctionApplication extends NetworkFunctionApplication {
  /**
   * The artifact type.
   */
  artifactType: AzureCoreArtifactType;
}

/**
 * Azure Operator Distributed Services network function template.
 */
model AzureOperatorNexusNetworkFunctionTemplate
  extends VirtualNetworkFunctionTemplate {
  /**
   * Network function applications.
   */
  @identifiers(#["name"])
  networkFunctionApplications?: AzureOperatorNexusNetworkFunctionApplication[];

  /**
   * The network function type.
   */
  nfviType: "AzureOperatorNexus";
}

/**
 * Azure Operator Distributed Services network function application definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("artifactType")
model AzureOperatorNexusNetworkFunctionApplication
  extends NetworkFunctionApplication {
  /**
   * The artifact type.
   */
  artifactType: AzureOperatorNexusArtifactType;
}

/**
 * Azure core network function vhd application definition.
 */
model AzureCoreNetworkFunctionVhdApplication
  extends AzureCoreNetworkFunctionApplication {
  /**
   * Azure vhd image artifact profile.
   */
  artifactProfile?: AzureCoreVhdImageArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureCoreVhdImageDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "VhdImageFile";
}

/**
 * Azure vhd artifact profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCoreVhdImageArtifactProfile extends ArtifactProfile {
  /**
   * Vhd artifact profile.
   */
  vhdArtifactProfile?: VhdImageArtifactProfile;
}

/**
 * Vhd artifact profile.
 */
model VhdImageArtifactProfile {
  /**
   * Vhd name.
   */
  vhdName?: string;

  /**
   * Vhd version.
   */
  vhdVersion?: string;
}

/**
 * Azure vhd deploy mapping rule profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCoreVhdImageDeployMappingRuleProfile extends MappingRuleProfile {
  /**
   * The vhd mapping rule profile.
   */
  vhdImageMappingRuleProfile?: VhdImageMappingRuleProfile;
}

/**
 * Vhd mapping rule profile
 */
model VhdImageMappingRuleProfile {
  /**
   * List of values.
   */
  userConfiguration?: string;
}

/**
 * Azure core network function Template application definition.
 */
model AzureCoreNetworkFunctionArmTemplateApplication
  extends AzureCoreNetworkFunctionApplication {
  /**
   * Azure template artifact profile.
   */
  artifactProfile?: AzureCoreArmTemplateArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureCoreArmTemplateDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "ArmTemplate";
}

/**
 * Azure template artifact profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCoreArmTemplateArtifactProfile extends ArtifactProfile {
  /**
   * Template artifact profile.
   */
  templateArtifactProfile?: ArmTemplateArtifactProfile;
}

/**
 * Template artifact profile.
 */
model ArmTemplateArtifactProfile {
  /**
   * Template name.
   */
  templateName?: string;

  /**
   * Template version.
   */
  templateVersion?: string;
}

/**
 * Azure template deploy mapping rule profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCoreArmTemplateDeployMappingRuleProfile extends MappingRuleProfile {
  /**
   * The template mapping rule profile.
   */
  templateMappingRuleProfile?: ArmTemplateMappingRuleProfile;
}

/**
 * Template mapping rule profile
 */
model ArmTemplateMappingRuleProfile {
  /**
   * List of template parameters.
   */
  templateParameters?: string;
}

/**
 * Azure Operator Distributed Services network function image application definition.
 */
model AzureOperatorNexusNetworkFunctionImageApplication
  extends AzureOperatorNexusNetworkFunctionApplication {
  /**
   * Azure Operator Distributed Services image artifact profile.
   */
  artifactProfile?: AzureOperatorNexusImageArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureOperatorNexusImageDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "ImageFile";
}

/**
 * Azure Operator Distributed Services image artifact profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureOperatorNexusImageArtifactProfile extends ArtifactProfile {
  /**
   * Image artifact profile.
   */
  imageArtifactProfile?: ImageArtifactProfile;
}

/**
 * Image artifact profile.
 */
model ImageArtifactProfile {
  /**
   * Image name.
   */
  imageName?: string;

  /**
   * Image version.
   */
  imageVersion?: string;
}

/**
 * Azure Operator Distributed Services image deploy mapping rule profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureOperatorNexusImageDeployMappingRuleProfile
  extends MappingRuleProfile {
  /**
   * The vhd mapping rule profile.
   */
  imageMappingRuleProfile?: ImageMappingRuleProfile;
}

/**
 * Image mapping rule profile
 */
model ImageMappingRuleProfile {
  /**
   * List of values.
   */
  userConfiguration?: string;
}

/**
 * Azure Operator Distributed Services network function Template application definition.
 */
model AzureOperatorNexusNetworkFunctionArmTemplateApplication
  extends AzureOperatorNexusNetworkFunctionApplication {
  /**
   * Azure Operator Distributed Services Template artifact profile.
   */
  artifactProfile?: AzureOperatorNexusArmTemplateArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureOperatorNexusArmTemplateDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "ArmTemplate";
}

/**
 * Azure Operator Distributed Services vhd artifact profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureOperatorNexusArmTemplateArtifactProfile extends ArtifactProfile {
  /**
   * Template artifact profile.
   */
  templateArtifactProfile?: ArmTemplateArtifactProfile;
}

/**
 * Azure Operator Distributed Services template deploy mapping rule profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureOperatorNexusArmTemplateDeployMappingRuleProfile
  extends MappingRuleProfile {
  /**
   * The template mapping rule profile.
   */
  templateMappingRuleProfile?: ArmTemplateMappingRuleProfile;
}

/**
 * The arm resource definition resource element template details.
 */
model ArmResourceDefinitionResourceElementTemplateDetails
  extends ResourceElementTemplate {
  /**
   * The resource element template type.
   */
  configuration?: ArmResourceDefinitionResourceElementTemplate;

  /**
   * The resource element template type.
   */
  type: "ArmResourceDefinition";
}

/**
 * The arm template RE.
 */
model ArmResourceDefinitionResourceElementTemplate {
  /**
   * The template type.
   */
  templateType?: TemplateType;

  /**
   * Name and value pairs that define the parameter values. It can be  a well formed escaped JSON string.
   */
  parameterValues?: string;

  /**
   * Artifact profile properties.
   */
  artifactProfile?: NSDArtifactProfile;
}

/**
 * Artifact profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSDArtifactProfile {
  /**
   * The artifact store resource id
   */
  artifactStoreReference?: ReferencedResource;

  /**
   * Artifact name.
   */
  artifactName?: string;

  /**
   * Artifact version.
   */
  artifactVersion?: string;
}

/**
 * The network function definition resource element template details.
 */
model NetworkFunctionDefinitionResourceElementTemplateDetails
  extends ResourceElementTemplate {
  /**
   * The resource element template type.
   */
  configuration?: ArmResourceDefinitionResourceElementTemplate;

  /**
   * The resource element template type.
   */
  type: "NetworkFunctionDefinition";
}

/**
 * Proxy Artifact overview properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProxyArtifactOverviewPropertiesFormat {
  /**
   * The proxy artifact overview properties.
   */
  @identifiers(#[])
  artifactVersions?: ProxyArtifactOverviewPropertiesValue[];
}

/**
 * The Azure Core NFVI detail.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCoreNFVIDetails extends NFVIs {
  /**
   * Location of the Azure core.
   */
  location?: string;

  /**
   * The NFVI type.
   */
  nfviType: "AzureCore";
}

/**
 * The AzureArcK8sCluster NFVI detail.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureArcK8sClusterNFVIDetails extends NFVIs {
  /**
   * The reference to the custom location.
   */
  customLocationReference?: ReferencedResource;

  /**
   * The NFVI type.
   */
  nfviType: "AzureArcKubernetes";
}

/**
 * The AzureOperatorNexusCluster NFVI detail.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureOperatorNexusClusterNFVIDetails extends NFVIs {
  /**
   * The reference to the custom location.
   */
  customLocationReference?: ReferencedResource;

  /**
   * The NFVI type.
   */
  nfviType: "AzureOperatorNexus";
}

/**
 * The description for page model
 */
model ProxyArtifactVersionsOverviewListResult {
  /**
   * The description for value property
   */
  @pageItems
  value: ProxyArtifactVersionsListOverview[];

  /**
   * The description for nextLink property
   */
  @nextLink
  nextLink?: string;
}

/**
 * The description for page model
 */
model ProxyArtifactOverviewListResult {
  /**
   * The description for value property
   */
  @pageItems
  value: ProxyArtifactListOverview[];

  /**
   * The description for nextLink property
   */
  @nextLink
  nextLink?: string;
}
