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

@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  system_data?: SystemDataV3;

  @doc("URI of the model artifact in blob storage")
  blobUri?: url;

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

  ...AssetBase;
}

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

@doc("The operation type for a JSON Patch operation.")
union JsonPatchOp {
  string,

  @doc("Add a value")
  add: "add",

  @doc("Remove a value")
  remove: "remove",

  @doc("Replace a value")
  replace: "replace",
}

@doc("A JSON Patch operation (RFC 6902). Only /description and /tags paths are supported.")
model JsonPatchOperation {
  @doc("The operation to perform.")
  op: JsonPatchOp;

  @doc("The JSON pointer path to the target field. Only '/description' and '/tags' or '/tags/{key}' paths are supported.")
  path: string;

  @doc("The value to set. Required for 'add' and 'replace' operations.")
  value?: unknown;
}

@doc("Accepted response for asynchronous model version creation, with polling location.")
model CreateModelVersionAsyncResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for operation status.")
  @header("Location")
  location: string;
}
