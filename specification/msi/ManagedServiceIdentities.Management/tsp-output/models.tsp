import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ManagedServiceIdentityClient;

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("Describes a system assigned identity resource.")
model SystemAssignedIdentity {
  ...ProxyResource;

  @doc("The geo-location where the resource lives")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The properties associated with the identity.")
  @visibility("read")
  properties?: SystemAssignedIdentityProperties;
}

@doc("The properties associated with the system assigned identity.")
model SystemAssignedIdentityProperties {
  @doc("The id of the tenant which the identity belongs to.")
  @visibility("read")
  tenantId?: string;

  @doc("The id of the service principal object associated with the created identity.")
  @visibility("read")
  principalId?: string;

  @doc("""
The id of the app associated with the identity. This is a random generated UUID
by MSI.
""")
  @visibility("read")
  clientId?: string;

  @doc("""
 The ManagedServiceIdentity DataPlane URL that can be queried to obtain the
identity credentials.
""")
  @visibility("read")
  clientSecretUrl?: string;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. E.g.
\"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
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

  @doc("""
A message describing the error, intended to be suitable for display in a user
interface.
""")
  message?: string;

  @doc("""
The target of the particular error. For example, the name of the property in
error.
""")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("A list of operations supported by Microsoft.ManagedIdentity Resource Provider.")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("Operation supported by the Microsoft.ManagedIdentity REST API.")
model Operation {
  @doc("""
The name of the REST Operation. This is of the format
{provider}/{resource}/{operation}.
""")
  name?: string;

  @doc("The object that describes the operation.")
  display?: OperationDisplay;
}

@doc("The object that describes the operation.")
model OperationDisplay {
  @doc("Friendly name of the resource provider.")
  provider?: string;

  @doc("The type of operation. For example: read, write, delete.")
  operation?: string;

  @doc("The resource type on which the operation is performed.")
  resource?: string;

  @doc("A description of the operation.")
  description?: string;
}

@doc("Values returned by the List operation.")
model UserAssignedIdentitiesListResult is Azure.Core.Page<Identity>;

@doc("Describes an identity resource.")
model Identity {
  ...TrackedResource;

  @doc("The properties associated with the identity.")
  @visibility("read")
  properties?: UserAssignedIdentityProperties;
}

@doc("The properties associated with the user assigned identity.")
model UserAssignedIdentityProperties {
  @doc("The id of the tenant which the identity belongs to.")
  @visibility("read")
  tenantId?: string;

  @doc("The id of the service principal object associated with the created identity.")
  @visibility("read")
  principalId?: string;

  @doc("""
The id of the app associated with the identity. This is a random generated UUID
by MSI.
""")
  @visibility("read")
  clientId?: string;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("Describes an identity resource.")
model IdentityUpdate {
  ...Resource;

  @doc("The geo-location where the resource lives")
  location?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The properties associated with the identity.")
  @visibility("read")
  properties?: UserAssignedIdentityProperties;
}

@doc("Values returned by the List operation for federated identity credentials.")
model FederatedIdentityCredentialsListResult
  is Azure.Core.Page<FederatedIdentityCredential>;

@doc("Describes a federated identity credential.")
model FederatedIdentityCredential {
  ...ProxyResource;

  @doc("The properties associated with the federated identity credential.")
  properties?: FederatedIdentityCredentialProperties;
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
