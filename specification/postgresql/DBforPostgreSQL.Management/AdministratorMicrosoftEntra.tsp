import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Server administrator associated to a Microsoft Entra principal.
 */
@parentResource(Server)
model AdministratorMicrosoftEntra
  is Azure.ResourceManager.ProxyResource<
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
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all server administrators associated to a Microsoft Entra principal.
   */
  listByServer is ArmResourceListByParent<
    AdministratorMicrosoftEntra,
    Response = ArmResponse<AdministratorMicrosoftEntraList>
  >;
}

@@doc(AdministratorMicrosoftEntra.name,
  "Object identifier of the Microsoft Entra principal."
);
@@doc(AdministratorMicrosoftEntra.properties,
  "Properties of a server administrator associated to a Microsoft Entra principal."
);
@@doc(AdministratorMicrosoftEntras.createOrUpdate::parameters.resource,
  "Required parameters for adding a server administrator associated to a Microsoft Entra principal."
);
