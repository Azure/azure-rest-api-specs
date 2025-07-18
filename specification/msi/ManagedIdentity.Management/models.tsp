import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedIdentity;

/**
 * Enum to configure regional restrictions on identity assignment, as necessary.
 */
union IsolationScope {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Regional: "Regional",
  string,
}

/**
 * The properties associated with the system assigned identity.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SystemAssignedIdentityProperties {
  /**
   * The id of the tenant which the identity belongs to.
   */
  @visibility(Lifecycle.Read)
  tenantId?: Azure.Core.uuid;

  /**
   * The id of the service principal object associated with the created identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The id of the app associated with the identity. This is a random generated UUID by MSI.
   */
  @visibility(Lifecycle.Read)
  clientId?: Azure.Core.uuid;

  /**
   *  The ManagedServiceIdentity DataPlane URL that can be queried to obtain the identity credentials.
   */
  @visibility(Lifecycle.Read)
  clientSecretUrl?: string;

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
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  details?: CloudErrorBody[];
}

@Azure.Core.pagedResult
@friendlyName("Paged{name}", Resource)
@doc("Paged collection of {name} items", Resource)
model Page<Resource extends TypeSpec.Reflection.Model> {
  @doc("The {name} items on this page", Resource)
  @Azure.Core.items
  value?: Resource[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Resource>;
}

/**
 * Values returned by the List operation.
 */
model UserAssignedIdentitiesListResult is Page<Identity>;

/**
 * The properties associated with the user assigned identity.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model UserAssignedIdentityProperties {
  /**
   * The id of the tenant which the identity belongs to.
   */
  @visibility(Lifecycle.Read)
  tenantId?: Azure.Core.uuid;

  /**
   * The id of the service principal object associated with the created identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The id of the app associated with the identity. This is a random generated UUID by MSI.
   */
  @visibility(Lifecycle.Read)
  clientId?: Azure.Core.uuid;

  /**
   * Enum to configure regional restrictions on identity assignment, as necessary.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isolationScope?: IsolationScope;
}

/**
 * Describes an identity resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IdentityUpdate extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The properties associated with the identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UserAssignedIdentityProperties;
}

/**
 * Values returned by the List operation for federated identity credentials.
 */
model FederatedIdentityCredentialsListResult
  is Azure.Core.Page<FederatedIdentityCredential>;

@@visibility(FederatedIdentityCredentialsListResult.value, Lifecycle.Read);

/**
 * The properties associated with a federated identity credential.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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

/**
 * The default resourceUri parameter type.
 */
@doc("The default resourceUri parameter type.")
model ScopeParameter {
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "template"
  @path(#{ allowReserved: true })
  @doc("The fully qualified Azure Resource manager identifier of the resource.")
  @Azure.ResourceManager.Private.resourceParameterBaseFor(
    [Azure.ResourceManager.CommonTypes.ResourceHome.Extension]
  )
  scope: string;
}

/**
 * Base parameters for a resource.
 * @template Resource The type of the resource.
 */
@Azure.ResourceManager.Private.resourceBaseParametersOf(Resource)
model ScopeParameters<Resource extends {}> {
  ...ApiVersionParameter;
  ...ScopeParameter;
}
