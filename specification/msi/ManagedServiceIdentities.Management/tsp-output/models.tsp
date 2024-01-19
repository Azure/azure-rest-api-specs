import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedIdentity;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The properties associated with the system assigned identity.")
model SystemAssignedIdentityProperties {
  @doc("The id of the tenant which the identity belongs to.")
  @visibility("read")
  tenantId?: string;

  @doc("The id of the service principal object associated with the created identity.")
  @visibility("read")
  principalId?: string;

  @doc("The id of the app associated with the identity. This is a random generated UUID by MSI.")
  @visibility("read")
  clientId?: string;

  @doc(" The ManagedServiceIdentity DataPlane URL that can be queried to obtain the identity credentials.")
  @visibility("read")
  clientSecretUrl?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("An error response from the ManagedServiceIdentity service.")
@error
model CloudError {
  @doc("A list of additional details about the error.")
  error?: CloudErrorBody;
}

@doc("An error response from the ManagedServiceIdentity service.")
model CloudErrorBody {
  @doc("An identifier for the error.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("The properties associated with the user assigned identity.")
model UserAssignedIdentityProperties {
  @doc("The id of the tenant which the identity belongs to.")
  @visibility("read")
  tenantId?: string;

  @doc("The id of the service principal object associated with the created identity.")
  @visibility("read")
  principalId?: string;

  @doc("The id of the app associated with the identity. This is a random generated UUID by MSI.")
  @visibility("read")
  clientId?: string;
}

@doc("Describes an identity resource.")
model IdentityUpdate extends Resource {
  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location?: string;

  @doc("Resource tags")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("The properties associated with the identity.")
  @visibility("read")
  properties?: UserAssignedIdentityProperties;
}

@doc("The properties associated with a federated identity credential.")
model FederatedIdentityCredentialProperties {
  @doc("The URL of the issuer to be trusted.")
  issuer: string;

  @doc("The identifier of the external identity.")
  subject: string;

  @doc("The list of audiences that can appear in the issued token.")
  audiences: string[];
}
