import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;

namespace Microsoft.MachineLearningServices.ModelDataplane;

// ===== Unions (Enums) =====

/** Order string for sorting results. */
union OrderString {
  string,

  /** Sort by created time descending. */
  CreatedAtDesc: "CreatedAtDesc",

  /** Sort by created time ascending. */
  CreatedAtAsc: "CreatedAtAsc",

  /** Sort by updated time descending. */
  UpdatedAtDesc: "UpdatedAtDesc",

  /** Sort by updated time ascending. */
  UpdatedAtAsc: "UpdatedAtAsc",
}

/** List view type filter for models. */
union ListViewType {
  string,

  /** Active items only. */
  ActiveOnly: "ActiveOnly",

  /** Archived items only. */
  ArchivedOnly: "ArchivedOnly",

  /** All items. */
  All: "All",
}

/** Model format enumeration. */
union ModelFormatEnum {
  string,

  /** Custom model format. */
  CUSTOM: "CUSTOM",

  /** MLflow model format. */
  MLFLOW: "MLFLOW",

  /** Triton model format. */
  TRITON: "TRITON",

  /** Presets model format. */
  PRESETS: "PRESETS",
}

/** Data type for model schema fields. */
union ModelSchemaDataType {
  string,

  /** Undefined data type. */
  Undefined: "undefined",

  /** Boolean data type. */
  Bool: "bool",

  /** Unsigned 8-bit integer. */
  Uint8: "uint8",

  /** Unsigned 16-bit integer. */
  Uint16: "uint16",

  /** Unsigned 32-bit integer. */
  Uint32: "uint32",

  /** Unsigned 64-bit integer. */
  Uint64: "uint64",

  /** Signed 8-bit integer. */
  Int8: "int8",

  /** Signed 16-bit integer. */
  Int16: "int16",

  /** Signed 32-bit integer. */
  Int32: "int32",

  /** Signed 64-bit integer. */
  Int64: "int64",

  /** 16-bit floating point. */
  Float16: "float16",

  /** 32-bit floating point. */
  Float32: "float32",

  /** 64-bit floating point. */
  Float64: "float64",

  /** Brain 16-bit floating point. */
  Bfloat16: "bfloat16",

  /** 64-bit complex number. */
  Complex64: "complex64",

  /** 128-bit complex number. */
  Complex128: "complex128",

  /** String data type. */
  String: "string",
}

/** Compute environment type for service deployments. */
union ComputeEnvironmentType {
  string,

  /** Azure Container Service. */
  ACS: "ACS",

  /** Field-Programmable Gate Array. */
  FPGA: "FPGA",

  /** Azure Container Instances. */
  ACI: "ACI",

  /** Azure Kubernetes Service. */
  AKS: "AKS",

  /** Azure ML Compute. */
  AMLCOMPUTE: "AMLCOMPUTE",

  /** Internet of Things. */
  IOT: "IOT",

  /** Managed Inference Runtime. */
  MIR: "MIR",

  /** AKS Endpoint. */
  AKSENDPOINT: "AKSENDPOINT",

  /** MIR Single Model. */
  MIRSINGLEMODEL: "MIRSINGLEMODEL",

  /** MIR AML Compute. */
  MIRAMLCOMPUTE: "MIRAMLCOMPUTE",

  /** MIR GA. */
  MIRGA: "MIRGA",

  /** Azure Arc ML. */
  AMLARC: "AMLARC",

  /** Batch AML Compute. */
  BATCHAMLCOMPUTE: "BATCHAMLCOMPUTE",

  /** Unknown compute type. */
  UNKNOWN: "UNKNOWN",
}

/** Deployment type for services. */
union DeploymentType {
  string,

  /** gRPC real-time endpoint. */
  GRPCRealtimeEndpoint: "GRPCRealtimeEndpoint",

  /** HTTP real-time endpoint. */
  HttpRealtimeEndpoint: "HttpRealtimeEndpoint",

  /** Batch deployment. */
  Batch: "Batch",
}

/** Entity kind for index entities. */
union EntityKind {
  string,

  /** Invalid entity. */
  Invalid: "Invalid",

  /** Lineage root entity. */
  LineageRoot: "LineageRoot",

  /** Versioned entity. */
  Versioned: "Versioned",

  /** Unversioned entity. */
  Unversioned: "Unversioned",
}

/** Web service state. */
union WebServiceState {
  string,

  /** Service is transitioning. */
  Transitioning: "Transitioning",

  /** Service is healthy. */
  Healthy: "Healthy",

  /** Service is unhealthy. */
  Unhealthy: "Unhealthy",

  /** Service has failed. */
  Failed: "Failed",

  /** Service is unschedulable. */
  Unschedulable: "Unschedulable",
}

// ===== Models =====

/** An artifact reference within an asset. */
model Artifact {
  /** The artifact identifier. */
  id?: string;

  /** The artifact prefix. */
  prefix?: string;
}

/** An asset in the model registry. */
model Asset {
  /** The asset identifier. */
  id?: string;

  /** The asset name. */
  name: string;

  /** The asset type. */
  type?: string;

  /** The asset description. */
  description?: string;

  /** The list of artifacts associated with the asset. */
  artifacts?: Artifact[];

  /** Key-value tags for the asset. */
  kvTags?: Record<string>;

  /** Properties of the asset. */
  properties?: Record<string>;

  /** The run identifier associated with the asset. */
  runid?: string;

  /** The project identifier associated with the asset. */
  projectid?: string;

  /** Metadata for the asset. */
  meta?: Record<string>;

  /** The time the asset was created. */
  createdTime?: utcDateTime;
}

/** Paginated result of assets. */
model AssetPaginatedResult {
  /** The list of assets. */
  @pageItems
  value?: Asset[];

  /** The continuation token for the next page. */
  continuationToken?: string;

  /** The link to the next page. */
  nextLink?: string;
}

/** A blob storage reference. */
model BlobReference {
  /** The blob URI. */
  blobUri?: url;

  /** The storage account ARM identifier. */
  storageAccountArmId?: string;
}

/** A data reference credential. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
model DataReferenceCredentialDto {
  /** The credential type. */
  credentialType?: string;

  ...Record<string>;
}

/** A blob reference for consumption with credentials. */
model BlobReferenceForConsumptionDto {
  /** The blob URI. */
  blobUri?: url;

  /** The storage account ARM identifier. */
  storageAccountArmId?: string;

  /** The credential for accessing the blob. */
  credential?: DataReferenceCredentialDto;
}

/** An image registry reference. */
model ImageReference {
  /** The image registry reference string. */
  imageRegistryReference?: string;
}

/** An image registry reference for consumption with credentials. */
model ImageReferenceForConsumptionDto {
  /** The image registry reference string. */
  imageRegistryReference?: string;

  /** The credential for accessing the image. */
  credential?: DataReferenceCredentialDto;
}

/** Data references containing blob and image registry references. */
model DataReferences {
  /** Blob references keyed by name. */
  blobReferences?: Record<BlobReference>;

  /** Image registry references keyed by name. */
  imageRegistryReferences?: Record<ImageReference>;
}

/** Data references for consumption with credentials. */
model DataReferencesForConsumptionDto {
  /** Blob references for consumption keyed by name. */
  blobReferences?: Record<BlobReferenceForConsumptionDto>;

  /** Image registry references for consumption keyed by name. */
  imageRegistryReferences?: Record<ImageReferenceForConsumptionDto>;
}

/** A data item. */
model DataItem {
  /** The data value. */
  data?: string;
}

/** A dependent asset reference. */
model DependentAsset {
  /** The dependent asset identifier. */
  assetId?: string;
}

/** Intellectual property publisher information. */
model IntellectualPropertyPublisherInformation {
  /** The intellectual property publisher. */
  intellectualPropertyPublisher?: string;
}

/** An asset data transfer object. */
model AssetDto {
  /** The asset identifier. */
  assetId?: string;

  /** The entity identifier. */
  entityId?: string;

  /** Data items keyed by name. */
  dataItems?: Record<DataItem>;

  /** Data references for the asset. */
  dataReferences?: DataReferences;

  /** Whether the asset should be indexed. */
  shouldIndex?: boolean;

  /** The list of dependent assets. */
  dependencies?: DependentAsset[];

  /** Intellectual property publisher information. */
  intellectualPropertyPublisherInformation?: IntellectualPropertyPublisherInformation;
}

/** Request DTO for batch resolving model URIs. */
model BatchGetResolvedUrisDto {
  /** The list of model identifiers to resolve. */
  values?: string[];
}

/** Response DTO for a model path. */
model ModelPathResponseDto {
  /** The resolved path. */
  path?: string;

  /** The type of the path. */
  type?: string;
}

/** Response DTO for batch resolved model URIs. */
model BatchModelPathResponseDto {
  /** The resolved model paths keyed by model identifier. */
  values?: Record<ModelPathResponseDto>;
}

/** Container resource requirements for model deployment. */
model ContainerResourceRequirements {
  /** CPU cores requested. */
  cpu?: float64;

  /** CPU cores limit. */
  cpuLimit?: float64;

  /** Memory in GB requested. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  memoryInGB?: float64;

  /** Memory in GB limit. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  memoryInGBLimit?: float64;

  /** Whether GPU is enabled. */
  gpuEnabled?: boolean;

  /** Number of GPUs. */
  gpu?: int32;

  /** Number of FPGAs. */
  fpga?: int32;
}

/** Information about who created a resource. */
model CreatedBy {
  /** The user object identifier. */
  userObjectId?: string;

  /** The user tenant identifier. */
  userTenantId?: string;

  /** The user name. */
  userName?: string;
}

/** DTO for creating an unregistered input model. */
model CreateUnregisteredInputModelDto {
  /** The run identifier. */
  runId?: string;

  /** The input name. */
  inputName?: string;

  /** The path to the model. */
  path?: url;

  /** The type of the model. */
  type?: string;
}

/** DTO for creating an unregistered output model. */
model CreateUnregisteredOutputModelDto {
  /** The run identifier. */
  runId?: string;

  /** The output name. */
  outputName?: string;

  /** The path to the model. */
  path?: url;

  /** The type of the model. */
  type?: string;
}

/** Context information about resource creation. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
model CreationContext {
  /** The time the resource was created. */
  createdTime?: utcDateTime;

  /** Information about who created the resource. */
  createdBy?: CreatedBy;

  /** The creation source. */
  creationSource?: string;

  ...Record<string>;
}

/** A dataset reference. */
model DatasetReference {
  /** The dataset name. */
  name?: string;

  /** The dataset identifier. */
  id?: string;
}

/** A dependency map containing dependency items. */
model DependencyMapDto {
  /** The list of dependency items. */
  dependencies?: DependencyMapItemDto[];
}

/** A dependency map item linking source to destination. */
model DependencyMapItemDto {
  /** The source identifier. */
  sourceId?: string;

  /** The destination identifier. */
  destinationId?: string;
}

/** Dependent entities for an asset. */
model DependentEntitiesDto {
  /** The asset identifier. */
  assetId?: string;

  /** The list of dependent assets. */
  dependencies?: DependentAsset[];
}

/** Inner error detail information. */
model InnerErrorDetails {
  /** The error code. */
  code?: string;

  /** The error message. */
  message?: string;

  /** The error target. */
  target?: string;
}

/** Error response from the service. */
@clientName("ModelErrorResponse")
model ErrorResponse {
  /** The error code. */
  code?: string;

  /** The HTTP status code. */
  statusCode?: int32;

  /** The error message. */
  message?: string;

  /** The error target. */
  target?: string;

  /** The list of inner error details. */
  details?: InnerErrorDetails[];

  /** Correlation information for the error. */
  correlation?: Record<string>;
}

/** An extensible object that allows additional properties. */
model ExtensibleObject {
  ...Record<string>;
}

/** A user identity. */
model User {
  /** The user object identifier. */
  userObjectId?: string;

  /** The user PUID. */
  userPuId?: string;

  /** The user identity provider. */
  userIdp?: string;

  /** The user alternate security identifier. */
  userAltSecId?: string;

  /** The user issuer. */
  userIss?: string;

  /** The user tenant identifier. */
  userTenantId?: string;

  /** The user name. */
  userName?: string;

  /** The user principal name. */
  upn?: string;
}

/** Schema definition for model inputs and outputs. */
model ModelSchema {
  /** The schema field name. */
  name: string;

  /** The data type of the schema field. */
  dataType?: ModelSchemaDataType;

  /** The shape of the data. */
  shape?: int32[];
}

/** Model deployment settings. */
model ModelDeploymentSettings {
  /** The model format. */
  modelFormat: ModelFormatEnum;

  /** The model name. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  ModelName?: string;

  /** The model version. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  ModelVersion?: string;

  /** The model type. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  ModelType?: string;
}

/** A machine learning model. */
model Model {
  /** The model identifier. */
  id?: string;

  /** The model name. */
  name: string;

  /** The framework used to create the model. */
  framework?: string;

  /** The framework version. */
  frameworkVersion?: string;

  /** The model version number. */
  version?: int64;

  /** Tags associated with the model. */
  tags?: string[];

  /** Dataset references used by the model. */
  datasets?: DatasetReference[];

  /** The URL of the model. */
  url?: url;

  /** The MIME type of the model. */
  mimeType: string;

  /** The model description. */
  description?: string;

  /** The time the model was created. */
  createdTime?: utcDateTime;

  /** The time the model was last modified. */
  modifiedTime?: utcDateTime;

  /** Whether to unpack the model. */
  unpack?: boolean;

  /** The parent model identifier. */
  parentModelId?: string;

  /** The run identifier associated with the model. */
  runId?: string;

  /** The experiment name associated with the model. */
  experimentName?: string;

  /** Key-value tags for the model. */
  kvTags?: Record<string>;

  /** Properties of the model. */
  properties?: Record<string>;

  /** Identifiers of derived models. */
  derivedModelIds?: string[];

  /** Input schema definitions. */
  inputsSchema?: ModelSchema[];

  /** Output schema definitions. */
  outputsSchema?: ModelSchema[];

  /** Sample input data. */
  sampleInputData?: string;

  /** Sample output data. */
  sampleOutputData?: string;

  /** Container resource requirements for the model. */
  resourceRequirements?: ContainerResourceRequirements;

  /** The user who created the model. */
  createdBy?: User;

  /** The user who last modified the model. */
  modifiedBy?: User;

  /** Model flavors as nested key-value maps. */
  flavors?: Record<Record<string>>;

  /** The model format. */
  modelFormat?: ModelFormatEnum;

  /** The model stage. */
  stage?: string;

  /** The model container identifier. */
  modelContainerId?: string;

  /** The MMS identifier. */
  mmsId?: string;

  /** Default deployment settings for the model. */
  defaultDeploymentSettings?: ModelDeploymentSettings;

  /** Whether the model is anonymous. */
  isAnonymous?: boolean;

  /** Whether the model is archived. */
  isArchived?: boolean;

  /** Whether the model is registered. */
  isRegistered?: boolean;

  /** The data path of the model. */
  dataPath?: url;

  /** The model type. */
  modelType?: string;

  /** The asset identifier. */
  assetId?: string;

  /** Default deployment template for the model. */
  defaultDeploymentTemplate?: ModelDeploymentTemplateDetails;

  /** List of allowed deployment templates for the model. */
  allowedDeploymentTemplates?: ModelDeploymentTemplateDetails[];
}

/** Details of a deployment template reference. */
model ModelDeploymentTemplateDetails {
  /** The asset ID of the deployment template. */
  assetId?: string;
}

/** A service response. */
model ServiceResponseBase {
  /** The service identifier. */
  id?: string;

  /** The service name. */
  name?: string;

  /** The service description. */
  description?: string;

  /** Tags associated with the service. */
  tags?: string[];

  /** Key-value tags for the service. */
  kvTags?: Record<string>;

  /** Properties of the service. */
  properties?: Record<string>;

  /** The operation identifier. */
  operationId?: string;

  /** The state of the web service. */
  state?: WebServiceState;

  /** The time the service was created. */
  createdTime?: utcDateTime;

  /** The time the service was last updated. */
  updatedTime?: utcDateTime;

  /** Error information if the service encountered an error. */
  error?: ErrorResponse;

  /** The compute environment type. */
  computeType?: ComputeEnvironmentType;

  /** The deployment type. */
  deploymentType?: DeploymentType;

  /** The user who created the service. */
  createdBy?: User;

  /** The endpoint name. */
  endpointName?: string;
}

/** An extensive model with associated services and assets. */
model ExtensiveModel {
  /** The model. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  Model?: Model;

  /** The list of services associated with the model. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  ServiceList?: ServiceResponseBase[];

  /** The list of assets associated with the model. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  AssetList?: Asset[];
}

/** Index annotations for an entity. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
model IndexAnnotations {
  /** Whether the entity is archived. */
  archived?: boolean;

  /** Tags for the entity. */
  tags?: Record<string>;

  ...Record<string>;
}

/** Index properties for an entity. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
model IndexProperties {
  /** The creation context. */
  creationContext?: CreationContext;

  ...Record<string>;
}

/** A relationship between entities. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
model Relationship {
  /** The relation type. */
  relationType?: string;

  /** The target entity identifier. */
  targetEntityId?: string;

  /** The asset identifier. */
  assetId?: string;

  /** The entity type. */
  @visibility(Lifecycle.Read)
  entityType?: string;

  /** The direction of the relationship. */
  direction?: string;

  /** The entity container identifier. */
  @visibility(Lifecycle.Read)
  entityContainerId?: string;

  ...Record<string>;
}

/** An index entity. */
model IndexEntity {
  /** The schema identifier. */
  schemaId?: string;

  /** The entity identifier. */
  entityId?: string;

  /** The entity kind. */
  kind?: EntityKind;

  /** The index annotations. */
  annotations?: IndexAnnotations;

  /** The index properties. */
  properties?: IndexProperties;

  /** Internal extensible data. */
  internal?: ExtensibleObject;

  /** The update sequence number. */
  updateSequence?: int64;

  /** The entity type. */
  type?: string;

  /** The entity version. */
  @visibility(Lifecycle.Read)
  version?: string;

  /** The entity container identifier. */
  @visibility(Lifecycle.Read)
  entityContainerId?: string;

  /** The entity object identifier. */
  @visibility(Lifecycle.Read)
  entityObjectId?: string;

  /** The resource type. */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /** The list of relationships. */
  relationships?: Relationship[];

  /** The asset identifier. */
  assetId?: string;
}

/** A feed index entity DTO. */
model FeedIndexEntityDto {
  /** The index entity. */
  indexEntity?: IndexEntity;

  /** The schema identifier. */
  schemaId?: string;

  /** The entity schema. */
  entitySchema?: string;
}

/** A feed index entity request DTO. */
model FeedIndexEntityRequestDto {
  /** The feed entity. */
  feedEntity?: AssetDto;

  /** Label to version mapping. */
  labelToVersionMapping?: Record<string>;
}

/** Request body for listing models. */
model ListModelsRequest {
  /** Filter by model name. */
  name?: string;

  /** Filter by tag. */
  tag?: string;

  /** Filter by version. */
  version?: string;

  /** Filter by framework. */
  framework?: string;

  /** Filter by description. */
  description?: string;

  /** Number of results to return. */
  count?: int32;

  /** Offset for pagination. */
  offset?: int32;

  /** Skip token for pagination. */
  skipToken?: string;

  /** Filter by tags string. */
  tags?: string;

  /** Filter by properties string. */
  properties?: string;

  /** Filter by run identifier. */
  runId?: string;

  /** Filter by dataset identifier. */
  datasetId?: string;

  /** Order by expression. */
  orderBy?: OrderString;

  /** Whether to return only the latest version. */
  latestVersionOnly?: boolean;

  /** Filter by modified after date. */
  modifiedAfter?: utcDateTime;

  /** Filter by modified before date. */
  modifiedBefore?: utcDateTime;

  /** The list view type filter. */
  listViewType?: ListViewType;
}

/** Paginated response of models. */
model ModelPagedResponse {
  /** The list of models. */
  @pageItems
  value?: Model[];

  /** The continuation token for the next page. */
  continuationToken?: string;

  /** The link to the next page. */
  nextLink?: string;
}

/** Paginated response of models with next request. */
model ModelListModelsRequestPagedResponse {
  /** The list of models. */
  @pageItems
  value?: Model[];

  /** The link to the next page. */
  nextLink?: string;

  /** The continuation token for the next page. */
  continuationToken?: string;

  /** The next request for pagination. */
  nextRequest?: ListModelsRequest;
}

/** Batch query DTO for models. */
model ModelBatchDto {
  /** The list of model identifiers to query. */
  modelIds?: string[];
}

/** Batch response DTO for models. */
model ModelBatchResponseDto {
  /** The models keyed by identifier. */
  models?: Record<Model>;
}

/** Model container request. */
model ModelContainerRequest {
  /** The container name. */
  name: string;

  /** The container description. */
  description?: string;

  /** Key-value tags for the container. */
  kvTags?: Record<string>;

  /** Whether the container is archived. */
  isArchived?: boolean;

  /** Whether the container is registered. */
  isRegistered?: boolean;
}

/** Model settings identifiers for deployment. */
model ModelSettingsIdentifiers {
  /** The model identifier. */
  modelId?: string;

  /** The engine identifier. */
  engineId?: string;
}

/** A JSON Patch operation. */
model PatchOperation {
  /** The value to apply. */
  value?: string;

  /** The path to the property to modify. */
  path?: string;

  /** The operation type (e.g., add, remove, replace). */
  @encodedName("application/json", "op")
  operationType?: string;

  /** The source path for move or copy operations. */
  @encodedName("application/json", "from")
  fromPath?: string;
}

/** A provider feed entity request DTO. */
model ProviderFeedEntityRequestDto {
  /** Source and target asset identifiers. */
  sourceAndTargetAssetIds?: DependencyMapItemDto;

  /** The dependency map. */
  dependencyMapDto?: DependencyMapDto;

  /** Label to version mapping. */
  labelToVersionMapping?: Record<string>;
}
