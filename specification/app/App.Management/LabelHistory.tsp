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

alias LabelHistoryOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;
  },
  {
    /** Name of the label. */
    @path
    @segment("labelHistory")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    labelName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
interface ContainerAppsLabelHistory {
  /**
   * Get the history of a label.
   */
  @summary("Get the history of a label.")
  getLabelHistory is LabelHistoryOps.Read<LabelHistory>;

  /**
   * Delete the history of a label.
   */
  @summary("Delete the history of a label.")
  deleteLabelHistory is LabelHistoryOps.DeleteSync<LabelHistory>;

  /**
   * Get the Label History for a given Container App.
   */
  @summary("Get the Label History for a given Container App.")
  listLabelHistory is LabelHistoryOps.List<
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
