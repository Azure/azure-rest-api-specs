import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Update.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of an Update run
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Update)
@Azure.ResourceManager.Private.armResourceInternal(UpdateRunProperties)
@includeInapplicableMetadataInPayload(false)
model UpdateRun extends ProxyResourceBase {
  /**
   * The name of the Update Run
   */
  @path
  @key("updateRunName")
  @segment("updateRuns")
  name: string;

  /**
   * Describes Update Run Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: UpdateRunProperties;
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
  put is ArmResourceCreateOrReplaceSync<UpdateRun>;

  /**
   * Delete specified Update Run
   */
  delete is ArmResourceDeleteAsync<
    UpdateRun,
    BaseParameters<UpdateRun>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all Update runs for a specified update
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UpdateRuns_List")
  list is ArmResourceListByParent<UpdateRun>;
}

@@projectedName(UpdateRuns.put::parameters.resource,
  "json",
  "updateRunsProperties"
);
@@extension(UpdateRuns.put::parameters.resource,
  "x-ms-client-name",
  "updateRunsProperties"
);
@@doc(UpdateRuns.put::parameters.resource,
  "Properties of the updateRuns object"
);
