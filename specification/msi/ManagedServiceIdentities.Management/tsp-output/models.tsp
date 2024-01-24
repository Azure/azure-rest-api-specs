import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedIdentity;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The properties associated with the system assigned identity.
 */
model SystemAssignedIdentityProperties {
  /**
   * The id of the tenant which the identity belongs to.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The id of the service principal object associated with the created identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The id of the app associated with the identity. This is a random generated UUID by MSI.
   */
  @visibility("read")
  clientId?: string;

  /**
   *  The ManagedServiceIdentity DataPlane URL that can be queried to obtain the identity credentials.
   */
  @visibility("read")
  clientSecretUrl?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * An error response from the ManagedServiceIdentity service.
 */
@error
model CloudError {
  /**
   * A list of additional details about the error.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the ManagedServiceIdentity service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
}

/**
 * The properties associated with the user assigned identity.
 */
model UserAssignedIdentityProperties {
  /**
   * The id of the tenant which the identity belongs to.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The id of the service principal object associated with the created identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The id of the app associated with the identity. This is a random generated UUID by MSI.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Describes an identity resource.
 */
model IdentityUpdate extends Resource {
  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Resource tags
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The properties associated with the identity.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: UserAssignedIdentityProperties;
}

/**
 * The properties associated with a federated identity credential.
 */
model FederatedIdentityCredentialProperties {
  /**
   * The URL of the issuer to be trusted.
   */
  issuer: url;

  /**
   * The identifier of the external identity.
   */
  subject: string;

  /**
   * The list of audiences that can appear in the issued token.
   */
  audiences: string[];
}
