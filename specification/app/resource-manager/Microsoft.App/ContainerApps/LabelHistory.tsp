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
using TypeSpec.Versioning;

namespace Microsoft.App;
/**
 * Container App Label History.
 */
@removed(Versions.v2026_01_01)
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_07_01)
@renamedFrom(Versions.v2026_07_01, "LabelHistory")
@parentResource(ContainerApp)
model LabelHistoryPreview
  is Azure.ResourceManager.ProxyResource<LabelHistoryProperties> {
  ...ResourceNameParameter<
    Resource = LabelHistoryPreview,
    KeyName = "labelName",
    SegmentName = "labelHistory",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

/**
 * Container App Label History.
 */
@added(Versions.v2026_07_01)
@parentResource(ContainerApp)
model LabelHistory
  is Azure.ResourceManager.ProxyResource<LabelHistoryProperties> {
  ...ResourceNameParameter<
    Resource = LabelHistory,
    KeyName = "labelName",
    SegmentName = "labelHistories",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias LabelHistoryPreviewOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("labelHistories")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    labelName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@removed(Versions.v2026_01_01)
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_07_01)
@renamedFrom(Versions.v2026_07_01, "ContainerAppsLabelHistory")
@armResourceOperations
interface ContainerAppsLabelHistoryPreview {
  /**
   * Gets the revision history associated with a Container App label.
   */
  @summary("Get the history of a label.")
  getLabelHistory is LabelHistoryPreviewOps.Read<LabelHistoryPreview>;

  /**
   * Deletes the revision history associated with a Container App label.
   */
  @summary("Delete the history of a label.")
  deleteLabelHistory is LabelHistoryPreviewOps.DeleteSync<LabelHistoryPreview>;

  /**
   * Lists the label revision histories for a Container App.
   */
  @summary("Get the Label History for a given Container App.")
  listLabelHistory is LabelHistoryPreviewOps.List<
    LabelHistoryPreview,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<LabelHistoryPreviewCollection>
  >;
}

@added(Versions.v2026_07_01)
@armResourceOperations
interface ContainerAppsLabelHistory {
  /**
   * Gets the revision history associated with a Container App label.
   */
  @summary("Get the history of a label.")
  getLabelHistory is LabelHistoryOps.Read<LabelHistory>;

  /**
   * Deletes the revision history associated with a Container App label.
   */
  @summary("Delete the history of a label.")
  deleteLabelHistory is LabelHistoryOps.DeleteSync<LabelHistory>;

  /**
   * Lists the label revision histories for a Container App.
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

@@doc(LabelHistoryPreview.name, "Name of the Container App label.");
@@doc(
  LabelHistoryPreview.properties,
  "Container App Label History resource specific properties"
);
@@doc(LabelHistory.name, "Name of the Container App label.");
@@doc(
  LabelHistory.properties,
  "Container App Label History resource specific properties"
);
