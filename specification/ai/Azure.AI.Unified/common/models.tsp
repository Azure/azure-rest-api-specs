import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../credentials/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.AI.Unified;

@doc("The possible values for roles attributed to messages in a thread.")
union MessageRole {
  string,

  @doc("The role representing the end-user.")
  user: "user",

  @doc("The role representing the assistant.")
  assistant: "assistant",
}

@doc("The available sorting options when requesting a list of response objects.")
union ListSortOrder {
  string,

  @doc("Specifies an ascending sort order.")
  ascending: "asc",

  @doc("Specifies a descending sort order.")
  descending: "desc",
}

alias OpenAIListRequestOptions = {
  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @query
  limit?: int32 = 20;

  @doc("Sort order by the created_at timestamp of the objects. asc for ascending order and desc for descending order.")
  @query
  order?: ListSortOrder = ListSortOrder.descending;

  @doc("A cursor for use in pagination. after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list.")
  @query
  after?: string;

  @doc("A cursor for use in pagination. before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list.")
  @query
  before?: string;
};

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
model OpenAIPageableListOf<T> {
  @doc("The object type, which is always list.")
  object: "list";

  @doc("The requested list of items.")
  data: T[];

  @encodedName("application/json", "first_id")
  @doc("The first ID represented in this list.")
  firstId: string;

  @encodedName("application/json", "last_id")
  @doc("The last ID represented in this list.")
  lastId: string;

  @encodedName("application/json", "has_more")
  @doc("A value indicating whether there are additional values available not captured in this list.")
  hasMore: boolean;
}

alias DeletionStatus = {
  @doc("The ID of the resource specified for deletion.")
  id: string;

  @doc("A value indicating whether deletion was successful.")
  deleted: boolean;
};

alias RequiredNullableMetadata = {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("A set of up to 16 key/value pairs that can be attached to an object, used for storing additional information about that object in a structured format. Keys may be up to 64 characters in length and values may be up to 512 characters in length.")
  metadata: Record<string> | null;
};

alias OptionalNullableMetadata = {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("A set of up to 16 key/value pairs that can be attached to an object, used for storing additional information about that object in a structured format. Keys may be up to 64 characters in length and values may be up to 512 characters in length.")
  metadata?: Record<string> | null;
};

#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
@doc("Specifies the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`. Setting to `{ \"type\": \"json_object\" }` enables JSON mode, which guarantees the message the model generates is valid JSON. **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly \"stuck\" request. Also note that the message content may be partially cut off if `finish_reason=\"length\"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.")
union AssistantsApiResponseFormatOption {
  string,

  @doc("The model will handle the return format.")
  AssistantsApiResponseFormatMode,

  @doc("Sets the format of the output of the model when a ToolCall is returned.")
  AssistantsApiResponseFormat,
}

@doc("Represents the mode in which the model will handle the return format of a tool call.")
union AssistantsApiResponseFormatMode {
  string,

  @doc("Default value. Let the model handle the return format.")
  "auto",

  @doc("Setting the value to `none`, will result in a 400 Bad request.")
  "none",
}

@doc("An object describing the expected output of the model. If `json_object` only `function` type `tools` are allowed to be passed to the Run. If `text` the model can return text or any value needed.")
model AssistantsApiResponseFormat {
  @doc("Must be one of `text` or `json_object`.")
  type?: ApiResponseFormat = ApiResponseFormat.text;
}

@doc("Possible API response formats.")
union ApiResponseFormat {
  string,

  @doc("`text` format should be used for requests involving any sort of ToolCall.")
  text: "text",

  @doc("Using `json_object` format will limit the usage of ToolCall to only functions.")
  jsonObject: "json_object",
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @visibility("read")
  @doc("The timestamp the resource was created at.")
  createdAt?: utcDateTime;

  @visibility("read")
  @doc("The identity that created the resource.")
  createdBy?: string;

  @visibility("read")
  @doc("The identity type that created the resource.")
  createdByType?: string;

  @visibility("read")
  @doc("The timestamp of resource last modification (UTC)")
  lastModifiedAt?: utcDateTime;
}

@doc("List View Type Definition")
union ListViewType {
  string,

  @doc("List only active items.")
  ActiveOnly: "ActiveOnly",

  @doc("List only archived items.")
  ArchivedOnly: "ArchivedOnly",

  @doc("List all items.")
  All: "All",
}

@doc("Enum to determine which reference method to use for an asset.")
union ReferenceType {
  string,

  @doc("Id")
  Id: "Id",

  @doc("DataPath")
  DataPath: "DataPath",

  @doc("OutputPath")
  OutputPath: "OutputPath",
}

@doc("Base definition for asset references.")
@discriminator("referenceType")
model AssetReferenceBase {
  @doc("Asset reference type.")
  referenceType: ReferenceType;
}

@doc("Reference to an asset via its ARM resource ID.")
model IdAssetReference extends AssetReferenceBase {
  @doc("[Required] ARM resource ID of the asset.")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  assetId: string;

  @doc("[Required] Specifies the type of asset reference.")
  referenceType: "Id";
}

@doc("Reference to an asset via its path in a datastore.")
model DataPathAssetReference extends AssetReferenceBase {
  @doc("ARM resource ID of the datastore where the asset is located.")
  datastoreId?: string;

  @doc("The path of the file/directory in the datastore.")
  path?: string;

  @doc("[Required] Specifies the type of asset reference.")
  referenceType: "DataPath";
}

@doc("Reference to an asset via its path in a job output.")
model OutputPathAssetReference extends AssetReferenceBase {
  @doc("ARM resource ID of the job.")
  jobId?: string;

  @doc("The path of the file/directory in the job output.")
  path?: string;

  @doc("[Required] Specifies the type of asset reference.")
  referenceType: "OutputPath";
}

alias AssetBase = {
  @doc("Asset stage")
  @visibility("read", "create", "update")
  stage?: string;

  @doc("A unique identifier for the asset, assetId probably?")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The version of the resource")
  @visibility("read")
  version?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("System data of the resource")
  @visibility("read")
  systemData?: SystemData;
};

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;

alias AdditionalInferenceRequestHeaders = {
  @doc("""
    Controls what happens if extra parameters, undefined by the REST API,
    are passed in the JSON request payload.
    This sets the HTTP request header `extra-parameters`.
    """)
  @header("extra-parameters")
  extra_params?: ExtraParameters;
};

@doc("Controls what happens if extra parameters, undefined by the REST API, are passed in the JSON request payload.")
union ExtraParameters {
  string,

  @doc("The service will error if it detected extra parameters in the request payload. This is the service default.")
  error: "error",

  @doc("The service will ignore (drop) extra parameters in the request payload. It will only pass the known parameters to the back-end AI model.")
  drop: "drop",

  @doc("The service will pass extra parameters to the back-end AI model.")
  pass_through: "pass-through",
}

// Pending upload spec

// Define a URI alias for clarity.
alias Uri = string;

@doc("The type of pending upload.")
union PendingUploadType {
  string,

  @doc("No pending upload.")
  none: "None",

  @doc("Temporary Blob Reference is the only supported type.")
  temporaryBlobReference: "TemporaryBlobReference",
}

@doc("The type of credential used to access the storage account.")
union PendingUploadCredentialType {
  string,

  @doc("SAS credential type.")
  sas: "SAS",
}

@doc("Represents a request for a pending upload.")
model PendingUploadRequest {
  @doc("If PendingUploadId is not provided, a random GUID will be used.")
  pendingUploadId?: string;

  @doc("TemporaryBlobReference is the only supported type.")
  pendingUploadType: PendingUploadType.temporaryBlobReference;
}

@doc("Represents the response for a pending upload request")
model PendingUploadResponse {
  @doc("Container-level read, write, list SAS.")
  blobReferenceForConsumption: BlobReferenceForConsumption;

  @doc("ID for this upload request.")
  pendingUploadId: string;

  @doc("TemporaryBlobReference is the only supported type")
  pendingUploadType: PendingUploadType.temporaryBlobReference;
}

@doc("Represents a reference to a blob for consumption")
model BlobReferenceForConsumption {
  @doc("Blob URI path for client to upload data. Example: https://blob.windows.core.net/Container/Path")
  blobUri: Uri;

  @doc("ARM ID of the storage account to use.")
  storageAccountArmId: string;

  @doc("Credential info to access the storage account.")
  credential: SasCredential;
}

@doc("""
  The definition of a caller-specified function that chat completions may invoke in response to matching user input.
  """)
model FunctionDefinition {
  @doc("The name of the function to be called.")
  name: string;

  @doc("""
    A description of what the function does. The model will use this description when selecting the function and
    interpreting its parameters.
    """)
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
  @doc("The parameters the function accepts, described as a JSON Schema object.")
  parameters?: Record<unknown>;
}
