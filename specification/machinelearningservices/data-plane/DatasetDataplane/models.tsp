import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.MachineLearningServices.DatasetDataplane;

// ─── Enums (as unions for modelAsString compatibility) ───

/** The type of dataflow serialization. */
union DataflowType {
  string,

  /** JSON format. */
  Json: "Json",

  /** YAML format. */
  Yaml: "Yaml",
}

/** The field type for data columns. */
union FieldType {
  string,

  /** String type. */
  String: "String",

  /** Boolean type. */
  Boolean: "Boolean",

  /** Integer type. */
  Integer: "Integer",

  /** Decimal type. */
  Decimal: "Decimal",

  /** Date type. */
  Date: "Date",

  /** Unknown type. */
  Unknown: "Unknown",

  /** Error type. */
  Error: "Error",

  /** Null type. */
  Null: "Null",

  /** DataRow type. */
  DataRow: "DataRow",

  /** List type. */
  List: "List",

  /** Stream type. */
  Stream: "Stream",
}

/** The HTTP status code. */
union HttpStatusCode {
  string,

  /** Continue status code. */
  Continue: "Continue",

  /** SwitchingProtocols status code. */
  SwitchingProtocols: "SwitchingProtocols",

  /** Processing status code. */
  Processing: "Processing",

  /** EarlyHints status code. */
  EarlyHints: "EarlyHints",

  /** OK status code. */
  OK: "OK",

  /** Created status code. */
  Created: "Created",

  /** Accepted status code. */
  Accepted: "Accepted",

  /** NonAuthoritativeInformation status code. */
  NonAuthoritativeInformation: "NonAuthoritativeInformation",

  /** NoContent status code. */
  NoContent: "NoContent",

  /** ResetContent status code. */
  ResetContent: "ResetContent",

  /** PartialContent status code. */
  PartialContent: "PartialContent",

  /** MultiStatus status code. */
  MultiStatus: "MultiStatus",

  /** AlreadyReported status code. */
  AlreadyReported: "AlreadyReported",

  /** IMUsed status code. */
  IMUsed: "IMUsed",

  /** Ambiguous status code. */
  Ambiguous: "Ambiguous",

  /** Moved status code. */
  Moved: "Moved",

  /** Redirect status code. */
  Redirect: "Redirect",

  /** RedirectMethod status code. */
  RedirectMethod: "RedirectMethod",

  /** NotModified status code. */
  NotModified: "NotModified",

  /** UseProxy status code. */
  UseProxy: "UseProxy",

  /** Unused status code. */
  Unused: "Unused",

  /** TemporaryRedirect status code. */
  TemporaryRedirect: "TemporaryRedirect",

  /** PermanentRedirect status code. */
  PermanentRedirect: "PermanentRedirect",

  /** BadRequest status code. */
  BadRequest: "BadRequest",

  /** Unauthorized status code. */
  Unauthorized: "Unauthorized",

  /** PaymentRequired status code. */
  PaymentRequired: "PaymentRequired",

  /** Forbidden status code. */
  Forbidden: "Forbidden",

  /** NotFound status code. */
  NotFound: "NotFound",

  /** MethodNotAllowed status code. */
  MethodNotAllowed: "MethodNotAllowed",

  /** NotAcceptable status code. */
  NotAcceptable: "NotAcceptable",

  /** ProxyAuthenticationRequired status code. */
  ProxyAuthenticationRequired: "ProxyAuthenticationRequired",

  /** RequestTimeout status code. */
  RequestTimeout: "RequestTimeout",

  /** Conflict status code. */
  Conflict: "Conflict",

  /** Gone status code. */
  Gone: "Gone",

  /** LengthRequired status code. */
  LengthRequired: "LengthRequired",

  /** PreconditionFailed status code. */
  PreconditionFailed: "PreconditionFailed",

  /** RequestEntityTooLarge status code. */
  RequestEntityTooLarge: "RequestEntityTooLarge",

  /** RequestUriTooLong status code. */
  RequestUriTooLong: "RequestUriTooLong",

  /** UnsupportedMediaType status code. */
  UnsupportedMediaType: "UnsupportedMediaType",

  /** RequestedRangeNotSatisfiable status code. */
  RequestedRangeNotSatisfiable: "RequestedRangeNotSatisfiable",

  /** ExpectationFailed status code. */
  ExpectationFailed: "ExpectationFailed",

  /** MisdirectedRequest status code. */
  MisdirectedRequest: "MisdirectedRequest",

  /** UnprocessableEntity status code. */
  UnprocessableEntity: "UnprocessableEntity",

  /** Locked status code. */
  Locked: "Locked",

  /** FailedDependency status code. */
  FailedDependency: "FailedDependency",

  /** UpgradeRequired status code. */
  UpgradeRequired: "UpgradeRequired",

  /** PreconditionRequired status code. */
  PreconditionRequired: "PreconditionRequired",

  /** TooManyRequests status code. */
  TooManyRequests: "TooManyRequests",

  /** RequestHeaderFieldsTooLarge status code. */
  RequestHeaderFieldsTooLarge: "RequestHeaderFieldsTooLarge",

  /** UnavailableForLegalReasons status code. */
  UnavailableForLegalReasons: "UnavailableForLegalReasons",

  /** InternalServerError status code. */
  InternalServerError: "InternalServerError",

  /** NotImplemented status code. */
  NotImplemented: "NotImplemented",

  /** BadGateway status code. */
  BadGateway: "BadGateway",

  /** ServiceUnavailable status code. */
  ServiceUnavailable: "ServiceUnavailable",

  /** GatewayTimeout status code. */
  GatewayTimeout: "GatewayTimeout",

  /** HttpVersionNotSupported status code. */
  HttpVersionNotSupported: "HttpVersionNotSupported",

  /** VariantAlsoNegotiates status code. */
  VariantAlsoNegotiates: "VariantAlsoNegotiates",

  /** InsufficientStorage status code. */
  InsufficientStorage: "InsufficientStorage",

  /** LoopDetected status code. */
  LoopDetected: "LoopDetected",

  /** NotExtended status code. */
  NotExtended: "NotExtended",

  /** NetworkAuthenticationRequired status code. */
  NetworkAuthenticationRequired: "NetworkAuthenticationRequired",
}

/** The HTTP version policy. */
union HttpVersionPolicy {
  string,

  /** Request version or lower. */
  RequestVersionOrLower: "RequestVersionOrLower",

  /** Request version or higher. */
  RequestVersionOrHigher: "RequestVersionOrHigher",

  /** Request version exact. */
  RequestVersionExact: "RequestVersionExact",
}

/** The type of stored procedure parameter. */
union StoredProcedureParameterType {
  string,

  /** String type. */
  String: "String",

  /** Int type. */
  Int: "Int",

  /** Decimal type. */
  Decimal: "Decimal",

  /** Guid type. */
  Guid: "Guid",

  /** Boolean type. */
  Boolean: "Boolean",

  /** Date type. */
  Date: "Date",
}

/** The semantic type for profiling. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
union SType {
  string,

  /** Email address. */
  EmailAddress: "EmailAddress",

  /** Geographic coordinate. */
  GeographicCoordinate: "GeographicCoordinate",

  /** IPv4 address. */
  Ipv4Address: "Ipv4Address",

  /** IPv6 address. */
  Ipv6Address: "Ipv6Address",

  /** US phone number. */
  UsPhoneNumber: "UsPhoneNumber",

  /** Zip code. */
  ZipCode: "ZipCode",
}

// ─── Models ───

/** The result of a profile action. */
model ActionResult {
  /** Whether the data is up to date. */
  isUpToDate?: boolean;

  /** Error if up-to-date check failed. */
  isUpToDateError?: string;

  /** The result artifact IDs. */
  resultArtifactIds?: string[];

  /** The in-progress action ID. */
  inProgressActionId?: string;

  /** The run ID. */
  runId?: string;

  /** The experiment name. */
  experimentName?: string;

  /** The datastore name. */
  datastoreName?: string;
}

/** An asset identifier. */
model AssetId {
  /** The asset ID value. */
  value: string;
}

/** Batch response containing resolved data URIs. */
model BatchDataUriResponse {
  /** Map of resolved data URIs. */
  values?: Record<DataUriV2Response>;
}

/** Request to batch-resolve data URIs. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
model BatchGetResolvedURIs {
  /** The list of URIs to resolve. */
  values: string[];
}

/** A column definition for a data view schema. */
model ColumnDefinition {
  /** The column ID. */
  id?: string;

  /** The column field type. */
  type?: FieldType;
}

/** Request to create unregistered input data. */
model CreateUnregisteredInputData {
  /** The run ID. */
  runId: string;

  /** The input name. */
  inputName: string;

  /** The data URI. */
  uri: string;

  /** The data type. */
  type: string;
}

/** Request to create unregistered output data. */
model CreateUnregisteredOutputData {
  /** The run ID. */
  runId: string;

  /** The output name. */
  outputName: string;

  /** The data URI. */
  uri: string;

  /** The data type. */
  type: string;
}

/** Request for data call operations (preview, profile, schema). */
model DataCallRequest {
  /** The data URI. */
  dataUri?: string;

  /** The data type. */
  dataType?: string;

  /** The asset ID. */
  assetId?: string;

  /** The data container name. */
  dataContainerName?: string;

  /** The version ID. */
  versionId?: string;
}

/** A data container definition. */
model DataContainer {
  /** The name of the data container. */
  name: string;

  /** The data type. */
  dataType: string;

  /** Mutable properties. */
  mutableProps?: DataContainerMutable;

  /** Whether the data container is registered. */
  isRegistered?: boolean;
}

/** A data container entity with metadata. */
model DataContainerEntity {
  /** The data container. */
  dataContainer?: DataContainer;

  /** Entity metadata. */
  entityMetadata?: EntityMetadata;

  /** The latest version entity. */
  latestVersion?: DataVersionEntity;

  /** The next version ID. */
  nextVersionId?: string;

  /** The legacy dataset type. */
  legacyDatasetType?: string;
}

/** Mutable properties of a data container. */
model DataContainerMutable {
  /** The description. */
  description?: string;

  /** Tags for the data container. */
  tags?: Record<string>;

  /** Whether the data container is archived. */
  isArchived?: boolean;
}

/** A data field value. */
model DataField {
  /** The field type. */
  type?: FieldType;

  /** The field value. */
  value?: string;
}

/** A resolved data URI response. */
model DataUriV2Response {
  /** The URI. */
  uri?: string;

  /** The data type. */
  type?: string;
}

/** A data version definition. */
model DataVersion {
  /** The asset ID. */
  assetId?: string;

  /** The data container name. */
  dataContainerName: string;

  /** The data type. */
  dataType: string;

  /** The data URI. */
  dataUri: string;

  /** The version ID. */
  versionId: string;

  /** Mutable properties. */
  mutableProps?: DataVersionMutable;

  /** Referenced data URIs. */
  referencedDataUris?: string[];

  /** Additional properties. */
  properties?: Record<string>;
}

/** A data version entity with metadata. */
model DataVersionEntity {
  /** The data version. */
  dataVersion?: DataVersion;

  /** Entity metadata. */
  entityMetadata?: EntityMetadata;
}

/** Mutable properties of a data version. */
model DataVersionMutable {
  /** The data expiry time. */
  dataExpiryTime?: utcDateTime;

  /** The description. */
  description?: string;

  /** Tags for the data version. */
  tags?: Record<string>;

  /** Whether the data version is archived. */
  isArchived?: boolean;
}

/** The result of a data view set operation. */
model DataViewSetResult {
  /** The schema columns. */
  schema?: ColumnDefinition[];

  /** The data rows. */
  rows?: DataField[][];
}

/** A dataset (v1). */
model Dataset {
  /** The dataset ID. */
  datasetId?: string;

  /** The dataset state. */
  datasetState?: DatasetState;

  /** The latest definition. */
  latest?: DatasetDefinition;

  /** The next version ID. */
  nextVersionId?: string;

  /** The created time. */
  createdTime?: utcDateTime;

  /** The modified time. */
  modifiedTime?: utcDateTime;

  /** The ETag. */
  etag?: Azure.Core.eTag;

  /** The dataset name. */
  name?: string;

  /** The description. */
  description?: string;

  /** Tags for the dataset. */
  tags?: Record<string>;

  /** Whether the dataset is visible. */
  isVisible?: boolean;

  /** The default compute target. */
  defaultCompute?: string;

  /** The dataset type. */
  datasetType?: string;
}

/** A dataset definition. */
model DatasetDefinition {
  /** The dataset ID. */
  datasetId?: string;

  /** The version ID. */
  versionId?: string;

  /** The dataset definition state. */
  datasetDefinitionState?: DatasetState;

  /** The dataflow. */
  dataflow?: string;

  /** The dataflow type. */
  dataflowType?: DataflowType;

  /** The data path. */
  dataPath?: DatasetPath;

  /** The partition format in path. */
  partitionFormatInPath?: string;

  /** The profile action result. */
  profileActionResult?: ProfileActionResult;

  /** Notes for the definition. */
  notes?: string;

  /** The ETag. */
  etag?: Azure.Core.eTag;

  /** The created time. */
  createdTime?: utcDateTime;

  /** The modified time. */
  modifiedTime?: utcDateTime;

  /** The data expiry time. */
  dataExpiryTime?: utcDateTime;

  /** The user who created this definition. */
  createdBy?: User;

  /** The user who last modified this definition. */
  modifiedBy?: User;

  /** The file type. */
  fileType?: string;

  /** Additional properties. */
  properties?: Record<string>;

  /** The saved dataset ID. */
  savedDatasetId?: string;

  /** Telemetry information. */
  telemetryInfo?: Record<string>;

  /** Whether to use description and tags from definition. */
  useDescriptionTagsFromDefinition?: boolean;

  /** The description. */
  description?: string;

  /** Tags for the definition. */
  tags?: Record<string>;
}

/** A dataset definition reference. */
model DatasetDefinitionReference {
  /** The dataset ID. */
  datasetId?: string;

  /** The definition version. */
  definitionVersion?: string;
}

/** A dataset path. */
model DatasetPath {
  /** The datastore name. */
  datastoreName?: string;

  /** The relative path. */
  relativePath?: string;

  /** The Azure file path. */
  azureFilePath?: string;

  /** The list of paths. */
  paths?: string[];

  /** The SQL data path. */
  sqlDataPath?: SqlDataPath;

  /** The HTTP URL. */
  httpUrl?: string;

  /** Additional properties. */
  additionalProperties?: Record<string>;

  /** The partition format. */
  partitionFormat?: string;

  /** Whether to ignore partition format errors. */
  partitionFormatIgnoreError?: boolean;
}

/** The state of a dataset. */
model DatasetState {
  /** The state value. */
  state?: string;

  /** The definition that deprecated this dataset. */
  deprecatedBy?: DatasetDefinitionReference;

  /** The ETag. */
  etag?: Azure.Core.eTag;
}

/** A dataset (v2). */
model DatasetV2 {
  /** The dataset ID. */
  datasetId?: string;

  /** The dataset name. */
  name?: string;

  /** The version ID. */
  versionId?: string;

  /** The dataflow. */
  dataflow?: string;

  /** The created time. */
  createdTime?: utcDateTime;

  /** The modified time. */
  modifiedTime?: utcDateTime;

  /** The user who created this dataset. */
  createdBy?: User;

  /** The user who last modified this dataset. */
  modifiedBy?: User;

  /** Properties. */
  properties?: Record<string>;

  /** Telemetry information. */
  telemetryInfo?: Record<string>;

  /** The description. */
  description?: string;

  /** Whether the dataset is anonymous. */
  isAnonymous?: boolean;

  /** Tags for the dataset. */
  tags?: Record<string>;

  /** Legacy properties. */
  legacyProperties?: Record<string>;

  /** The data expiry time. */
  dataExpiryTime?: utcDateTime;

  /** Legacy data. */
  legacy?: Record<string>;
}

/** Entity metadata. */
model EntityMetadata {
  /** The ETag. */
  etag?: Azure.Core.eTag;

  /** The created time. */
  createdTime?: utcDateTime;

  /** The modified time. */
  modifiedTime?: utcDateTime;

  /** The user who created the entity. */
  createdBy?: User;

  /** The user who last modified the entity. */
  modifiedBy?: User;
}

/** The resource management error additional info. */
model ErrorAdditionalInfo {
  /** The additional info type. */
  type?: string;

  /** The additional info. */
  info?: string;
}

/** The error response. */
@error
model ErrorResponse {
  /** The root error. */
  error?: RootError;

  /** Dictionary containing correlation details for the error. */
  correlation?: Record<string>;

  /** The hosting environment. */
  environment?: string;

  /** The Azure region. */
  location?: string;

  /** The time in UTC. */
  time?: utcDateTime;

  /** Component name where error originated/encountered. */
  componentName?: string;
}

/** A histogram bin for profile results. */
model HistogramBin {
  /** The lower bound. */
  lowerBound?: float64;

  /** The upper bound. */
  upperBound?: float64;

  /** The count. */
  count?: float64;
}

/** HTTP content. */
model HttpContent {
  /** The content headers. */
  @visibility(Lifecycle.Read)
  headers?: KeyValuePairStringIEnumerable[];
}

/** An HTTP method. */
model HttpMethod {
  /** The method name. */
  method?: string;
}

/** An HTTP request message. */
model HttpRequestMessage {
  /** The HTTP version. */
  version?: string;

  /** The version policy. */
  versionPolicy?: HttpVersionPolicy;

  /** The request content. */
  content?: HttpContent;

  /** The HTTP method. */
  method?: HttpMethod;

  /** The request URI. */
  requestUri?: url;

  /** The request headers. */
  @visibility(Lifecycle.Read)
  headers?: KeyValuePairStringIEnumerable[];

  /** The request options. */
  @visibility(Lifecycle.Read)
  options?: Record<string>;
}

/** An HTTP response message. */
model HttpResponseMessage {
  /** The HTTP version. */
  version?: string;

  /** The response content. */
  content?: HttpContent;

  /** The status code. */
  statusCode?: HttpStatusCode;

  /** The reason phrase. */
  reasonPhrase?: string;

  /** The response headers. */
  @visibility(Lifecycle.Read)
  headers?: KeyValuePairStringIEnumerable[];

  /** The trailing headers. */
  @visibility(Lifecycle.Read)
  trailingHeaders?: KeyValuePairStringIEnumerable[];

  /** The request message. */
  requestMessage?: HttpRequestMessage;

  /** Whether the status code indicates success. */
  @visibility(Lifecycle.Read)
  isSuccessStatusCode?: boolean;
}

/** A nested structure of errors. */
model InnerErrorResponse {
  /** The error code. */
  code?: string;

  /** The inner error. */
  innerError?: InnerErrorResponse;
}

/** A key-value pair where the value is a list of strings. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
model KeyValuePairStringIEnumerable {
  /** The key. */
  key?: string;

  /** The values. */
  value?: string[];
}

/** A long-running operation response. */
model LongRunningOperationResponse {
  /** The completion result. */
  completionResult?: string;

  /** The location URI. */
  location?: url;

  /** The operation result URI. */
  operationResult?: url;
}

/** Statistical moments for profile results. */
model Moments {
  /** The mean. */
  mean?: float64;

  /** The standard deviation. */
  standardDeviation?: float64;

  /** The variance. */
  variance?: float64;

  /** The skewness. */
  skewness?: float64;

  /** The kurtosis. */
  kurtosis?: float64;
}

/** A paginated list of DataContainerEntity objects. */
model PaginatedDataContainerEntityList {
  /** An array of objects of type DataContainerEntity. */
  @pageItems
  value?: DataContainerEntity[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of DataVersionEntity objects. */
model PaginatedDataVersionEntityList {
  /** An array of objects of type DataVersionEntity. */
  @pageItems
  value?: DataVersionEntity[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of DatasetDefinition objects. */
model PaginatedDatasetDefinitionList {
  /** An array of objects of type DatasetDefinition. */
  @pageItems
  value?: DatasetDefinition[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of Dataset objects. */
model PaginatedDatasetList {
  /** An array of objects of type Dataset. */
  @pageItems
  value?: Dataset[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of DatasetV2 objects. */
model PaginatedDatasetV2List {
  /** An array of objects of type DatasetV2. */
  @pageItems
  value?: DatasetV2[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of String objects. */
model PaginatedStringList {
  /** An array of objects of type String. */
  @pageItems
  value?: string[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** The profile action result. */
model ProfileActionResult {
  /** The profile action ID. */
  profileActionId?: string;

  /** The status. */
  status?: string;

  /** The completion time in UTC. */
  completedOnUtc?: utcDateTime;

  /** The action result. */
  actionResult?: ActionResult;
}

/** A profile result for a column. */
model ProfileResult {
  /** The column name. */
  columnName?: string;

  /** The column type. */
  type?: FieldType;

  /** The minimum value. */
  min?: DataField;

  /** The maximum value. */
  max?: DataField;

  /** The total count. */
  count?: int64;

  /** The missing count. */
  missingCount?: int64;

  /** The not-missing count. */
  notMissingCount?: int64;

  /** The percent missing. */
  percentMissing?: float64;

  /** The error count. */
  errorCount?: int64;

  /** The empty count. */
  emptyCount?: int64;

  /** The quantiles. */
  quantiles?: Quantiles;

  /** The whisker top value. */
  whiskerTop?: float64;

  /** The whisker bottom value. */
  whiskerBottom?: float64;

  /** The statistical moments. */
  moments?: Moments;

  /** The type counts. */
  typeCounts?: TypeCount[];

  /** The value counts. */
  valueCounts?: ValueCount[];

  /** The number of unique values. */
  uniqueValues?: int64;

  /** The histogram bins. */
  histogram?: HistogramBin[];

  /** The semantic type counts. */
  sTypeCounts?: STypeCount[];

  /** The average spaces count. */
  averageSpacesCount?: float64;

  /** The string lengths. */
  stringLengths?: StringLengthCount[];
}

/** Quantile values for profile results. */
model Quantiles {
  /** The 0.1 percentile. */
  p0D1?: float64;

  /** The 1st percentile. */
  p1?: float64;

  /** The 5th percentile. */
  p5?: float64;

  /** The 25th percentile. */
  p25?: float64;

  /** The 50th percentile (median). */
  p50?: float64;

  /** The 75th percentile. */
  p75?: float64;

  /** The 95th percentile. */
  p95?: float64;

  /** The 99th percentile. */
  p99?: float64;

  /** The 99.9 percentile. */
  p99D9?: float64;
}

/** Request to register existing data as a named data asset. */
model RegisterExistingData {
  /** The existing unregistered asset ID. */
  existingUnregisteredAssetId: string;

  /** The name. */
  name: string;

  /** The version. */
  version?: string;
}

/** The root error. */
model RootError {
  /** The service-defined error code. */
  code?: string;

  /** The severity of error. */
  severity?: int32;

  /** A human-readable representation of the error. */
  message?: string;

  /** An unformatted version of the message with no variable substitution. */
  messageFormat?: string;

  /** Value substitutions corresponding to the contents of MessageFormat. */
  messageParameters?: Record<string>;

  /** Reference code to classify the problem. */
  referenceCode?: string;

  /** A URI which points to more details about the context of the error. */
  detailsUri?: url;

  /** The target of the error. */
  target?: string;

  /** The related errors that occurred during the request. */
  details?: RootError[];

  /** The inner error. */
  innerError?: InnerErrorResponse;

  /** The error additional info. */
  additionalInfo?: ErrorAdditionalInfo[];
}

/** A SQL data path. */
model SqlDataPath {
  /** The SQL table name. */
  sqlTableName?: string;

  /** The SQL query. */
  sqlQuery?: string;

  /** The SQL stored procedure name. */
  sqlStoredProcedureName?: string;

  /** The SQL stored procedure parameters. */
  sqlStoredProcedureParams?: StoredProcedureParameter[];

  /** The query timeout in seconds. */
  queryTimeout?: int64;
}

/** A stored procedure parameter. */
model StoredProcedureParameter {
  /** The parameter name. */
  name?: string;

  /** The parameter value. */
  value?: string;

  /** The parameter type. */
  type?: StoredProcedureParameterType;
}

/** A string length count for profile results. */
model StringLengthCount {
  /** The string length. */
  length?: int64;

  /** The count. */
  count?: int64;
}

/** A semantic type count for profile results. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
model STypeCount {
  /** The semantic type. */
  sType?: SType;

  /** The count. */
  count?: int64;
}

/** A type count for profile results. */
model TypeCount {
  /** The field type. */
  type?: FieldType;

  /** The count. */
  count?: int64;
}

/** A user or service principal identity. */
model User {
  /** A user or service principal's object ID. */
  userObjectId?: string;

  /** A user or service principal's PuID. */
  userPuId?: string;

  /** A user identity provider. */
  userIdp?: string;

  /** A user alternate sec id. */
  userAltSecId?: string;

  /** The issuer which issued the token for this user. */
  userIss?: string;

  /** A user or service principal's tenant ID. */
  userTenantId?: string;

  /** A user's full name or a service principal's app ID. */
  userName?: string;

  /** A user's principal name (UPN). */
  upn?: string;
}

/** A value count for profile results. */
model ValueCount {
  /** The value. */
  value?: DataField;

  /** The count. */
  count?: int64;
}
