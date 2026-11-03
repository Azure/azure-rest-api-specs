import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using TypeSpec.Versioning;

namespace Microsoft.DBforPostgreSQL;

/**
 * Type of Microsoft Entra principal to which the server administrator is associated.
 */
union PrincipalType {
  string,

  /**
   * Principal type is not known or not specified.
   */
  Unknown: "Unknown",

  /**
   * A Microsoft Entra user.
   */
  User: "User",

  /**
   * A Microsoft Entra group.
   */
  Group: "Group",

  /**
   * A Microsoft Entra service principal, typically representing an application or service identity.
   */
  ServicePrincipal: "ServicePrincipal",
}

/**
 * Server administrator associated to a Microsoft Entra principal.
 */
model AdministratorMicrosoftEntraAdd {
  /**
   * Properties of the server administrator associated to a Microsoft Entra principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AdministratorMicrosoftEntraPropertiesForAdd;
}

/**
 * Properties of a server administrator associated to a Microsoft Entra principal.
 */
model AdministratorMicrosoftEntraPropertiesForAdd {
  /**
   * Type of Microsoft Entra principal to which the server administrator is associated.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalType?: PrincipalType;

  /**
   * Name of the Microsoft Entra principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalName?: string;

  /**
   * Identifier of the tenant in which the Microsoft Entra principal exists.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tenantId?: string;
}

/**
 * Properties of a server administrator associated to a Microsoft Entra principal.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdministratorMicrosoftEntraProperties {
  /**
   * Type of Microsoft Entra principal to which the server administrator is associated.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalType?: PrincipalType;

  /**
   * Name of the Microsoft Entra principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalName?: string;

  /**
   * Object identifier of the Microsoft Entra principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  objectId?: string;

  /**
   * Identifier of the tenant in which the Microsoft Entra principal exists.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tenantId?: string;
}

/**
 * List of server administrators associated to Microsoft Entra principals.
 */
model AdministratorMicrosoftEntraList
  is Azure.Core.Page<AdministratorMicrosoftEntra>;

/**
 * Server administrator associated to a Microsoft Entra principal.
 */
@parentResource(Server)
model AdministratorMicrosoftEntra is Azure.ResourceManager.ProxyResource<
  AdministratorMicrosoftEntraProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AdministratorMicrosoftEntra,
    KeyName = "objectId",
    SegmentName = "administrators",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AdministratorMicrosoftEntras {
  /**
   * Gets information about a server administrator associated to a Microsoft Entra principal.
   */
  get is ArmResourceRead<AdministratorMicrosoftEntra>;

  /**
   * Creates a new server administrator associated to a Microsoft Entra principal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @put
  createOrUpdate is Legacy.CreateOrReplaceAsync<
    AdministratorMicrosoftEntra,
    Request = AdministratorMicrosoftEntraAdd,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = AdministratorMicrosoftEntra> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing server administrator associated to a Microsoft Entra principal.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AdministratorMicrosoftEntra,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * List all server administrators associated to a Microsoft Entra principal.
   */
  listByServer is ArmResourceListByParent<
    AdministratorMicrosoftEntra,
    Response = ArmResponse<AdministratorMicrosoftEntraList>
  >;
}

@@doc(
  AdministratorMicrosoftEntra.name,
  "Object identifier of the Microsoft Entra principal."
);
@@doc(
  AdministratorMicrosoftEntra.properties,
  "Properties of a server administrator associated to a Microsoft Entra principal."
);
@@doc(
  AdministratorMicrosoftEntras.createOrUpdate::parameters.resource,
  "Required parameters for adding a server administrator associated to a Microsoft Entra principal."
);
