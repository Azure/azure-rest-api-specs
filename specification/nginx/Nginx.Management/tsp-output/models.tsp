import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Nginx.NginxPlus;

interface Operations extends Azure.ResourceManager.Operations {}

enum ProvisioningState {
  Accepted,
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  NotSpecified,
}

enum IdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

enum NginxPrivateIPAllocationMethod {
  Static,
  Dynamic,
}

model NginxCertificateProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  keyVirtualPath?: string;
  certificateVirtualPath?: string;
  keyVaultSecretId?: string;
}

@error
model ResourceProviderDefaultErrorResponse {
  error?: ErrorResponseBody;
}

model ErrorResponseBody {
  code?: string;
  message?: string;
  target?: string;
  details?: ErrorResponseBody[];
}

model NginxConfigurationProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  files?: NginxConfigurationFile[];
  protectedFiles?: NginxConfigurationFile[];
  package?: NginxConfigurationPackage;
  rootFile?: string;
}

model NginxConfigurationFile {
  content?: string;
  virtualPath?: string;
}

model NginxConfigurationPackage {
  data?: string;
  protectedFiles?: string[];
}

model IdentityProperties {
  @visibility("read")
  principalId?: string;

  @visibility("read")
  tenantId?: string;

  type?: IdentityType;

  /**
   * Dictionary of <UserIdentityProperties>
   */
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

model UserIdentityProperties {
  @visibility("read")
  principalId?: string;

  @visibility("read")
  clientId?: string;
}

model NginxDeploymentProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  @visibility("read")
  nginxVersion?: string;

  /**
   * The managed resource group to deploy VNet injection related network resources.
   */
  managedResourceGroup?: string;

  networkProfile?: NginxNetworkProfile;

  /**
   * The IP address of the deployment.
   */
  @visibility("read")
  ipAddress?: string;

  enableDiagnosticsSupport?: boolean;
  logging?: NginxLogging;
  scalingProperties?: NginxDeploymentScalingProperties;
  userProfile?: NginxDeploymentUserProfile;
}

model NginxNetworkProfile {
  frontEndIPConfiguration?: NginxFrontendIPConfiguration;
  networkInterfaceConfiguration?: NginxNetworkInterfaceConfiguration;
}

model NginxFrontendIPConfiguration {
  publicIPAddresses?: NginxPublicIPAddress[];
  privateIPAddresses?: NginxPrivateIPAddress[];
}

model NginxPublicIPAddress {
  id?: string;
}

model NginxPrivateIPAddress {
  privateIPAddress?: string;
  privateIPAllocationMethod?: NginxPrivateIPAllocationMethod;
  subnetId?: string;
}

model NginxNetworkInterfaceConfiguration {
  subnetId?: string;
}

model NginxLogging {
  storageAccount?: NginxStorageAccount;
}

model NginxStorageAccount {
  accountName?: string;
  containerName?: string;
}

model NginxDeploymentScalingProperties {
  capacity?: int32;
}

model NginxDeploymentUserProfile {
  /**
   * The preferred support contact email address of the user used for sending alerts and notification. Can be an empty string or a valid email address.
   */
  @pattern("^$|^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  preferredEmail?: string;
}

model NginxDeploymentUpdateParameters {
  identity?: IdentityProperties;

  /**
   * Dictionary of <string>
   */
  tags?: Record<string>;

  sku?: ResourceSku;
  location?: string;
  properties?: NginxDeploymentUpdateProperties;
}

model NginxDeploymentUpdateProperties {
  enableDiagnosticsSupport?: boolean;
  logging?: NginxLogging;
  scalingProperties?: NginxDeploymentScalingProperties;
  userProfile?: NginxDeploymentUserProfile;
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
