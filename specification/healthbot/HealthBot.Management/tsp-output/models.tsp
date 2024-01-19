import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HealthBot;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The type of identity that creates/modifies resources")
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("The name of the Azure Health Bot SKU")
@fixed
enum SkuName {
  F0,
  S1,
  C0,
}

@doc("The identity type. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the Azure Health Bot")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the Azure Health Bot SKU")
  name: SkuName;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the Azure Health Bot")
  type?: ResourceIdentityType;

  @doc("""
The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.

""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("The properties of a Azure Health Bot. The Health Bot Service is a cloud platform that empowers developers in Healthcare organizations to build and deploy their compliant, AI-powered virtual health assistants and health bots, that help them improve processes and reduce costs.")
model HealthBotProperties {
  @doc("The provisioning state of the Azure Health Bot resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The link.")
  @visibility("read")
  botManagementPortalLink?: string;

  @doc("KeyVault properties for the resource encryption.")
  keyVaultProperties?: KeyVaultProperties;
}

@doc("Properties of the key vault.")
model KeyVaultProperties {
  @doc("The name of the key vault key.")
  keyName: string;

  @doc("The version of the key vault key.")
  keyVersion?: string;

  @doc("The Uri of the key vault.")
  keyVaultUri: string;

  @doc("The user assigned identity (ARM resource id) that has access to the key.")
  userIdentity?: string;
}

@doc("The resource model definition for a ARM tracked top level resource")
model Resource {
  @doc("Fully qualified resource Id for the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The resource management error response.")
@error
model Error {
  @doc("The error object.")
  error?: ErrorError;
}

@doc("The error object.")
model ErrorError {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: Error[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("Parameters for updating a Azure Health Bot.")
model HealthBotUpdateParameters {
  @doc("Properties of Azure Health Bot.")
  properties?: HealthBotProperties;

  @doc("Tags for a Azure Health Bot.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("SKU of the Azure Health Bot.")
  sku?: Sku;

  @doc("The identity of the Azure Health Bot.")
  identity?: Identity;

  @visibility("read", "create")
  location?: string;
}

@doc("Operation detail payload")
model OperationDetail {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Additional properties.")
  properties?: Record<unknown>;
}

@doc("The response returned from validation process")
model ValidationResult {
  @doc("The status code of the response validation.")
  status?: string;
}
