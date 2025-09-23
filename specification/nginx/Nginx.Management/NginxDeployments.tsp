import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.ResourceManager;

namespace NGINX.NGINXPLUS;

/**
 * Represents an Nginx deployment resource.
 */
model NginxDeployment is TrackedResource<NginxDeploymentProperties> {
  /** The name of the Nginx deployment resource. */
  @pattern("^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$")
  @key("nginxDeploymentName")
  @segment("nginxDeployments")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

/**
 * Parameters for updating an Nginx deployment.
 */
model NginxDeploymentUpdateParameters {
  /**
   * The identity properties for the deployment.
   */
  identity: IdentityProperties;

  /**
   * Resource tags.
   */
  tags: NginxDeploymentTag[];

  /**
   * The SKU of the deployment.
   */
  sku: ResourceSkuProperty;

  /**
   * The location of the deployment.
   */
  location: string;

  /**
   * Patch properties for the deployment.
   */
  properties: NginxDeploymentPatchProperties;
}

/**
 * Response model for listing Nginx deployments.
 */
model NginxDeploymentListResponse {
  /**
   * List of Nginx deployments.
   */
  value: NginxDeployment[];

  /**
   * URL to fetch the next page of deployments.
   */
  nextLink?: string;
}

/**
 * Managed identity properties for the deployment.
 */
model IdentityProperties {
  /**
   * The principal ID.
   */
  principalId: string;

  /**
   * The tenant ID.
   */
  tenantId: string;

  /**
   * The identity type.
   */
  type: IdentityType;

  /**
   * User-assigned identities.
   */
  @OpenAPI.extension("x-ms-identifiers", #["principalId"])
  userAssignedIdentities: UserIdentityProperties[];
}

/**
 * The type of managed identity.
 */
union IdentityType {
  /** System assigned managed identity. */
  SystemAssigned: "SystemAssigned",

  /** User assigned managed identity. */
  UserAssigned: "UserAssigned",

  /** Both system and user assigned managed identities. */
  SystemAndUserAssigned: "SystemAssigned, UserAssigned",

  /** No managed identity. */
  None: "None",

  /** Custom identity type not covered by pre-defined values. */
  string,
}

/**
 * Properties for a user-assigned identity.
 */
model UserIdentityProperties {
  /**
   * The principal ID.
   */
  principalId: string;

  /**
   * The client ID.
   */
  clientId: string;
}

/**
 * The SKU of the resource.
 */
model ResourceSku {
  /**
   * The SKU name.
   */
  name: string;
}

/**
 * Properties of an Nginx deployment.
 */
model NginxDeploymentProperties {
  /**
   * The provisioning state of the deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The Nginx version.
   */
  nginxVersion: string;

  /**
   * The network profile.
   */
  networkProfile: NginxNetworkProfile;

  /**
   * The IP address of the deployment.
   */
  ipAddress: string;

  /**
   * Whether diagnostics support is enabled.
   */
  enableDiagnosticsSupport: boolean;

  /**
   * Logging configuration.
   */
  logging: NginxLogging;

  /**
   * Scaling properties.
   */
  scalingProperties: NginxDeploymentScalingProperties;

  /**
   * Auto-upgrade profile.
   */
  autoUpgradeProfile: AutoUpgradeProfile;

  /**
   * User profile.
   */
  userProfile: NginxDeploymentUserProfile;

  /**
   * Nginx App Protect configuration.
   */
  nginxAppProtect: NginxAppProtect;

  /**
   * Dataplane API endpoint.
   */
  dataplaneApiEndpoint: string;
}

/**
 * The provisioning state of a resource.
 */
union ProvisioningState {
  /** The resource has been accepted. */
  Accepted: "Accepted",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The resource provisioning operation failed. */
  Failed: "Failed",

  /** The resource provisioning was canceled. */
  Canceled: "Canceled",

  /** The resource has been deleted. */
  Deleted: "Deleted",

  /** Provisioning state was not specified. */
  NotSpecified: "NotSpecified",

  /** Other provisioning state values. */
  string,
}

/**
 * Network profile for the deployment.
 */
model NginxNetworkProfile {
  /**
   * Frontend IP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Changing casing style here will break users"
  frontEndIPConfiguration: NginxFrontendIPConfiguration;

  /**
   * Network interface configuration.
   */
  networkInterfaceConfiguration: NginxNetworkInterfaceConfiguration;
}

/**
 * Frontend IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Changing casing style here will break users"
model NginxFrontendIPConfiguration {
  /**
   * Public IP addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Changing casing style here will break users"
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  publicIPAddresses: NginxPublicIPAddress[];

  /**
   * Private IP addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Changing casing style here will break users"
  @OpenAPI.extension("x-ms-identifiers", #["privateIPAddress"])
  privateIPAddresses: NginxPrivateIPAddress[];
}

/**
 * Public IP address reference.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Changing casing style here will break users"
model NginxPublicIPAddress {
  /**
   * The resource ID of the public IP address.
   */
  id: string;
}

/**
 * Private IP address configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Changing casing style here will break users"
model NginxPrivateIPAddress {
  /**
   * The private IP address.
   */
  privateIPAddress: string;

  /**
   * The allocation method for the private IP.
   */
  privateIPAllocationMethod: NginxPrivateIPAllocationMethod;

  /**
   * The subnet resource ID.
   */
  subnetId: string;
}

/**
 * The allocation method for a private IP address.
 */
union NginxPrivateIPAllocationMethod {
  /** Static private IP allocation method. */
  Static: "Static",

  /** Dynamic private IP allocation method. */
  Dynamic: "Dynamic",

  /** Other allocation methods not covered by pre-defined values. */
  string,
}

/**
 * Network interface configuration.
 */
model NginxNetworkInterfaceConfiguration {
  /**
   * The subnet resource ID.
   */
  subnetId: string;
}

/**
 * Logging configuration for the deployment.
 */
model NginxLogging {
  /**
   * Storage account configuration.
   */
  storageAccount: NginxStorageAccount;
}

/**
 * Storage account configuration for logging.
 */
model NginxStorageAccount {
  /**
   * The storage account name.
   */
  accountName: string;

  /**
   * The container name.
   */
  containerName: string;
}

/**
 * Scaling properties for the deployment.
 */
model NginxDeploymentScalingProperties {
  /**
   * The capacity of the deployment.
   */
  capacity: int32;

  /**
   * Auto-scale settings.
   */
  autoScaleSettings: AutoScaleSettings;
}

/**
 * Auto-scale settings for the deployment.
 */
model AutoScaleSettings {
  /**
   * List of scale profiles.
   */
  profiles: ScaleProfile[];
}

/**
 * Scale profile for auto-scaling.
 */
model ScaleProfile {
  /**
   * The name of the scale profile.
   */
  name: string;

  /**
   * Capacity settings for the scale profile.
   */
  capacity: ScaleProfileCapacity;
}

/**
 * Capacity settings for a scale profile.
 */
model ScaleProfileCapacity {
  /**
   * Minimum capacity.
   */
  min: int32;

  /**
   * Maximum capacity.
   */
  max: int32;
}

/**
 * Auto-upgrade profile for the deployment.
 */
model AutoUpgradeProfile {
  /**
   * The upgrade channel.
   */
  upgradeChannel: string;
}

/**
 * User profile for the deployment.
 */
model NginxDeploymentUserProfile {
  /**
   * The preferred email address.
   */
  preferredEmail: string;
}

/**
 * Nginx App Protect configuration.
 */
model NginxAppProtect {
  /**
   * Web application firewall settings.
   */
  webApplicationFirewallSettings: WebApplicationFirewallSettings;

  /**
   * Web application firewall status.
   */
  webApplicationFirewallStatus: WebApplicationFirewallStatus;
}

/**
 * Web application firewall settings.
 */
model WebApplicationFirewallSettings {
  /**
   * The activation state of the WAF.
   */
  activationState: ActivationState;
}

/**
 * The activation state of the WAF.
 */
union ActivationState {
  /** WAF is enabled. */
  Enabled: "Enabled",

  /** WAF is disabled. */
  Disabled: "Disabled",

  /** Other activation states not covered by pre-defined values. */
  string,
}

/**
 * Web application firewall status.
 */
model WebApplicationFirewallStatus {
  /**
   * The WAF release version.
   */
  wafRelease: string;

  /**
   * Attack signatures package.
   */
  attackSignaturesPackage: WebApplicationFirewallPackage;

  /**
   * Bot signatures package.
   */
  botSignaturesPackage: WebApplicationFirewallPackage;

  /**
   * Threat campaigns package.
   */
  threatCampaignsPackage: WebApplicationFirewallPackage;

  /**
   * Component versions.
   */
  componentVersions: WebApplicationFirewallComponentVersions;
}

/**
 * Web application firewall package information.
 */
model WebApplicationFirewallPackage {
  /**
   * The package version.
   */
  version: string;

  /**
   * The revision datetime.
   */
  revisionDatetime: string;
}

/**
 * Component versions for the web application firewall.
 */
model WebApplicationFirewallComponentVersions {
  /**
   * WAF engine version.
   */
  wafEngineVersion: string;

  /**
   * WAF Nginx version.
   */
  wafNginxVersion: string;
}

/**
 * Patch properties for updating an Nginx deployment.
 */
model NginxDeploymentPatchProperties {
  /**
   * Whether diagnostics support is enabled.
   */
  enableDiagnosticsSupport: boolean;

  /**
   * Logging configuration.
   */
  logging: NginxLogging;

  /**
   * Scaling properties.
   */
  scalingProperties: NginxDeploymentScalingProperties;

  /**
   * User profile.
   */
  userProfile: NginxDeploymentUserProfile;

  /**
   * Network profile.
   */
  networkProfile: NginxNetworkProfile;

  /**
   * Auto-upgrade profile.
   */
  autoUpgradeProfile: AutoUpgradeProfile;

  /**
   * Nginx App Protect configuration.
   */
  nginxAppProtect: NginxAppProtect;
}

/**
 * Response model for listing default WAF policies.
 */
model NginxDeploymentDefaultWafPolicyListResponse {
  /**
   * List of default WAF policies.
   */
  @OpenAPI.extension("x-ms-identifiers", #["filepath"])
  value: NginxDeploymentDefaultWafPolicy[];

  /**
   * URL to fetch the next page of WAF policies.
   */
  nextLink?: string;
}

/**
 * Default WAF policy for a deployment.
 */
model NginxDeploymentDefaultWafPolicy {
  /**
   * The raw policy content, base64-encoded.
   */
  content: bytes;

  /**
   * The file path where this policy would be placed.
   */
  filepath: string;
}

/**
 * Represents a single tag for an Nginx deployment.
 */
model NginxDeploymentTag {
  /**
   * The tag name.
   */
  name: string;

  /**
   * The tag value.
   */
  value: string;
}

/**
 * Operations on Nginx deployments.
 */
@armResourceOperations
interface NginxDeployments {
  /**
   * Gets the properties of a specific Nginx deployment.
   */
  get is ArmResourceRead<NginxDeployment>;
  /**
   * Creates or updates an Nginx deployment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NginxDeployment>;
  /**
   * Updates an Nginx deployment with patch semantics.
   */
  update is ArmCustomPatchSync<
    NginxDeployment,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NginxDeployment,
      NginxDeploymentProperties
    >
  >;
  /**
   * Deletes a specific Nginx deployment.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NginxDeployment>;
  /**
   * Lists all Nginx deployments in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NginxDeployment>;
  /**
   * Lists all Nginx deployments in a subscription.
   */
  listBySubscription is ArmListBySubscription<NginxDeployment>;
  /**
   * Lists the default WAF policies for a deployment.
   */
  @post
  @segment("listDefaultWafPolicies")
  @armResourceCollectionAction
  listDefaultWafPolicies(
    ...ResourceInstanceParameters<NginxDeployment>,
  ): ArmResponse<NginxDeploymentDefaultWafPolicyListResponse> | ErrorResponse;
}
