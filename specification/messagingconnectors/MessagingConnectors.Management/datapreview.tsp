import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.MessagingConnectors;

@doc("A DataPreview resource Azure")
@subscriptionResource
model DataPreviewInstance is ProxyResource<DataPreviewProperties> {
  @doc("Name of the DataPreview resource.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("name")
  @segment("dataPreview")
  name: string;
}

@armResourceOperations(DataPreviewInstance)
interface DataPreviewOperationsV1 {
  @doc("Start one DataPreview task")
  startPreview is ArmResourceActionSync<
    DataPreviewInstance,
    DataPreviewProperties,
    void
  >;

  @doc("Get the result of DataPreview")
  getResults is ArmResourceActionSync<
    DataPreviewInstance,
    void,
    DataPreviewResults
  >;
}


#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface DataPreviewOperations {
  /**
   * DataPreview operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @post
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MessagingConnectors/dataPreview/")
  op dataPreview(
    ...Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    @body
    @doc("dataPreview properties")
    body: {
      properties: DataPreviewProperties
    }
  ): ArmResponse<DataPreviewOperationResult> | ErrorResponse;

  /**
   * DataPreview operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MessagingConnectors/dataPreview/{dataPreviewId}")
  op getDataPreviewResults(
    ...Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    @path
    @minLength(1)
    @segment("dataPreviewId")
    @doc("The id of dataPreview.")
    dataPreviewId: string
  ): ArmResponse<DataPreviewResults> | ErrorResponse;
}
