import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Nginx.NginxPlus;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: NginxDeploymentApiKeyRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentApiKeyRequestProperties {
  /**
   * Secret text to be used as a Dataplane API Key. This is a write only property that can never be read back, but the first three characters will be returned in the 'hint' property.
   */
  @secret
  secretText?: string;

  /**
   * The time after which this Dataplane API Key is no longer valid.
   */
  endDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentApiKeyResponseProperties {
  /**
   * The first three characters of the secret text to help identify it in use. This property is read-only.
   */
  @visibility(Lifecycle.Read)
  hint?: string;

  /**
   * The time after which this Dataplane API Key is no longer valid.
   */
  endDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentApiKeyListResponse
  is Azure.Core.Page<NginxDeploymentApiKeyResponse>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxCertificateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  keyVaultSecretCreated?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificateError?: NginxCertificateErrorResponseBody;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxCertificateErrorResponseBody {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxCertificateListResponse is Azure.Core.Page<NginxCertificate>;

/**
 * Response of a list operation.
 */
model NginxConfigurationListResponse
  is Azure.Core.Page<NginxConfigurationResponse>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxConfigurationResponseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  files?: NginxConfigurationFile[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  protectedFiles?: NginxConfigurationProtectedFileResponse[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  package?: NginxConfigurationPackage;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rootFile?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxConfigurationFile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  content?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualPath?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxConfigurationPackage {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  data?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  protectedFiles?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: NginxConfigurationRequestProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxConfigurationRequestProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  files?: NginxConfigurationFile[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  protectedFiles?: NginxConfigurationProtectedFileRequest[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  package?: NginxConfigurationPackage;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rootFile?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  files?: NginxConfigurationFile[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  protectedFiles?: NginxConfigurationProtectedFileRequest[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IdentityProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tenantId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: IdentityType;

  /**
   * Dictionary of <UserIdentityProperties>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserIdentityProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  clientId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  nginxVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkProfile?: NginxNetworkProfile;

  /**
   * The IP address of the deployment.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableDiagnosticsSupport?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logging?: NginxLogging;

  /**
   * Information on how the deployment will be scaled.
   */
  scalingProperties?: NginxDeploymentScalingProperties;

  /**
   * Autoupgrade settings of a deployment.
   */
  autoUpgradeProfile?: AutoUpgradeProfile;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxNetworkProfile {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontEndIPConfiguration?: NginxFrontendIPConfiguration;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkInterfaceConfiguration?: NginxNetworkInterfaceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxFrontendIPConfiguration {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  publicIPAddresses?: NginxPublicIPAddress[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  privateIPAddresses?: NginxPrivateIPAddress[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxPublicIPAddress {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxPrivateIPAddress {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: NginxPrivateIPAllocationMethod;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxNetworkInterfaceConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxLogging {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccount?: NginxStorageAccount;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  autoScaleSettings?: NginxDeploymentScalingPropertiesAutoScaleSettings;
}

/**
 * The settings for enabling automatic scaling of the deployment. If this field is specified, 'scale.capacity' must be empty.
 */
model NginxDeploymentScalingPropertiesAutoScaleSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentUpdateParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: NginxDeploymentUpdateProperties;
}

/**
 * Represents the SKU of a resource.
 */
model ResourceSku {
  /**
   * The name of the SKU.
   */
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableDiagnosticsSupport?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logging?: NginxLogging;

  /**
   * Information on how the deployment will be scaled.
   */
  scalingProperties?: NginxDeploymentScalingProperties;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userProfile?: NginxDeploymentUserProfile;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkProfile?: NginxNetworkProfile;

  /**
   * Autoupgrade settings of a deployment.
   */
  autoUpgradeProfile?: AutoUpgradeProfile;

  /**
   * Update settings for NGINX App Protect (NAP)
   */
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NginxDeploymentListResponse is Azure.Core.Page<NginxDeployment>;

/**
 * Represents a paginated list of operations.
 */
@pagedResult
model OperationListResult {
  /**
   * [Placeholder] Description for value property.
   */
  @items
  value?: OperationResult[];

  /**
   * [Placeholder] Description for nextLink property.
   */
  @nextLink
  nextLink?: string;
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
/**
 * Represents the display information for an operation.
 */
model OperationDisplay {
  /**
   * The service provider of the operation.
   */
  provider?: string;

  /**
   * The resource type of the operation.
   */
  resource?: string;

  /**
   * The name of the operation.
   */
  operation?: string;

  /**
   * A description of the operation.
   */
  description?: string;
}
