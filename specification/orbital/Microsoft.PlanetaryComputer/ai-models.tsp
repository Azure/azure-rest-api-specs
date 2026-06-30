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
@resource("models")
@doc("Defines an AI Model resource containing the information needed to run inference over geospatial data.")
model AiModel {
  @doc("The unique identifier for the AI model.")
  @key("modelId")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Friendly name of the AI model.")
  name: string;

  @doc("Description of the AI model.")
  description?: string;

  @doc("Origin of the AI model, e.g., AI Foundry")
  source: string;

  @doc("Tags associated with the AI model.")
  tags: string[];

  @doc("Architecture of the AI model, e.g., ResNet, EfficientNet.")
  architecture?: string;

  @doc("Tasks performed by the AI model, e.g., Semantic Segmentation, Change Detection.")
  tasks?: string[];

  @doc("Execution framework of the AI model, e.g., ONNX, PyTorch, TensorFlow.")
  framework?: string;

  @doc("Description of the input expected by the AI model.")
  modelInputObject?: string;

  @doc("Description of the output produced by the AI model.")
  modelOutputObject?: string;

  @doc("Number of parameters in the AI model, if applicable.")
  totalParameters?: int32;

  @doc("Indicates whether the AI model is pretrained on a specific dataset.")
  pretrained?: boolean;

  @doc("Memory size, in bytes, of the AI model, if applicable.")
  memorySize?: int64;

  @doc("Output type of the AI model, e.g., Image, Vector, Text.")
  outputType?: string;
}

@added(Versions.v2026_08_01_Preview)
@doc("Compatibility level of the AI model with collections.")
union CompatibilityLevel {
  @doc("The model is compatible with the collection.")
  Compatible: "Compatible",

  @doc("The model is not compatible with the collection.")
  Incompatible: "Incompatible",

  @doc("There is not enough information to determine compatibility.")
  Undefined: "Undefined",

  string,
}

@added(Versions.v2026_08_01_Preview)
@resource("collectionCompatibilities")
@parentResource(AiModel)
@doc("Information about the compability of a collection with an AI model.")
model CollectionCompatibility {
  @doc("The unique identifier for the collection of STAC data items.")
  @key("collectionId")
  @visibility(Lifecycle.Read)
  collectionId: string;

  @doc("The compatibility level of the AI model with the collection.")
  compatibilityLevel: CompatibilityLevel;
}

@added(Versions.v2026_08_01_Preview)
@resource("modelCompatibilities")
@parentResource(StacCollection)
@doc("Information about the compability of a collection with an AI model.")
model ModelCompatibility {
  @doc("The unique identifier for an AI model.")
  @key("modelId")
  @visibility(Lifecycle.Read)
  modelId: string;

  @doc("The compatibility level of the AI model with the collection.")
  compatibilityLevel: CompatibilityLevel;
}

@tag("AI Models")
@route("ai")
@added(Versions.v2026_08_01_Preview)
interface AiModels {
  getModel is StandardOperations.ResourceRead<AiModel>;

  listModels is StandardOperations.ResourceList<
    AiModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  getCollectionCompatibility is StandardOperations.ResourceRead<CollectionCompatibility>;

  listCollectionCompatibility is StandardOperations.ResourceList<
    CollectionCompatibility,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  getModelCompatibility is StandardOperations.ResourceRead<ModelCompatibility>;

  listModelCompatibility is StandardOperations.ResourceList<
    ModelCompatibility,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
