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
  @doc("URI of the model artifact in blob storage")
  blobUri: url;

  @doc("The weight type of the model")
  weightType?: FoundryModelWeightType;

  @doc("Base model asset ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  baseModel?: string;

  @doc("The source of the model")
  source?: ModelSourceData;

  @doc("Adapter-specific configuration. Required when weight_type is lora; ignored otherwise. May be auto-populated from adapter_config.json when present in the uploaded files — user-provided values take precedence over auto-detected values.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  loraConfig?: LoraConfig;

  @doc("The artifact profile of the model")
  @visibility(Lifecycle.Read)
  artifactProfile?: ArtifactProfile;

  @doc("Service-computed advisory warnings derived from the artifact profile.")
  @visibility(Lifecycle.Read)
  warnings?: FoundryModelWarning[];

  ...AssetBase;
}

@@visibility(ModelVersion.description,
  Lifecycle.Create,
  Lifecycle.Update,
  Lifecycle.Read
);
@@visibility(ModelVersion.tags,
  Lifecycle.Create,
  Lifecycle.Update,
  Lifecycle.Read
);

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
  category: FoundryModelArtifactProfileCategory;

  @doc("Signals detected in the model artifact")
  signals?: FoundryModelArtifactProfileSignal[];
}

@doc("Adapter-specific metadata for LoRA models. Drives serving engine configuration at deployment time.")
model LoraConfig {
  @doc("LoRA rank (r). Positive integer. Common values: 8, 16, 32, 64.")
  rank?: int32;

  @doc("LoRA scaling factor (α). Positive integer; typically 2× the rank.")
  alpha?: int32;

  @doc("Model layers modified by the adapter (e.g., q_proj, v_proj). Auto-detected from adapter_config.json if omitted.")
  targetModules?: string[];

  @doc("Dropout rate used during training. Informational — not used at serving time.")
  dropout?: float32;
}

@doc("Request body for updating a model version. Only description and tags can be modified.")
model UpdateModelVersionRequest {
  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;
}

@doc("Represents a request for a pending upload of a model version.")
model ModelPendingUploadRequest {
  @doc("If PendingUploadId is not provided, a random GUID will be used.")
  pendingUploadId?: string;

  @doc("Azure Storage Account connection name to use for generating temporary SAS token")
  connectionName?: string;

  @doc("The type of pending upload. Only TemporaryBlobReference is supported for models.")
  pendingUploadType: PendingUploadType.TemporaryBlobReference;
}

@doc("Represents the response for a model pending upload request.")
model ModelPendingUploadResponse {
  @doc("Container-level read, write, list SAS.")
  blobReferenceForConsumption: BlobReference;

  @doc("ID for this upload request.")
  pendingUploadId: string;

  @doc("Version of asset to be created if user did not specify version when initially creating upload")
  version?: string;

  @doc("The type of pending upload. Only TemporaryBlobReference is supported for models.")
  pendingUploadType: PendingUploadType.TemporaryBlobReference;
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
  location?: url;

  @bodyRoot
  body: {
    @doc("URL to poll for operation status.")
    location?: url;

    @doc("URL to the operation result, or null if the operation is still in progress.")
    operationResult?: url | null;
  };
}
