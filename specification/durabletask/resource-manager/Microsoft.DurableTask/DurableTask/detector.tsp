import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

@doc("A diagnostic detector resource belonging to the scheduler.")
@added(Versions.v2026_07_01_Preview)
@parentResource(Scheduler)
model Detector is Azure.ResourceManager.ProxyResource<DetectorProperties> {
  ...ResourceNameParameter<
    Detector,
    "detectorId",
    "detectors",
    NamePattern = ""
  >;
}

@doc("The diagnostic response returned for a detector.")
@added(Versions.v2026_07_01_Preview)
model DetectorProperties {
  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the detector.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Metadata that identifies and describes the detector.")
  metadata?: DetectorMetadata;

  @visibility(Lifecycle.Read)
  @doc("The datasets produced when the detector runs.")
  @identifiers(#[])
  dataset?: DetectorDataset[];

  @visibility(Lifecycle.Read)
  @doc("The overall result of the detector.")
  status?: DetectorStatus;
}

@doc("Metadata that identifies and describes a detector.")
@added(Versions.v2026_07_01_Preview)
model DetectorMetadata {
  @visibility(Lifecycle.Read)
  @doc("The unique identifier of the detector.")
  id?: string;

  @visibility(Lifecycle.Read)
  @doc("The display name of the detector.")
  name?: string;

  @visibility(Lifecycle.Read)
  @doc("A description of the detector.")
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("The author of the detector when available for the caller.")
  author?: string;

  @visibility(Lifecycle.Read)
  @doc("The category of the detector.")
  category?: string;

  @visibility(Lifecycle.Read)
  @doc("The case-submission support topic identifiers for which the detector is enabled.")
  supportTopicList?: string[];

  @visibility(Lifecycle.Read)
  @doc("The analysis identifiers for which the detector is enabled.")
  analysisTypes?: string[];

  @visibility(Lifecycle.Read)
  @doc("The kind of diagnostic response.")
  type?: DetectorType;

  @visibility(Lifecycle.Read)
  @doc("The match score when the detector is returned from a search.")
  score?: float64;
}

@doc("The kind of diagnostic response.")
@added(Versions.v2026_07_01_Preview)
union DetectorType {
  string,

  @doc("A diagnostic detector.")
  Detector: "Detector",

  @doc("A diagnostic analysis.")
  Analysis: "Analysis",

  @doc("A diagnostic category overview.")
  CategoryOverview: "CategoryOverview",
}

@doc("A dataset produced by a detector.")
@added(Versions.v2026_07_01_Preview)
model DetectorDataset {
  @visibility(Lifecycle.Read)
  @doc("The tabular data produced by the detector.")
  table?: DetectorTable;

  @visibility(Lifecycle.Read)
  @doc("The rendering information for the tabular data.")
  renderingProperties?: DetectorRenderingProperties;
}

@doc("A table included in a detector dataset.")
@added(Versions.v2026_07_01_Preview)
model DetectorTable {
  @visibility(Lifecycle.Read)
  @doc("The name of the table.")
  tableName?: string;

  @visibility(Lifecycle.Read)
  @doc("The column definitions for the table.")
  @identifiers(#["columnName"])
  columns?: DetectorTableColumn[];

  @visibility(Lifecycle.Read)
  @doc("The rows in the table. Values use the types specified by their columns.")
  @identifiers(#[])
  rows?: unknown[][];
}

@doc("A column definition in a detector table.")
@added(Versions.v2026_07_01_Preview)
model DetectorTableColumn {
  @visibility(Lifecycle.Read)
  @doc("The name of the column.")
  columnName?: string;

  @visibility(Lifecycle.Read)
  @doc("The data type of values in the column.")
  dataType?: string;

  @visibility(Lifecycle.Read)
  @doc("The optional semantic classification of the column.")
  columnType?: string;
}

@doc("The rendering information for a detector dataset.")
@added(Versions.v2026_07_01_Preview)
model DetectorRenderingProperties {
  @visibility(Lifecycle.Read)
  @doc("The rendering type for the dataset.")
  type?: DetectorRenderingType;

  @visibility(Lifecycle.Read)
  @doc("The optional title of the rendering block.")
  title?: string;

  @visibility(Lifecycle.Read)
  @doc("The optional description of the rendering block.")
  description?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing extensible integer rendering type union."
@doc("The rendering type for a detector dataset.")
@added(Versions.v2026_07_01_Preview)
union DetectorRenderingType {
  int32,

  @doc("A table rendering.")
  Table: 1,

  @doc("A time series graph rendering.")
  TimeSeriesGraph: 2,

  @doc("A time series per-instance graph rendering.")
  TimeSeriesPerInstanceGraph: 3,

  @doc("A pie chart rendering.")
  PieChart: 4,

  @doc("A data summary rendering.")
  DataSummary: 5,

  @doc("An email snippet rendering.")
  EmailSnippet: 6,

  @doc("An insight rendering.")
  Insight: 7,

  @doc("A dynamic insight rendering.")
  DynamicInsight: 8,

  @doc("A Markdown rendering.")
  Markdown: 9,
}

@doc("The overall result of a detector.")
@added(Versions.v2026_07_01_Preview)
model DetectorStatus {
  @visibility(Lifecycle.Read)
  @doc("The optional message describing the detector result.")
  message?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the detector result.")
  statusId?: DetectorStatusId;
}

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing extensible integer detector status union."
@doc("The status of a detector result.")
@added(Versions.v2026_07_01_Preview)
union DetectorStatusId {
  int32,

  @doc("A critical issue was detected.")
  Critical: 0,

  @doc("A warning was detected.")
  Warning: 1,

  @doc("An informational result was returned.")
  Info: 2,

  @doc("The detector completed without detecting an issue.")
  Success: 3,

  @doc("The detector did not run or returned no insights.")
  None: 4,
}

@added(Versions.v2026_07_01_Preview)
@armResourceOperations(Detector)
interface Detectors {
  @doc("Gets a diagnostic detector.")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<Detector>;

  @doc("Lists the diagnostic detectors belonging to a scheduler.")
  listByScheduler is ArmResourceListByParent<Detector>;
}
