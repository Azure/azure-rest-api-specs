import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("The weight type of the model.")
union FoundryModelWeightType {
  string,

  @doc("Full weight model")
  FullWeight: "FullWeight",

  @doc("LoRA adapter weights")
  LoRA: "LoRA",

  @doc("Draft model weights")
  DraftModel: "DraftModel",
}

@doc("The source type of the model.")
union FoundryModelSourceType {
  string,

  @doc("Model was uploaded locally")
  LocalUpload: "LocalUpload",

  @doc("Model was produced by a training job")
  TrainingJob: "TrainingJob",
}

@doc("The artifact profile category.")
union FoundryModelArtifactProfileCategory {
  string,

  @doc("Data only artifacts")
  DataOnly: "DataOnly",

  @doc("Runtime dependent artifacts")
  RuntimeDependent: "RuntimeDependent",

  @doc("Unknown category")
  Unknown: "Unknown",
}

@doc("Signals detected in the model artifact.")
union FoundryModelArtifactProfileSignal {
  string,

  @doc("Pickle deserialization detected")
  PickleDeserialization: "PickleDeserialization",

  @doc("Custom Python code detected")
  CustomPythonCode: "CustomPythonCode",

  @doc("Dynamic operations detected")
  DynamicOps: "DynamicOps",

  @doc("Native binary code detected")
  NativeBinary: "NativeBinary",

  @doc("Unknown format detected")
  UnknownFormat: "UnknownFormat",
}

@doc("Warning code for model artifacts.")
union FoundryModelWarningCode {
  string,

  @doc("Runtime dependent artifact warning")
  RuntimeDependentArtifact: "RuntimeDependentArtifact",

  @doc("Unclassified artifact warning")
  UnclassifiedArtifact: "UnclassifiedArtifact",
}

@doc("A warning associated with a model.")
model FoundryModelWarning {
  @doc("The warning code.")
  code?: FoundryModelWarningCode;

  @doc("The warning message.")
  message?: string;
}

@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  system_data?: SystemDataV3;

  @doc("URI of the model artifact in blob storage")
  blobUri: url;

  @doc("The weight type of the model")
  weightType?: FoundryModelWeightType;

  @doc("Base model asset ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  baseModel?: string;

  @doc("The source of the model")
  source?: ModelSourceData;

  @doc("The artifact profile of the model")
  @visibility(Lifecycle.Read)
  artifactProfile?: ArtifactProfile;

  @doc("Service-computed advisory warnings derived from the artifact profile.")
  @visibility(Lifecycle.Read)
  warnings?: FoundryModelWarning[];

  ...AssetBase;
}

@@visibility(ModelVersion.description, Lifecycle.Create, Lifecycle.Update, Lifecycle.Read);
@@visibility(ModelVersion.tags, Lifecycle.Create, Lifecycle.Update, Lifecycle.Read);

@doc("System metadata for a resource")
model SystemDataV3 {
  @doc("Timestamp of resource creation")
  createdAt?: utcDateTime;

  @doc("Identity that created the resource")
  createdBy?: string;

  @doc("Type of identity that created the resource")
  createdByType?: string;

  @doc("Timestamp of last resource modification")
  lastModifiedAt?: utcDateTime;
}

@doc("Source information for the model")
model ModelSourceData {
  @doc("The source type of the model")
  sourceType?: FoundryModelSourceType;

  @doc("The job ID that produced this model")
  jobId?: string;
}

@doc("Artifact profile of the model")
model ArtifactProfile {
  @doc("The category of the artifact profile")
  category?: FoundryModelArtifactProfileCategory;

  @doc("Signals detected in the model artifact")
  signals?: FoundryModelArtifactProfileSignal[];
}

@doc("Request body for updating a model version. Only description and tags can be modified.")
model UpdateModelVersionRequest {
  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;
}

@doc("Request to fetch credentials for a model asset.")
model ModelCredentialRequest {
  @doc("Blob URI of the model asset to fetch credentials for.")
  blobUri: url;
}

@doc("Accepted response for asynchronous model version creation, with polling location.")
model CreateModelVersionAsyncResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for operation status.")
  @header("Location")
  location: string;
}
