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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdministratorsMicrosoftEntra_Get")
  get is ArmResourceRead<AdministratorMicrosoftEntra>;

  /**
   * Creates a new server administrator associated to a Microsoft Entra principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @put
  @operationId("AdministratorsMicrosoftEntra_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      AdministratorMicrosoftEntra,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<AdministratorMicrosoftEntra>
    >,
    AdministratorMicrosoftEntraAdd,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    ErrorResponse = ErrorResponse
  >;

  /**
   * Deletes an existing server administrator associated to a Microsoft Entra principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdministratorsMicrosoftEntra_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<AdministratorMicrosoftEntra>;

  /**
   * List all server administrators associated to a Microsoft Entra principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdministratorsMicrosoftEntra_ListByServer")
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
