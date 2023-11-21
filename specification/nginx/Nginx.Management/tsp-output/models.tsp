import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace NginxManagementClient;

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

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
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

model NginxCertificate {
  @visibility("read")
  id?: string;

  @visibility("read")
  name?: string;

  @visibility("read")
  type?: string;

  properties?: NginxCertificateProperties;

  @doc("Dictionary of <string>")
  tags?: Record<string>;

  location?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

model NginxCertificateProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  keyVirtualPath?: string;
  certificateVirtualPath?: string;
  keyVaultSecretId?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
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

model NginxCertificateListResponse is Azure.Core.Page<NginxCertificate>;

@doc("Response of a list operation.")
model NginxConfigurationListResponse is Azure.Core.Page<NginxConfiguration>;

model NginxConfiguration {
  @visibility("read")
  id?: string;

  @visibility("read")
  name?: string;

  @visibility("read")
  type?: string;

  properties?: NginxConfigurationProperties;

  @doc("Dictionary of <string>")
  tags?: Record<string>;

  location?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
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
}

model NginxDeployment {
  @visibility("read")
  id?: string;

  @visibility("read")
  name?: string;

  @visibility("read")
  type?: string;

  identity?: IdentityProperties;
  properties?: NginxDeploymentProperties;

  @doc("Dictionary of <string>")
  tags?: Record<string>;

  sku?: ResourceSku;
  location?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

model IdentityProperties {
  @visibility("read")
  principalId?: string;

  @visibility("read")
  tenantId?: string;

  type?: IdentityType;

  @doc("Dictionary of <UserIdentityProperties>")
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

  @doc("The managed resource group to deploy VNet injection related network resources.")
  managedResourceGroup?: string;

  networkProfile?: NginxNetworkProfile;

  @doc("The IP address of the deployment.")
  @visibility("read")
  ipAddress?: string;

  enableDiagnosticsSupport?: boolean;
  logging?: NginxLogging;
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

model ResourceSku {
  @doc("Name of the SKU.")
  name: string;
}

model NginxDeploymentUpdateParameters {
  identity?: IdentityProperties;

  @doc("Dictionary of <string>")
  tags?: Record<string>;

  sku?: ResourceSku;
  location?: string;
  properties?: NginxDeploymentUpdateProperties;
}

model NginxDeploymentUpdateProperties {
  enableDiagnosticsSupport?: boolean;
  logging?: NginxLogging;
}

model NginxDeploymentListResponse is Azure.Core.Page<NginxDeployment>;

@doc("Result of GET request to list Nginx.NginxPlus operations.")
model OperationListResult is Azure.Core.Page<OperationResult>;

@doc("A Nginx.NginxPlus REST API operation.")
model OperationResult {
  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;
}

@doc("The object that represents the operation.")
model OperationDisplay {
  @doc("Service provider: Nginx.NginxPlus")
  provider?: string;

  @doc("Type on which the operation is performed, e.g., 'deployments'.")
  resource?: string;

  @doc("Operation type, e.g., read, write, delete, etc.")
  operation?: string;

  @doc("Description of the operation, e.g., 'Write deployments'.")
  description?: string;
}
