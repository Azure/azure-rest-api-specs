import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service
namespace Microsoft.PlanetaryComputer;

@added(Versions.v2026_08_01_Preview)
@doc("Types of areas of interest (AOIs) that can be used in AI workflows.")
union AreaOfInterestType {
  @doc("The area of interest is defined by a bounding box.")
  BoundingBox: "BoundingBox",

  @doc("The area of interest is defined by a GeoJson feature of feature collection.")
  GeoJson: "GeoJson",

  @doc("The area of interest is defined by an external GeoJson file.")
  GeoJsonFile: "GeoJsonFile",

  @doc("The area of interest is defined by the extesion of a STAC collection.")
  StacCollectionArea: "StacCollectionArea",

  @doc("The area of interest is defined by the extesion of a STAC item.")
  StacItemArea: "StacItemArea",

  @doc("The area of interest is defined by GeoJson assets in a STAC item.")
  StacAssetGeoJson: "StacAssetGeoJson",

  string,
}

@added(Versions.v2026_08_01_Preview)
@discriminator("kind")
@doc("Defines an area of interest (AOI) for an AI workflow.")
model AreaOfInterest {
  @doc("The type of area of interest.")
  kind: AreaOfInterestType;
}

@added(Versions.v2026_08_01_Preview)
@doc("Area of interest defined by a bounding box.")
model BoundingBoxAreaOfInterest extends AreaOfInterest {
  kind: AreaOfInterestType.BoundingBox;

  @doc("The bounding box coordinates in the format [minLon, minLat, maxLon, maxLat].")
  bbox: float64[];
}

@added(Versions.v2026_08_01_Preview)
@doc("Area of interest defined by a GeoJson feature of feature collection.")
model GeoJsonAreaOfInterest extends AreaOfInterest {
  kind: AreaOfInterestType.GeoJson;

  @doc("The GeoJson feature or feature collection representing the area of interest.")
  geoJson: GeoJson;
}

@added(Versions.v2026_08_01_Preview)
@doc("Area of interest defined by an external GeoJson file.")
model GeoJsonFileAreaOfInterest extends AreaOfInterest {
  kind: AreaOfInterestType.GeoJsonFile;

  @doc("The URL of the external GeoJson file representing the area of interest.")
  geoJsonFile: string;
}

@added(Versions.v2026_08_01_Preview)
@doc("Area of interest defined by the extension of a STAC collection.")
model StacCollectionAreaOfInterest extends AreaOfInterest {
  kind: AreaOfInterestType.StacCollectionArea;

  @doc("The ID of the STAC collection representing the area of interest.")
  collectionId: string;
}

@added(Versions.v2026_08_01_Preview)
@doc("Area of interest defined by the extension of one or more STAC items.")
model StacItemAreaOfInterest extends AreaOfInterest {
  kind: AreaOfInterestType.StacItemArea;

  @doc("The ID of the STAC collection containing the STAC item.")
  collectionId: string;

  @doc("The ID of the STAC item representing the area of interest.")
  itemIds: string[];
}

@added(Versions.v2026_08_01_Preview)
@doc("Area of interest defined by a GeoJson asset in STAC items.")
model StacAssetGeoJsonAreaOfInterest extends AreaOfInterest {
  kind: AreaOfInterestType.StacAssetGeoJson;

  @doc("The ID of the STAC collection containing the STAC item.")
  collectionId: string;

  @doc("""
    The filter to apply to select the STAC items to extract the assets.
    e.g. {"op": "=", "args": [{"property": "id"}, "my-item-id"]}
    """)
  filter?: CqlFilter;

  @doc("The GeoJson assets representing the area of interest.")
  assetNames: string[];
}

@added(Versions.v2026_08_01_Preview)
@doc("Types of output sizes.")
union OutputSizeType {
  @doc("Create outputs of a fixed width and height.")
  FixedSize: "FixedSize",

  @doc("Create outputs using the specified bounding boxes.")
  BoundingBoxes: "BoundingBoxes",

  @doc("Create outputs that match the input STAC item extents.")
  MatchInput: "MatchInput",

  string,
}

@added(Versions.v2026_08_01_Preview)
@discriminator("kind")
@doc("Defines the output size for an AI workflow.")
model OutputSize {
  @doc("The type of output size.")
  kind: OutputSizeType;
}

@added(Versions.v2026_08_01_Preview)
@doc("Output size that merges patches of a fixed size.")
model FixedSize extends OutputSize {
  kind: OutputSizeType.FixedSize;

  @doc("Fixed size output height in geospatial units.")
  height?: int32;

  @doc("Fixed size output width in geospatial units.")
  width?: int32;
}

@added(Versions.v2026_08_01_Preview)
@doc("Output size that merges patches using a list of bounding boxes.")
model BoundingBoxesDefinedSize extends OutputSize {
  kind: OutputSizeType.BoundingBoxes;

  @doc("List of bounding boxes used for patch merging.")
  bboxes: float64[][];
}

@added(Versions.v2026_08_01_Preview)
@doc("Output size that aligns merged bounds with original input STAC item extents.")
model OriginalSize extends OutputSize {
  kind: OutputSizeType.MatchInput;
}

@added(Versions.v2026_08_01_Preview)
@doc("Input parameter for an AI model.")
model AiModelInput {
  @doc("The collection ID containing the input items.")
  collectionId: string;

  @doc("The filter to apply to select the STAC items for each AOI.")
  filter?: CqlFilter;

  @doc("Limit the number of STAC items to return for each AOI.")
  @minValue(0)
  limit?: int32 = 0;

  @doc("Sorting criteria for the STAC items.")
  sortBy?: SortBy[];
}

@added(Versions.v2026_08_01_Preview)
@resource("workflows")
@doc("Defines an AI Workflow resource containing the configuration needed to run inference over geospatial data.")
model AiWorkflow {
  @doc("The unique identifier for the AI workflow.")
  @key("workflowId")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Friendly name of the workflow.")
  displayName: string;

  @doc("Description of the workflow.")
  description?: string;

  @doc("""
    Model unique identifier.
    The model must be a STAC Item under the "models" collection.
    This is a read-only collection of models that adhere to the
    [STAC Machine Leaning Model Extension](https://github.com/stac-extensions/mlm).
    e.g.: /stac/collections/models/items/classification-model.
    """)
  modelId: string;

  @doc("The area of interest (AOI) to run inference over.")
  areaOfInterest: AreaOfInterest;

  @doc("Input parameters for the AI model.")
  modelInput?: Record<AiModelInput>;

  @doc("STAC collection ID where output results will be stored.")
  outputCollectionId: string;

  @doc("Output size for the workflow.")
  outputSize?: OutputSize = #{ kind: OutputSizeType.MatchInput };

  @doc("Provide relevant configurations for the model. Those can combine training details, inference runtime parameters, or both.")
  modelHyperparameters?: Record<string>;

  @doc("Creation date and time of the AI workflow.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("Last modification date and time of the AI workflow.")
  @visibility(Lifecycle.Read)
  lastModifiedAt: utcDateTime;
}

@added(Versions.v2026_08_01_Preview)
@doc("Token estimation request for a draft workflow.")
model TokenEstimationRequest {
  @doc("Draft workflow definition.")
  workflow: AiWorkflow;
}

@added(Versions.v2026_08_01_Preview)
@doc("Token estimation response for a draft workflow.")
model TokenEstimationResponse {
  @doc("Estimated number of tokens.")
  tokenCount: int32;
}

@added(Versions.v2026_08_01_Preview)
@resource("runs")
@parentResource(AiWorkflow)
@doc("An AI Workflow run.")
model AiWorkflowRun {
  @doc("The unique identifier for the workflow run.")
  @key("runId")
  @visibility(Lifecycle.Read)
  id: uuid;

  @doc("The unique identifier for the workflow.")
  workflowId: string;

  @doc("Workflow running state.")
  status: Foundations.OperationState;

  @doc("The creation time of the workflow run.")
  createdAt: utcDateTime;

  @doc("The start time of the workflow run.")
  startedAt?: utcDateTime;

  @doc("The end time of the workflow run.")
  finishedAt?: utcDateTime;

  @doc("Last modification date and time of the AI workflow.")
  lastModifiedAt: utcDateTime;

  @doc("Percentage of workflow completion.")
  percentComplete: float32;

  @doc("Workflow error message.")
  error?: Foundations.Error;
}

@tag("AI Workflows")
@route("ai")
@added(Versions.v2026_08_01_Preview)
interface AiWorkflows {
  get is StandardOperations.ResourceRead<AiWorkflow>;

  list is StandardOperations.ResourceList<
    AiWorkflow,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  createOrReplace is StandardOperations.ResourceCreateOrReplace<AiWorkflow>;

  delete is StandardOperations.ResourceDelete<AiWorkflow>;

  estimateTokens is StandardOperations.ResourceAction<
    AiWorkflow,
    {},
    TokenEstimationResponse
  >;

  estimateTokensDraft is StandardOperations.ResourceCollectionAction<
    AiWorkflow,
    TokenEstimationRequest,
    TokenEstimationResponse
  >;

  @pollingOperation(AiWorkflowRuns.get)
  run is StandardOperations.LongRunningResourceAction<
    AiWorkflow,
    {},
    {},
    AiWorkflowRun
  >;
}

@tag("AI Workflows")
@route("ai")
@added(Versions.v2026_08_01_Preview)
interface AiWorkflowRuns {
  get is StandardOperations.ResourceRead<AiWorkflowRun>;

  list is StandardOperations.ResourceList<
    AiWorkflowRun,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  delete is StandardOperations.ResourceDelete<AiWorkflowRun>;

  cancel is StandardOperations.ResourceAction<AiWorkflowRun, {}, {}>;
}
