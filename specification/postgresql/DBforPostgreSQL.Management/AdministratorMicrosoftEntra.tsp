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
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @put
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
  delete is ArmResourceDeleteWithoutOkAsync<AdministratorMicrosoftEntra>;

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
