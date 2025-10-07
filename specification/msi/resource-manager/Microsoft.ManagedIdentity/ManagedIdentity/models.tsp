import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.ManagedIdentity;

/**
 * Enum to configure regional restrictions on identity assignment, as necessary.
 */
union IsolationScope {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  Regional: "Regional",
  string,
}

/**
 * The properties associated with the system assigned identity.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@summary("System Assigned Identity properties.")
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * A list of additional details about the error.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the ManagedServiceIdentity service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
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

/**
 * Values returned by the List operation.
 */
model UserAssignedIdentitiesListResult is Azure.Core.Page<Identity>;

/**
 * The properties associated with the user assigned identity.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@summary("User Assigned Identity properties.")
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
model IdentityUpdate extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The properties associated with the identity.
   */
  properties?: UserAssignedIdentityProperties;
}

/**
 * Values returned by the List operation for federated identity credentials.
 */
model FederatedIdentityCredentialsListResult
  is Azure.Core.Page<FederatedIdentityCredential>;
@@extension(FederatedIdentityCredentialsListResult.value,
  "x-ms-identifiers",
  #["id"]
);

/**
 * The properties associated with a federated identity credential.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@summary("Federated identity credential properties.")
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
 * A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results.
 */
@summary("Operations List.")
model OperationListResult is Azure.Core.Page<Operation>;
@@summary(OperationListResult.value, "Operations List.");
@@summary(OperationListResult.nextLink, "Next Link");
@@extension(OperationListResult.value, "x-ms-identifiers", #["name"]);
/**
 * Details of a REST API operation, returned from the Resource Provider Operations API
 */
@summary("Microsoft.ManagedIdentity Operation.")
model Operation {
  /** 
    The name of the operation, as per Resource-Based Access Control (RBAC). Examples: "Microsoft.Compute/virtualMachines/write", "Microsoft.Compute/virtualMachines/capture/action"
     */
  @summary("Operation Name.")
  name?: string;

  /** Localized display information for this particular operation. */
  @summary("Operation Display.")
  display?: OperationDisplay;
}

/**
 * Localized display information for and operation.
 */
@summary("Operation Display.")
model OperationDisplay {
  /** 
  The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @summary("Resource Provider Name.")
  provider?: string;

  /** 
    The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
     */
  @summary("Operation Type.")
  operation?: string;

  /** 
    The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
     */
  @summary("Resource Type.")
  resource?: string;

  /** The short, localized friendly description of the operation; suitable for tool tips and detailed views. */
  @summary("Operation description")
  description?: string;
}
