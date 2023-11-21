import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace HealthbotClient;

enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}
@Azure.Core.fixed
enum SkuName {
  F0,
  S1,
  C0,
}
@Azure.Core.fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("Azure Health Bot resource definition")
model HealthBot {
  ...TrackedResource;

  @doc("SKU of the Azure Health Bot.")
  sku: Sku;

  @doc("The identity of the Azure Health Bot.")
  identity?: Identity;

  @doc("The set of properties specific to Azure Health Bot resource.")
  properties?: HealthBotProperties;
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the Azure Health Bot SKU")
  name: SkuName;
}

@doc("Identity for the resource.")
model Identity {
  @doc("""
The principal ID of resource identity. This property will only be provided for
a system assigned identity.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
The tenant ID of resource. This property will only be provided for a system
assigned identity.
""")
  @visibility("read")
  tenantId?: string;

  @doc("""
The identity type. The type 'SystemAssigned, UserAssigned' includes both an
implicitly created identity and a set of user assigned identities. The type
'None' will remove any identities from the Azure Health Bot
""")
  type?: ResourceIdentityType;

  @doc("""
The list of user identities associated with the resource. The user identity
dictionary key references will be ARM resource ids in the
form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.

""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("""
The details of the user assigned managed identity used by the Video Analyzer
resource.
""")
model UserAssignedIdentity {
  @doc("The principal ID of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("""
The properties of a Azure Health Bot. The Health Bot Service is a cloud
platform that empowers developers in Healthcare organizations to build and
deploy their compliant, AI-powered virtual health assistants and health bots,
that help them improve processes and reduce costs.
""")
model HealthBotProperties {
  @doc("The provisioning state of the Azure Health Bot resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The link.")
  @visibility("read")
  botManagementPortalLink?: string;
}

@doc("The resource model definition for a ARM tracked top level resource")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
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

@doc("Read only system data")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource")
  createdByType?: IdentityType;

  @doc("The timestamp of resource creation (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource")
  lastModifiedByType?: IdentityType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
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

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("Parameters for updating a Azure Health Bot.")
model HealthBotUpdateParameters {
  @doc("Tags for a Azure Health Bot.")
  tags?: Record<string>;

  @doc("SKU of the Azure Health Bot.")
  sku?: Sku;

  @doc("The identity of the Azure Health Bot.")
  identity?: Identity;

  location?: string;
}

@doc("The list of Azure Health Bot operation response.")
model BotResponseList is Azure.Core.Page<HealthBot>;

@doc("Available operations of the service")
model AvailableOperations is Azure.Core.Page<OperationDetail>;

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
  properties?: unknown;
}

@doc("Operation display payload")
model OperationDisplay {
  @doc("Resource provider of the operation")
  provider?: string;

  @doc("Resource of the operation")
  resource?: string;

  @doc("Localized friendly name for the operation")
  operation?: string;

  @doc("Localized friendly description for the operation")
  description?: string;
}

@doc("The response returned from validation process")
model ValidationResult {
  @doc("The status code of the response validation.")
  status?: string;
}
