import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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

@doc("Enum to determine whether PublicNetworkAccess is Enabled or Disabled.")
union PublicNetworkAccessType {
  string,

  @doc("PublicNetworkAccess is enabled.")
  Enabled: "Enabled",

  @doc("PublicNetworkAccess is disabled.")
  Disabled: "Disabled",
}

@doc("Enum to determine whether PublicNetworkAccess is Enabled or Disabled for egress of a deployment.")
union EgressPublicNetworkAccessType {
  string,

  @doc("PublicNetworkAccess is enabled for egress.")
  Enabled: "Enabled",

  @doc("PublicNetworkAccess is disabled for egress.")
  Disabled: "Disabled",
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

@doc("Enum to determine endpoint compute type.")
union EndpointComputeType {
  string,

  @doc("Managed")
  Managed: "Managed",

  @doc("Kubernetes")
  Kubernetes: "Kubernetes",

  @doc("AzureMLCompute")
  AzureMLCompute: "AzureMLCompute",
}

@doc("The type of ordering to use")
union OrderString {
  string,

  @doc("Sort creation date/time in descending order.")
  CreatedAtDesc: "CreatedAtDesc",

  @doc("Sort creation date/time in ascending order.")
  CreatedAtAsc: "CreatedAtAsc",

  @doc("Sort updated at date/time in descending order.")
  UpdatedAtDesc: "UpdatedAtDesc",

  @doc("Sort updated at date/time in ascending order.")
  UpdatedAtAsc: "UpdatedAtAsc",
}

@doc("Strictly used in update requests.")
model PartialMinimalTrackedResource {
  @doc("Resource tags.")
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Strictly used in update requests.")
model PartialMinimalTrackedResourceWithIdentity
  extends PartialMinimalTrackedResource {
  @doc("Managed service identity (system assigned and/or user assigned identities)")
  identity?: PartialManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Strictly used in update requests.")
model PartialMinimalTrackedResourceWithSku
  extends PartialMinimalTrackedResource {
  @doc("Sku details required for ARM contract for Autoscaling.")
  sku?: PartialSku;
}

@doc("Common SKU definition.")
model PartialSku {
  @doc("If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.")
  capacity?: int32;

  @doc("If the service has different generations of hardware, for the same SKU, then that can be captured here.")
  family?: string;

  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code.")
  name?: string;

  @doc("The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.")
  size?: string;

  @doc("This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.")
  tier?: SkuTier;
}

@doc("Managed service identity (system assigned and/or user assigned identities)")
model PartialManagedServiceIdentity {
  @doc("Managed service identity (system assigned and/or user assigned identities)")
  type?: ManagedServiceIdentityType;

  @doc("The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.")
  userAssignedIdentities?: Record<Record<unknown>>;
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
union ManagedServiceIdentityType {
  string,

  @doc("No managed service identity.")
  None: "None",

  @doc("SystemAssigned identity")
  SystemAssigned: "SystemAssigned",

  @doc("UserAssigned identity.")
  UserAssigned: "UserAssigned",

  @doc("SystemAssigned and UserAssigned identity.")
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

@doc("Type of key (Primary or Secondary).")
union KeyType {
  string,

  @doc("Primary key.")
  Primary: "Primary",

  @doc("Secondary key.")
  Secondary: "Secondary",
}

@doc("A paginated list of SkuResource entities.")
model SkuResourceArmPaginatedResult is Azure.Core.Page<SkuResource>;

@doc("Fulfills ARM Contract requirement to list all available SKUS for a resource.")
model SkuResource {
  @doc("Gets or sets the Sku Capacity.")
  capacity?: SkuCapacity;

  @doc("The resource type name.")
  @visibility("read")
  resourceType?: string;

  @doc("Gets or sets the Sku.")
  sku?: SkuSetting;
}

@doc("SKU capacity information")
model SkuCapacity {
  @doc("Gets or sets the default capacity.")
  default?: int32;

  @doc("Gets or sets the maximum.")
  maximum?: int32;

  @doc("Gets or sets the minimum.")
  minimum?: int32;

  @doc("Gets or sets the type of the scale.")
  scaleType?: SkuScaleType;
}

@doc("SkuSetting fulfills the need for stripped down SKU info in ARM contract.")
model SkuSetting {
  @doc("[Required] The name of the SKU. Ex - P3. It is typically a letter+number code.")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  name: string;

  @doc("This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.")
  tier?: SkuTier;
}

@doc("Node scaling setting for the compute sku.")
union SkuScaleType {
  string,

  @doc("Automatically scales node count.")
  Automatic: "Automatic",

  @doc("Node count scaled upon user request.")
  Manual: "Manual",

  @doc("Fixed set of nodes.")
  None: "None",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Base definition for an asset.")
model AssetBase extends ResourceBase {
  @doc("If the name version are system generated (anonymous registration).")
  @visibility("read", "create")
  isAnonymous?: boolean;

  @doc("Is the asset archived?")
  @visibility("read", "create", "update")
  isArchived?: boolean;
}

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",

  @doc("URI folder.")
  uri_folder: "uri_folder",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("AssetContainer definition")
model AssetContainer extends ResourceBase {
  @doc("Is the asset archived?")
  @visibility("read", "create", "update")
  isArchived?: boolean;

  @doc("The latest version inside this container.")
  @visibility("read")
  latestVersion?: string;

  @doc("The next auto incremental version")
  @visibility("read")
  nextVersion?: string;
}

@doc("ResourceBase definition")
model ResourceBase {
  @doc("A unique identifier for the asset")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("System data of the resource")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Publishing destination registry asset information")
model DestinationAsset {
  @doc("Destination asset name")
  destinationName?: string;

  @doc("Destination asset version")
  destinationVersion?: string;

  @doc("Destination registry name")
  registryName?: string;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;
