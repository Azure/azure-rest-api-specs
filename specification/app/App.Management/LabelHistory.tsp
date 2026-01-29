import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Label History.
 */
@parentResource(ContainerApp)
model LabelHistory
  is Azure.ResourceManager.ProxyResource<LabelHistoryProperties> {
  ...ResourceNameParameter<
    Resource = LabelHistory,
    KeyName = "labelName",
    SegmentName = "labelHistory",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface LabelHistories {
  /**
   * Get the history of a label.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsLabelHistory_GetLabelHistory")
  getLabelHistory is ArmResourceRead<LabelHistory>;

  /**
   * Delete the history of a label.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsLabelHistory_DeleteLabelHistory")
  deleteLabelHistory is ArmResourceDeleteSync<LabelHistory>;

  /**
   * Get the Label History for a given Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsLabelHistory_ListLabelHistory")
  listLabelHistory is ArmResourceListByParent<
    LabelHistory,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<LabelHistoryCollection>
  >;
}

@@doc(LabelHistory.name, "Name of the Container App label.");
@@doc(LabelHistory.properties,
  "Container App Label History resource specific properties"
);
