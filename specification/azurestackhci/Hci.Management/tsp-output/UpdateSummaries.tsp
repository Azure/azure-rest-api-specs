import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Get the update summaries for the cluster
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(UpdateSummariesProperties)
model UpdateSummaries extends ProxyResourceBase {
  @key("updateSummary")
  @segment("updateSummaries")
  @visibility("read")
  name: string;

  /**
   * Update summaries properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: UpdateSummariesProperties;
}

@armResourceOperations
@projectedName("client", "UpdateSummaries")
interface UpdateSummariesOperationGroup {
  /**
   * Get all Update summaries under the HCI cluster
   */
  get is ArmResourceRead<UpdateSummaries>;

  /**
   * Put Update summaries under the HCI cluster
   */
  put is ArmResourceCreateOrReplaceSync<UpdateSummaries>;

  /**
   * Delete Update Summaries
   */
  delete is ArmResourceDeleteAsync<
    UpdateSummaries,
    BaseParameters<UpdateSummaries>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all Update summaries under the HCI cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UpdateSummaries_List")
  list is ArmResourceListByParent<UpdateSummaries>;
}

@@projectedName(UpdateSummariesOperationGroup.put::parameters.resource,
  "json",
  "updateLocationProperties"
);
@@extension(UpdateSummariesOperationGroup.put::parameters.resource,
  "x-ms-client-name",
  "updateLocationProperties"
);
@@doc(UpdateSummariesOperationGroup.put::parameters.resource,
  "Properties of the UpdateSummaries resource"
);
