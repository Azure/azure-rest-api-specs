import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Model Version Definition")
@Rest.resource("models")
@added(Versions.v1)
model ModelVersion {
  @doc("Evaluation details of the model")
  evaluation?: string;

  @doc("Notes about the model")
  notes?: string;

  @doc("Datetime of training data")
  trainingDataDate?: utcDateTime;

  @doc("License description")
  licenseDescription?: string;

  @doc("Inference tasks supported by the model")
  inferenceTasks?: string[];

  @doc("Fine-tuning tasks supported by the model")
  fineTuningTasks?: string[];

  @doc("Keywords associated with the model")
  keywords?: string[];

  @doc("Playground limits for the model")
  playgroundLimits?: PlaygroundLimits;

  @doc("Capabilities of the model")
  modelCapabilities?: string;

  @doc("Limits of the model")
  modelLimits?: ModelLimits;

  @doc("Supported languages")
  supportedLanguages?: string[];

  @doc("Supported input modalities")
  supportedInputModalities?: string[];

  @doc("Supported output modalities")
  supportedOutputModalities?: string[];

  @doc("Azure offers for the model")
  azureOffers?: string[];

  @doc("System related metadata")
  @visibility(Lifecycle.Read)
  SystemData?: SystemData;

  @doc("Catalog information for the model")
  catalogInfo: ModelCatalogInformation;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  ...AssetBase;
}

@doc("Playground limits for the model")
model PlaygroundLimits {
  @doc("Rate limit tier")
  rateLimitTier: string;
}

@doc("Limits of the model")
model ModelLimits {
  @doc("Text limits")
  textLimits?: TextLimits;

  @doc("Other limits")
  otherLimits?: string;
}

@doc("Text limits")
model TextLimits {
  @doc("Input context window")
  inputContextWindow: int32;

  @doc("Maximum output tokens")
  maxOutputTokens: int32;
}

@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model")
  baseModel: string;
}

@doc("Catalog information for the model")
model ModelCatalogInformation {
    ...CatalogInformation;  
}