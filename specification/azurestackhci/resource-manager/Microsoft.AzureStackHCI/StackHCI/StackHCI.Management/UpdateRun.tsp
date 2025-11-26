import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Update.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of an Update run
 */
@parentResource(Update)
model UpdateRun is Azure.ResourceManager.ProxyResource<UpdateRunProperties> {
  ...ResourceNameParameter<
    Resource = UpdateRun,
    KeyName = "updateRunName",
    SegmentName = "updateRuns",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface UpdateRuns {
  /**
   * Get the Update run for a specified update
   */
  get is ArmResourceRead<UpdateRun>;

  /**
   * Put Update runs for a specified update
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    UpdateRun,
    Response = ArmResourceUpdatedResponse<UpdateRun>
  >;

  /**
   * Delete specified Update Run
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    UpdateRun,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Update runs for a specified update
   */
  list is ArmResourceListByParent<
    UpdateRun,
    Response = ArmResponse<UpdateRunList>
  >;
}

@@doc(UpdateRun.name, "The name of the Update Run");
@@doc(UpdateRun.properties, "Describes Update Run Properties.");
@@doc(UpdateRuns.put::parameters.resource,
  "Properties of the updateRuns object"
);
