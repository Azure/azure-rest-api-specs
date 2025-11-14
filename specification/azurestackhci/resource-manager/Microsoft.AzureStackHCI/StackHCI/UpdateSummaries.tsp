import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Get the update summaries for the cluster
 */
@singleton("default")
@parentResource(Cluster)
model UpdateSummaries
  is Azure.ResourceManager.ProxyResource<UpdateSummariesProperties> {
  ...ResourceNameParameter<
    Resource = UpdateSummaries,
    KeyName = "updateSummary",
    SegmentName = "updateSummaries",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface UpdateSummariesOperationGroup {
  /**
   * Get all Update summaries under the HCI cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UpdateSummaries_Get")
  get is ArmResourceRead<UpdateSummaries>;

  /**
   * Put Update summaries under the HCI cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UpdateSummaries_Put")
  put is ArmResourceCreateOrReplaceSync<
    UpdateSummaries,
    Response = ArmResourceUpdatedResponse<UpdateSummaries>
  >;

  /**
   * Delete Update Summaries
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UpdateSummaries_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    UpdateSummaries,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Update summaries under the HCI cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UpdateSummaries_List")
  list is ArmResourceListByParent<
    UpdateSummaries,
    Response = ArmResponse<UpdateSummariesList>
  >;
}

@@doc(UpdateSummaries.name, "");
@@doc(UpdateSummaries.properties, "Update summaries properties");
@@doc(UpdateSummariesOperationGroup.put::parameters.resource,
  "Properties of the UpdateSummaries resource"
);
