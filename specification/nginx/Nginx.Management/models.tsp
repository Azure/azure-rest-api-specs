import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Nginx.NginxPlus;

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
 * Provisioning State
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
}

/**
 * Warning or Info
 */
union Level {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Info: "Info",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
}

/**
 * Identity Type
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Nginx Private IP Allocation Method
 */
union NginxPrivateIPAllocationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Static: "Static",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dynamic: "Dynamic",
}

/**
 * The activation state of the WAF. Use 'Enabled' to enable the WAF and 'Disabled' to disable it.
 */
union ActivationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Machine readable code indicating the compilation status of a WAF Policy.
 */
union NginxDeploymentWafPolicyCompilingStatusCode {
  string,

  /**
   * The compilation of the custom waf policy has not started
   */
  NotStarted: "NotStarted",

  /**
   * The compilation of the custom waf policy is in progress
   */
  InProgress: "InProgress",

  /**
   * The compilation of the custom waf policy is completed successfully and can now be referenced in the nginx config.
   */
  Succeeded: "Succeeded",

  /**
   * The compilation of the custom waf policy failed.
   */
  Failed: "Failed",
}

/**
 * Machine readable code indicating the applying status code of a WAF Policy.
 */
union NginxDeploymentWafPolicyApplyingStatusCode {
  string,

  /**
   * The policy is not referenced in the nginx config and not applied.
   */
  NotApplied: "NotApplied",

  /**
   * The policy is referenced in the nginx config and is applying.
   */
  Applying: "Applying",

  /**
   * The policy is referenced in the nginx config and that config has been successfully applied.
   */
  Succeeded: "Succeeded",

  /**
   * The policy is referenced in the nginx config and that config failed to apply.
   */
  Failed: "Failed",

  /**
   * The policy is now not referenced in the nginx config and its being removed from the applied nginx config.
   */
  Removing: "Removing",
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
 * Nginx Deployment Api Key Request
 */
model NginxDeploymentApiKeyRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Nginx Deployment Api Key Request Properties
   */
  properties?: NginxDeploymentApiKeyRequestProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Nginx Deployment Api Key Request Properties
 */
model NginxDeploymentApiKeyRequestProperties {
  /**
   * Secret text to be used as a Dataplane API Key. This is a write only property that can never be read back, but the first three characters will be returned in the 'hint' property.
   */
  @secret
  secretText?: string;

  /**
   * The time after which this Dataplane API Key is no longer valid.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;
}

/**
 * Nginx Deployment Api Key Response Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentApiKeyResponseProperties {
  /**
   * The first three characters of the secret text to help identify it in use. This property is read-only.
   */
  @visibility(Lifecycle.Read)
  hint?: string;

  /**
   * The time after which this Dataplane API Key is no longer valid.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;
}

/**
 * Nginx Deployment Api Key List Response
 */
model NginxDeploymentApiKeyListResponse
  is Azure.Core.Page<NginxDeploymentApiKeyResponse>;

/**
 * Nginx Certificate Properties
 */
model NginxCertificateProperties {
  /**
   * Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVirtualPath?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificateVirtualPath?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultSecretId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sha1Thumbprint?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  keyVaultSecretVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  keyVaultSecretCreated?: utcDateTime;

  /**
   * Nginx Certificate Error Response Body
   */
  certificateError?: NginxCertificateErrorResponseBody;
}

/**
 * Nginx Certificate Error Response Body
 */
model NginxCertificateErrorResponseBody {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message?: string;
}

/**
 * Nginx Certificate List Response
 */
model NginxCertificateListResponse is Azure.Core.Page<NginxCertificate>;

/**
 * Response of a list operation.
 */
model NginxConfigurationListResponse
  is Azure.Core.Page<NginxConfigurationResponse>;

/**
 * Nginx Configuration Response Properties
 */
model NginxConfigurationResponseProperties {
  /**
   * Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  files?: NginxConfigurationFile[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  protectedFiles?: NginxConfigurationProtectedFileResponse[];

  /**
   * Nginx Configuration Package
   */
  package?: NginxConfigurationPackage;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rootFile?: string;
}

/**
 * Nginx Configuration File
 */
model NginxConfigurationFile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  content?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualPath?: string;
}

/**
 * Nginx Configuration Protected File Response
 */
model NginxConfigurationProtectedFileResponse {
  /**
   * The virtual path of the protected file.
   */
  virtualPath?: string;

  /**
   * The hash of the content of the file. This value is used to determine if the file has changed.
   */
  contentHash?: string;
}

/**
 * Nginx Configuration Package
 */
model NginxConfigurationPackage {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  data?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedFiles?: string[];
}

/**
 * Nginx Configuration Request
 */
model NginxConfigurationRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Nginx Configuration Request Properties
   */
  properties?: NginxConfigurationRequestProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Nginx Configuration Request Properties
 */
model NginxConfigurationRequestProperties {
  /**
   * Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  files?: NginxConfigurationFile[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  protectedFiles?: NginxConfigurationProtectedFileRequest[];

  /**
   * Nginx Configuration Package
   */
  package?: NginxConfigurationPackage;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rootFile?: string;
}

/**
 * Nginx Configuration Protected File Request
 */
model NginxConfigurationProtectedFileRequest {
  /**
   * The content of the protected file. This value is a PUT only value. If you perform a GET request on this value, it will be empty because it is a protected file.
   */
  @secret
  content?: string;

  /**
   * The virtual path of the protected file.
   */
  virtualPath?: string;

  /**
   * The hash of the content of the file. This value is used to determine if the file has changed.
   */
  contentHash?: string;
}

/**
 * The request body for creating an analysis for an NGINX configuration.
 */
model AnalysisCreate {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  config: AnalysisCreateConfig;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AnalysisCreateConfig {
  /**
   * The root file of the NGINX config file(s). It must match one of the files' filepath.
   */
  rootFile?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  files?: NginxConfigurationFile[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  protectedFiles?: NginxConfigurationProtectedFileRequest[];

  /**
   * Nginx Configuration Package
   */
  package?: NginxConfigurationPackage;
}

/**
 * The response body for an analysis request. Contains the status of the analysis and any errors.
 */
model AnalysisResult {
  /**
   * The status of the analysis.
   */
  status: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  data?: AnalysisResultData;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AnalysisResultData {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errors?: AnalysisDiagnostic[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diagnostics?: DiagnosticItem[];
}

/**
 * An error object found during the analysis of an NGINX configuration.
 */
model AnalysisDiagnostic {
  /**
   * Unique identifier for the error
   */
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  directive: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description: string;

  /**
   * the filepath of the most relevant config file
   */
  file: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  line: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rule: string;
}

/**
 * A diagnostic is a message associated with an NGINX config. The Analyzer returns diagnostics with a level indicating the importance of the diagnostic with optional category.
 */
model DiagnosticItem {
  /**
   * Unique identifier for the diagnostic.
   */
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  directive: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description: string;

  /**
   * The filepath of the most relevant config file.
   */
  file: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  line: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rule: string;

  /**
   * Warning or Info
   */
  level: Level;

  /**
   * Category of warning like Best-practices, Recommendation, Security etc.
   */
  category?: string;
}

/**
 * Identity Properties
 */
model IdentityProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Identity Type
   */
  type?: IdentityType;

  /**
   * Dictionary of <UserIdentityProperties>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

/**
 * User Identity Properties
 */
model UserIdentityProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Nginx Deployment Properties
 */
model NginxDeploymentProperties {
  /**
   * Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  nginxVersion?: string;

  /**
   * Nginx Network Profile
   */
  networkProfile?: NginxNetworkProfile;

  /**
   * The IP address of the deployment.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableDiagnosticsSupport?: boolean;

  /**
   * Nginx Logging
   */
  logging?: NginxLogging;

  /**
   * Information on how the deployment will be scaled.
   */
  scalingProperties?: NginxDeploymentScalingProperties;

  /**
   * Autoupgrade settings of a deployment.
   */
  autoUpgradeProfile?: AutoUpgradeProfile;

  /**
   * Nginx Deployment User Profile
   */
  userProfile?: NginxDeploymentUserProfile;

  /**
   * Settings for NGINX App Protect (NAP)
   */
  nginxAppProtect?: NginxDeploymentPropertiesNginxAppProtect;

  /**
   * Dataplane API endpoint for the caller to update the NGINX state of the deployment.
   */
  @visibility(Lifecycle.Read)
  dataplaneApiEndpoint?: string;
}

/**
 * Nginx Network Profile
 */
model NginxNetworkProfile {
  /**
   * Nginx Frontend IP Configuration
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontEndIPConfiguration?: NginxFrontendIPConfiguration;

  /**
   * Nginx Network Interface Configuration
   */
  networkInterfaceConfiguration?: NginxNetworkInterfaceConfiguration;
}

/**
 * Nginx Frontend IP Configuration
 */
model NginxFrontendIPConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  publicIPAddresses?: NginxPublicIPAddress[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  privateIPAddresses?: NginxPrivateIPAddress[];
}

/**
 * Nginx Public IP Address
 */
model NginxPublicIPAddress {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;
}

/**
 * Nginx Private IP Address
 */
model NginxPrivateIPAddress {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;

  /**
   * Nginx Private IP Allocation Method
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: NginxPrivateIPAllocationMethod;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnetId?: string;
}

/**
 * Nginx Network Interface Configuration
 */
model NginxNetworkInterfaceConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnetId?: string;
}

/**
 * Nginx Logging
 */
model NginxLogging {
  /**
   * Nginx Storage Account
   */
  storageAccount?: NginxStorageAccount;
}

/**
 * Nginx Storage Account
 */
model NginxStorageAccount {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerName?: string;
}

/**
 * Information on how the deployment will be scaled.
 */
model NginxDeploymentScalingProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capacity?: int32;

  /**
   * The settings for enabling automatic scaling of the deployment. If this field is specified, 'scale.capacity' must be empty.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  autoScaleSettings?: NginxDeploymentScalingPropertiesAutoScaleSettings;
}

/**
 * The settings for enabling automatic scaling of the deployment. If this field is specified, 'scale.capacity' must be empty.
 */
model NginxDeploymentScalingPropertiesAutoScaleSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  profiles: ScaleProfile[];
}

/**
 * The autoscale profile.
 */
model ScaleProfile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name: string;

  /**
   * The capacity parameters of the profile.
   */
  capacity: ScaleProfileCapacity;
}

/**
 * The capacity parameters of the profile.
 */
model ScaleProfileCapacity {
  /**
   * The minimum number of NCUs the deployment can be autoscaled to.
   */
  min: int32;

  /**
   * The maximum number of NCUs the deployment can be autoscaled to.
   */
  max: int32;
}

/**
 * Autoupgrade settings of a deployment.
 */
model AutoUpgradeProfile {
  /**
   * Channel used for autoupgrade.
   */
  upgradeChannel: string;
}

/**
 * Nginx Deployment User Profile
 */
model NginxDeploymentUserProfile {
  /**
   * The preferred support contact email address of the user used for sending alerts and notification. Can be an empty string or a valid email address.
   */
  @pattern("^$|^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  preferredEmail?: string;
}

/**
 * Settings for NGINX App Protect (NAP)
 */
model NginxDeploymentPropertiesNginxAppProtect {
  /**
   * Settings for the NGINX App Protect Web Application Firewall (WAF)
   */
  webApplicationFirewallSettings: WebApplicationFirewallSettings;

  /**
   * The status of the NGINX App Protect Web Application Firewall
   */
  @visibility(Lifecycle.Read)
  webApplicationFirewallStatus?: WebApplicationFirewallStatus;
}

/**
 * Settings for the NGINX App Protect Web Application Firewall (WAF)
 */
model WebApplicationFirewallSettings {
  /**
   * The activation state of the WAF. Use 'Enabled' to enable the WAF and 'Disabled' to disable it.
   */
  activationState?: ActivationState;
}

/**
 * The status of the NGINX App Protect Web Application Firewall
 */
model WebApplicationFirewallStatus {
  /**
   * NGINX App Protect WAF release version
   */
  wafRelease?: string;

  /**
   * Package containing attack signatures for the NGINX App Protect Web Application Firewall (WAF).
   */
  @visibility(Lifecycle.Read)
  attackSignaturesPackage?: WebApplicationFirewallPackage;

  /**
   * Package containing bot signatures for the NGINX App Protect Web Application Firewall (WAF).
   */
  @visibility(Lifecycle.Read)
  botSignaturesPackage?: WebApplicationFirewallPackage;

  /**
   * Package containing threat campaigns for the NGINX App Protect Web Application Firewall (WAF).
   */
  @visibility(Lifecycle.Read)
  threatCampaignsPackage?: WebApplicationFirewallPackage;

  /**
   * Versions of the NGINX App Protect Web Application Firewall (WAF) components.
   */
  @visibility(Lifecycle.Read)
  componentVersions?: WebApplicationFirewallComponentVersions;
}

/**
 * NGINX App Protect Web Application Firewall (WAF) Package. Contains the version and revision date of the package.
 */
model WebApplicationFirewallPackage {
  /**
   * The version of the NGINX App Protect Web Application Firewall (WAF) package.
   */
  version: string;

  /**
   * The date and time of the package revision.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  revisionDatetime: utcDateTime;
}

/**
 * Versions of the NGINX App Protect Web Application Firewall (WAF) components.
 */
model WebApplicationFirewallComponentVersions {
  /**
   * The version of the NGINX App Protect Web Application Firewall (WAF) engine.
   */
  wafEngineVersion: string;

  /**
   * The version of the NGINX App Protect Web Application Firewall (WAF) module for NGINX.
   */
  wafNginxVersion: string;
}

/**
 * Resource Sku
 */
model ResourceSku {
  /**
   * Name of the SKU.
   */
  name: string;
}

/**
 * Nginx Deployment Update Parameters
 */
model NginxDeploymentUpdateParameters {
  /**
   * Identity Properties
   */
  identity?: IdentityProperties;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Resource Sku
   */
  sku?: ResourceSku;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Nginx Deployment Update Properties
   */
  properties?: NginxDeploymentUpdateProperties;
}

/**
 * Nginx Deployment Update Properties
 */
model NginxDeploymentUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableDiagnosticsSupport?: boolean;

  /**
   * Nginx Logging
   */
  logging?: NginxLogging;

  /**
   * Information on how the deployment will be scaled.
   */
  scalingProperties?: NginxDeploymentScalingProperties;

  /**
   * Nginx Deployment User Profile
   */
  userProfile?: NginxDeploymentUserProfile;

  /**
   * Nginx Network Profile
   */
  networkProfile?: NginxNetworkProfile;

  /**
   * Autoupgrade settings of a deployment.
   */
  autoUpgradeProfile?: AutoUpgradeProfile;

  /**
   * Update settings for NGINX App Protect (NAP)
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  nginxAppProtect?: NginxDeploymentUpdatePropertiesNginxAppProtect;
}

/**
 * Update settings for NGINX App Protect (NAP)
 */
model NginxDeploymentUpdatePropertiesNginxAppProtect {
  /**
   * Settings for the NGINX App Protect Web Application Firewall (WAF)
   */
  webApplicationFirewallSettings?: WebApplicationFirewallSettings;
}

/**
 * Nginx Deployment List Response
 */
model NginxDeploymentListResponse is Azure.Core.Page<NginxDeployment>;

/**
 * Nginx Deployment Waf Policy Properties
 */
model NginxDeploymentWafPolicyProperties {
  /**
   * Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The byte content of the Policy
   */
  content?: bytes;

  /**
   * The file path where the Policy is to be saved
   */
  filepath?: string;

  /**
   * Nginx Deployment Waf Policy Compiling Status
   */
  @visibility(Lifecycle.Read)
  compilingState?: NginxDeploymentWafPolicyCompilingStatus;

  /**
   * Nginx Deployment Waf Policy Applying Status
   */
  @visibility(Lifecycle.Read)
  applyingState?: NginxDeploymentWafPolicyApplyingStatus;
}

/**
 * Nginx Deployment Waf Policy Compiling Status
 */
model NginxDeploymentWafPolicyCompilingStatus {
  /**
   * Machine readable code indicating the compilation status of a WAF Policy.
   */
  @visibility(Lifecycle.Read)
  code?: NginxDeploymentWafPolicyCompilingStatusCode;

  /**
   * A readable string of the current status, and sometimes have the reason for the current state. If the CompilingStatus is Failed the Display Status will be The waf Policy failed to compile.
   */
  @visibility(Lifecycle.Read)
  displayStatus?: string;

  /**
   * The date and time the policy was compiled in UTC.
   */
  @visibility(Lifecycle.Read)
  time?: string;
}

/**
 * Nginx Deployment Waf Policy Applying Status
 */
model NginxDeploymentWafPolicyApplyingStatus {
  /**
   * Machine readable code indicating the applying status code of a WAF Policy.
   */
  @visibility(Lifecycle.Read)
  code?: NginxDeploymentWafPolicyApplyingStatusCode;

  /**
   * A readable string of the current status, and sometimes have the reason for the current state.
   */
  @visibility(Lifecycle.Read)
  displayStatus?: string;

  /**
   * The date and time in UTC the current applying status was set.
   */
  @visibility(Lifecycle.Read)
  time?: string;
}

/**
 * Nginx Deployment Default Waf Policy List Response
 */
model NginxDeploymentDefaultWafPolicyListResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  value?: NginxDeploymentDefaultWafPolicyProperties[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nextLink?: string;
}

/**
 * Nginx Deployment Default Waf Policy Properties
 */
model NginxDeploymentDefaultWafPolicyProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  content?: bytes;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  filepath?: string;
}

/**
 * Nginx Deployment Waf Policy List Response
 */
model NginxDeploymentWafPolicyListResponse
  is Azure.Core.Page<NginxDeploymentWafPolicyMetadata>;

/**
 * Nginx Deployment Waf Policy Metadata
 */
model NginxDeploymentWafPolicyMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Nginx Deployment Waf Policy Metadata Properties
   */
  properties?: NginxDeploymentWafPolicyMetadataProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Nginx Deployment Waf Policy Metadata Properties
 */
model NginxDeploymentWafPolicyMetadataProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  filepath?: string;

  /**
   * Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Nginx Deployment Waf Policy Compiling Status
   */
  @visibility(Lifecycle.Read)
  compilingState?: NginxDeploymentWafPolicyCompilingStatus;

  /**
   * Nginx Deployment Waf Policy Applying Status
   */
  @visibility(Lifecycle.Read)
  applyingState?: NginxDeploymentWafPolicyApplyingStatus;
}

/**
 * Nginx Deployment Waf Policy Error
 */
@added(Versions.v2025_11_01)
model NginxDeploymentWafPolicyError {
  /**
   * Error code
   */
  code?: string;

  /**
   * Field that caused the error
   */
  field?: string;

  /**
   * Error message
   */
  message?: string;
}

/**
 * Nginx Deployment Waf Policy Analysis Create Request
 */
@added(Versions.v2025_11_01)
model NginxDeploymentWafPolicyAnalysisCreateRequest {
  /**
   * The byte content of the policy
   */
  content?: bytes;

  /**
   * The absolute file path of the policy as in the virtual machine
   */
  filepath?: string;
}

/**
 * Nginx Deployment Waf Policy Analysis Data
 */
@added(Versions.v2025_11_01)
model NginxDeploymentWafPolicyAnalysisData {
  /**
   * List of errors found during analysis
   */
  @identifiers(#[])
  errors?: NginxDeploymentWafPolicyError[];
}

/**
 * Nginx Deployment Waf Policy Analysis Response
 */
@added(Versions.v2025_11_01)
model NginxDeploymentWafPolicyAnalysisResponse {
  /**
   * The status of the analysis. The possible values can be arbitrary
   */
  status?: string;

  /**
   * The analysis data containing errors
   */
  data?: NginxDeploymentWafPolicyAnalysisData;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Nginx.NginxPlus
   */
  provider?: string;

  /**
   * Type on which the operation is performed, e.g., 'deployments'.
   */
  resource?: string;

  /**
   * Operation type, e.g., read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation, e.g., 'Write deployments'.
   */
  description?: string;
}

/**
 * A Nginx.NginxPlus REST API operation.
 */
model OperationResult {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}
