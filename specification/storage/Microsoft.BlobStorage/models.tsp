import "@typespec/rest";
import "@typespec/http";
import "@typespec/xml";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Storage.Blob;

/** The error response. */
@error
model StorageError {
  /** The error message. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API"
  Message: string;
}

/// Models

/** The Block lookup list. */
@Xml.name("BlockList")
model BlockLookupList {
  /** The committed blocks */
  @Xml.unwrapped
  @Xml.name("Committed")
  committed: string[];

  /** The uncommitted blocks */
  @Xml.unwrapped
  @Xml.name("Uncommitted")
  uncommitted: string[];

  /** The latest blocks */
  @Xml.unwrapped
  @Xml.name("Latest")
  latest: string[];
}

/** Represents an array of signed identifiers */
alias SignedIdentifiers = Array<SignedIdentifier>;

/** The signed identifier. */
model SignedIdentifier {
  /** The unique ID for the signed identifier. */
  @Xml.name("Id") id: string;

  /** The access policy for the signed identifier. */
  @Xml.name("AccessPolicy") accessPolicy: AccessPolicy;
}

/** The result of a Filter Blobs API call */
model FilterBlobSegment {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The filter for the blobs. */
  @Xml.name("Where") where: string;

  /** The blob segment. */
  @Xml.name("Blobs") blobs: FilterBlobItem[];

  /** The next marker of the blobs. */
  @Xml.name("NextMarker") nextMarker?: string;
}

/** The filter blob item. */
@Xml.name("Blob")
model FilterBlobItem {
  /** The name of the blob. */
  @Xml.name("Name") name: string;

  /** The properties of the blob. */
  @Xml.name("ContainerName") containerName: string;

  /** The metadata of the blob. */
  @Xml.name("Tags") tags?: BlobTags;

  /** The version ID of the blob. */
  @Xml.name("VersionId") versionId?: string;

  /** Whether it is the current version of the blob */
  @Xml.name("IsCurrentVersion") isCurrentVersion?: boolean;
}

/** The filter blobs includes. */
union FilterBlobsIncludes {
  /** The filter includes no versions. */
  None: "none",

  /** The filter includes n versions. */
  Versions: "versions",

  /** Extensible */
  string,
}

/** The account kind. */
union AccountKind {
  /** The storage account is a general-purpose account. */
  Storage: "Storage",

  /** The storage account is a blob storage account. */
  BlobStorage: "BlobStorage",

  /** The storage account is a storage V2 account. */
  StorageV2: "StorageV2",

  /** The storage account is a file storage account. */
  FileStorage: "FileStorage",

  /** The storage account is a block blob storage account. */
  BlockBlobStorage: "BlockBlobStorage",

  /** Extensible */
  string,
}

/** The SKU types */
union SkuName {
  /** The standard LRS SKU. */
  StandardLRS: "Standard_LRS",

  /** The standard GRS SKU. */
  StandardGRS: "tandard_GRS",

  /** The standard RAGRS SKU. */
  StandardRAGRS: "Standard_RAGRS",

  /** The standard ZRS SKU. */
  StandardZRS: "Standard_ZRS",

  /** The premium LRS SKU. */
  PremiumLRS: "Premium_LRS",

  /** Extensible */
  string,
}

/** The list container segement response */
@Xml.name("EnumerationResults")
model ListContainersSegmentResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The prefix of the containers. */
  @Xml.name("Prefix") prefix?: string;

  /** The marker of the containers. */
  @Xml.name("Marker") marker?: string;

  /** The max results of the containers. */
  @Xml.name("MaxResults") maxxResults?: int32;

  /** The container segment. */
  @Xml.name("ContainerItems") containerItems: ContainerItem[];

  /** The next marker of the containers. */
  @Xml.name("NextMarker") nextMarker?: string;
}

/** An Azure Storage container. */
@Xml.name("Container")
model ContainerItem {
  /** The name of the container. */
  @Xml.name("Name") name: string;

  /** Whether the container is deleted. */
  @Xml.name("Deleted") delete?: boolean;

  /** The version of the container. */
  @Xml.name("Version") version?: string;

  /** The properties of the container. */
  @Xml.name("Properties") properties: ContainerProperties;

  /** The metadata of the container. */
  @Xml.name("Metadata") metadata?: ContainerMetadata;
}

/** The properties of a container. */
model ContainerProperties {
  /** The date-time the container was created in RFC1123 format. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("Creation-Time")
  creationTime?: utcDateTime;

  /** The date-time the container was last modified in RFC1123 format. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("Last-Modified")
  lastModified: utcDateTime;

  /** The ETag of the container. */
  @Xml.name("ETag") eTag: string;

  /** The lease status of the container. */
  @Xml.name("LeaseStatus") leaseStatus?: LeaseStatus;

  /** The lease state of the container. */
  @Xml.name("LeaseState") leaseState?: LeaseState;

  /** The lease duration of the container. */
  @Xml.name("LeaseDuration") leaseDuration?: LeaseDuration;

  /** The public access type of the container. */
  @Xml.name("PublicAccess") publicAccess?: PublicAccessType;

  /** Whether it has an immutability policy. */
  @Xml.name("HasImmutabilityPolicy") hasImmutabilityPolicy?: boolean;

  /** The default encryption scope of the container. */
  @Xml.name("DefaultEncryptionScope") defaultEncryptionScope?: string;

  /** Whether to prevent encryption scope override. */
  @Xml.name("DenyEncryptionScopeOverride")
  denyEncryptionScopeOverride?: boolean;

  /** The has legal hold status of the container. */
  @Xml.name("HasLegalHold") hasLegalHold?: boolean;

  /** The deleted time of the container. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("DeletedTime")
  deletedTime?: utcDateTime;

  /** The remaining retention days of the container. */
  @Xml.name("RemainingRetentionDays") remainingRetentionDays?: int32;

  /** Whether immutable storage with versioning is enabled. */
  @Xml.name("ImmutableStorageWithVersioningEnabled")
  immutableStorageWithVersioningEnabled?: boolean;
}

/** The metadata of a container. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API"
@Xml.name("Metadata")
model ContainerMetadata is Record<string> {
  /** Whether the metadata is encrypted. */
  @Xml.attribute
  @Xml.name("Encrypted")
  encrypted: string;
}

/** Stats for the storage service. */
model StorageServiceStats {
  /** The geo replication stats. */
  @Xml.name("GeoReplication") geoReplication: GeoReplication;
}

/** The geo replication status. */
model GeoReplication {
  /** The georeplication status. */
  @Xml.name("Status") status: GeoReplicationStatus;

  /** The last sync time. */
  @Xml.name("LastSyncTime") lastSyncTime: string;
}

/** The geo replication status. */
union GeoReplicationStatus {
  /** The geo replication is live. */
  Live: "live",

  /** The geo replication is bootstrap. */
  Bootstrap: "bootstrap",

  /** The geo replication is unavailable. */
  Unavailable: "unavailable",

  /** Extensible */
  string,
}

/** Key information */
model KeyInfo {
  /** The date-time the key is active. */
  @Xml.name("Start") start: string;

  /** The date-time the key expires. */
  @Xml.name("Expiry") expiry: string;
}

/** A user delegation key. */
model UserDelegationKey {
  /** The Azure Active Directory object ID in GUID format. */
  @Xml.name("SignedOid") signedOid: uuid;

  /** The Azure Active Directory tenant ID in GUID format. */
  @Xml.name("SignedTid") signedTid: uuid;

  /** The date-time the key is active. */
  @Xml.name("SignedStart") signedStart: string;

  /** The date-time the key expires. */
  @Xml.name("SignedExpiry") signedExpiry: string;

  /** Abbreviation of the Azure Storage service that accepts the key. */
  @Xml.name("SignedService") signedService: string;

  /** The service version that created the key. */
  @Xml.name("SignedVersion") signedVersion: string;

  /** The key as a base64 string. */
  @Xml.name("Value") value: string;
}

/** The public access types. */
union PublicAccessType {
  /** Blob access. */
  Blob: "blob",

  /** Container access. */
  Container: "container",

  /** Extensible */
  string,
}

/** The copy status. */
union CopyStatus {
  /** The copy operation is pending. */
  Pending: "pending",

  /** The copy operation succeeded. */
  Success: "success",

  /** The copy operation failed. */
  Failed: "failed",

  /** The copy operation is aborted. */
  Aborted: "aborted",

  /** Extensible */
  string,
}

/** The lease duration. */
union LeaseDuration {
  /** The lease is of infinite duration. */
  Infinite: "infinite",

  /** The lease is of fixed duration. */
  Fixed: "fixed",

  /** Extensible */
  string,
}

/** The lease state. */
union LeaseState {
  /** The lease is available. */
  Available: "available",

  /** The lease is currently leased. */
  Leased: "leased",

  /** The lease is expired. */
  Expired: "expired",

  /** The lease is breaking. */
  Breaking: "breaking",

  /** The lease is broken. */
  Broken: "broken",

  /** Extensible */
  string,
}

/** The lease status. */
union LeaseStatus {
  /** The lease is unlocked. */
  Unlocked: "unlocked",

  /** The lease is locked. */
  Locked: "locked",

  /** Extensible */
  string,
}

/** Represents an access policy. */
model AccessPolicy {
  /** The date-time the policy is active. */
  @Xml.name("Start") start: utcDateTime;

  /** The date-time the policy expires. */
  @Xml.name("Expiry") expiry: utcDateTime;

  /** The permissions for acl the policy. */
  @Xml.name("Permission") permission: string;
}

/** The access tiers. */
union AccessTier {
  /** The hot P4 tier. */
  P4: "P4",

  /** The hot P6 tier. */
  P6: "P6",

  /** The hot P10 tier. */
  P10: "P10",

  /** The hot P15 tier. */
  P15: "P15",

  /** The hot P20 tier. */
  P20: "P20",

  /** The hot P30 tier. */
  P30: "P30",

  /** The hot P40 tier. */
  P40: "P40",

  /** The hot P50 tier. */
  P50: "P50",

  /** The hot P60 tier. */
  P60: "P60",

  /** The hot P70 tier. */
  P70: "P70",

  /** The hot P80 tier. */
  P80: "P80",

  /** The hot access tier. */
  Hot: "Hot",

  /** The cool access tier. */
  Cool: "Cool",

  /** The archive access tier. */
  Archive: "Archive",

  /** Extensible */
  string,
}

/** The archive status. */
union ArchiveStatus {
  /** The archive status is rehydrating pending to hot. */
  RehydratePendingToHot: "rehydrate-pending-to-hot",

  /** The archive status is rehydrating pending to cool. */
  RehydratePendingToCool: "rehydrate-pending-to-cool",

  /** The archive status is rehydrating pending to archive. */
  RehydratePendingToArchive: "rehydrate-pending-to-archive",

  /** The archive status is rehydrating pending to expired. */
  RehydratePendingToExpired: "rehydrate-pending-to-expired",

  /** Extensible */
  string,
}

/** An Azure Storage Blob */
@Xml.name("Blob")
model BlobItemInternal {
  /** The name of the blob. */
  @Xml.name("Name") name: BlobName;

  /** Whether the blob is deleted. */
  @Xml.name("Deleted") deleted: boolean;

  /** The snapshot of the blob. */
  @Xml.name("Snapshot") snapshot: string;

  /** The version id of the blob. */
  @Xml.name("VersionId") versionId?: string;

  /** Whether the blob is the current version. */
  @Xml.name("IsCurrentVersion") isCurrentVersion?: boolean;

  /** The properties of the blob. */
  @Xml.name("Properties") properties: BlobPropertiesInternal;

  /** The metadata of the blob. */
  @Xml.name("Metadata") metadata?: BlobMetadata;

  /** The tags of the blob. */
  @Xml.name("BlobTags") blobTags?: BlobTag[];

  /** The object replication metadata of the blob. */
  @Xml.name("ObjectReplicationMetadata")
  objectReplicationMetadata?: ObjectReplicationMetadata;

  /** Whether the blog has versions only. */
  @Xml.name("HasVersionsOnly") hasVersionsOnly?: boolean;
}

/** The properties of a blob. */
@Xml.name("Properties")
model BlobPropertiesInternal {
  /** The date-time the blob was created in RFC1123 format. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("Creation-Time")
  creationTime?: utcDateTime;

  /** The date-time the blob was last modified in RFC1123 format. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("Last-Modified")
  lastModified: utcDateTime;

  /** The blog ETag. */
  @Xml.name("ETag") eTag: string;

  /** The content length of the blob. */
  @Xml.name("Content-Length") contentLength?: int64;

  /** The content type of the blob. */
  @Xml.name("Content-Type") contentType?: string;

  /** The content encoding of the blob. */
  @Xml.name("Content-Encoding") contentEncoding?: string;

  /** The content language of the blob. */
  @Xml.name("Content-Language") contentLanguage?: string;

  /** The content MD5 of the blob. */
  @Xml.name("Content-MD5") contentMd5?: string;

  /** The content disposition of the blob. */
  @Xml.name("Content-Disposition") contentDisposition?: string;

  /** The cache control of the blob. */
  @Xml.name("Cache-Control") cacheControl?: string;

  /** The sequence number of the blob. */
  @Xml.name("x-ms-blob-sequence-number") blobSequenceNumber?: int64;

  /** The blob type. */
  @Xml.name("BlobType") blobType?: BlobType;

  /** The lease status of the blob. */
  @Xml.name("LeaseStatus") leaseStatus?: LeaseStatus;

  /** The lease state of the blob. */
  @Xml.name("LeaseState") leaseState?: LeaseState;

  /** The lease duration of the blob. */
  @Xml.name("LeaseDuration") leaseDuration?: LeaseDuration;

  /** The copy ID of the blob. */
  @Xml.name("CopyId") copyId?: string;

  /** The copy status of the blob. */
  @Xml.name("CopyStatus") copyStatus?: CopyStatus;

  /** The copy source of the blob. */
  @Xml.name("CopySource") copySource?: string;

  /** The copy progress of the blob. */
  @Xml.name("CopyProgress") copyProgress?: string;

  /** The copy completion time of the blob. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("CopyCompletionTime")
  copyCompletionTime?: utcDateTime;

  /** The copy status description of the blob. */
  @Xml.name("CopyStatusDescription") copyStatusDescription?: string;

  /** Whether the blog is encrypted on the server. */
  @Xml.name("ServerEncrypted") serverEncrypted?: boolean;

  /** Whether the blog is incremental copy. */
  @Xml.name("IncrementalCopy") incrementalCopy?: boolean;

  /** The name of the desination snapshot. */
  @Xml.name("DestinationSnapshot") destinationSnapshot?: string;

  /** The time the blob was deleted. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("DeletedTime")
  deletedTime?: utcDateTime;

  /** The remaining retention days of the blob. */
  @Xml.name("RemainingRetentionDays") remainingRetentionDays?: int32;

  /** The access tier of the blob. */
  @Xml.name("AccessTier") accessTier?: AccessTier;

  /** Whether the access tier is inferred. */
  @Xml.name("AccessTierInferred") accessTierInferred?: boolean;

  /** The archive status of the blob. */
  @Xml.name("ArchiveStatus") archiveStatus?: ArchiveStatus;

  /** The encryption scope of the blob. */
  @Xml.name("EncryptionScope") encryptionScope?: string;

  /** The access tier change time of the blob. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("AccessTierChangeTime")
  accessTierChangeTime?: utcDateTime;

  /** The number of tags for the blob. */
  @Xml.name("TagCount") tagCount?: int32;

  /** The expire time of the blob. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("Expiry-Time")
  expiryTime?: utcDateTime;

  /** Whether the blob is sealed. */
  @Xml.name("Sealed")
  sealed?: boolean;

  /** The rehydrate priority of the blob. */
  @Xml.name("RehydratePriority") rehydratePriority?: RehydratePriority;

  /** The last access time of the blob. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("LastAccessTime")
  lastAccessTime?: utcDateTime;

  /** The immutability policy until time of the blob. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @Xml.name("ImmutabilityPolicyUntilDate")
  immutabilityPolicyUntilDate?: utcDateTime;

  /** The immutability policy mode of the blob. */
  @Xml.name("ImmutabilityPolicyMode")
  immutabilityPolicyMode?: BlobImmutabilityPolicyMode;

  /** Whether the blob is under legal hold. */
  @Xml.name("LegalHold") legalHold?: boolean;
}

/** The immutability policy mode. */
union BlobImmutabilityPolicyMode {
  /** The immutability policy is mutable. */
  Mutable: "Mutable",

  /** The immutability policy is locked. */
  Locked: "Locked",

  /** The immutability policy is unlocked. */
  Unlocked: "Unlocked",

  /** Extensible */
  string,
}

/** The blob type. */
union BlobType {
  /** The blob is a block blob. */
  BlockBlob: "BlockBlob",

  /** The blob is a page blob. */
  PageBlob: "PageBlob",

  /** The blob is an append blob. */
  AppendBlob: "AppendBlob",

  /** Extensible */
  string,
}

/** The rehydrate priority. */
@Xml.name("RehydratePriority")
union RehydratePriority {
  /** The rehydrate priority is high. */
  High: "High",

  /** The rehydrate priority is standard. */
  Standard: "Standard",

  /** Extensible */
  string,
}

/** The blob metadata. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API"
model BlobMetadata is Record<string> {
  /** Whether the blob metadata is encrypted. */
  @Xml.attribute
  @Xml.name("Encrypted")
  encrypted: string;
}

/** The blob tags. */
model BlobTag {
  /** The key of the tag. */
  @Xml.name("Key") key: string;

  /** The value of the tag. */
  @Xml.name("Value") value: string;
}

/** The object replication metadata. */
model ObjectReplicationMetadata is Record<string>;

/// Service Properties

/** The service properties. */
model StorageServiceProperties {
  /** The logging properties. */
  @Xml.name("Logging") logging?: Logging;

  /** The hour metrics properties. */
  @Xml.name("HourMetrics") hourMetrics?: Metrics;

  /** The minute metrics properties. */
  @Xml.name("MinuteMetrics") minuteMetrics?: Metrics;

  /** The CORS properties. */
  @Xml.name("Cors") cors?: CorsRule[];

  /** The default service version. */
  @Xml.name("DefaultServiceVersion") defaultServiceVersion?: string;

  /** The delete retention policy. */
  @Xml.name("DeleteRetentionPolicy") deleteRetentionPolicy?: RetentionPolicy;

  /** The static website properties. */
  @Xml.name("StaticWebsite") staticWebsite?: StaticWebsite;
}

/** The static website properties. */
model StaticWebsite {
  /** The index document. */
  @Xml.name("IndexDocument") indexDocument?: string;

  /** The error document. */
  @Xml.name("ErrorDocument") errorDocument?: string;
}

/** The CORS rule. */
model CorsRule {
  /** The allowed origins. */
  @Xml.name("AllowedOrigins") allowedOrigins: string;

  /** The allowed methods. */
  @Xml.name("AllowedMethods") allowedMethods: string;

  /** The allowed headers. */
  @Xml.name("AllowedHeaders") allowedHeaders: string;

  /** The exposed headers. */
  @Xml.name("ExposedHeaders") exposedHeaders: string;

  /** The maximum age in seconds. */
  @Xml.name("MaxAgeInSeconds") maxAgeInSeconds: int32;
}

/** The metrics properties. */
model Metrics {
  /** The version of the metrics properties. */
  @Xml.name("Version") version?: string;

  /** Whether it is enabled. */
  @Xml.name("Enabled") enabled: boolean;

  /** Whether to include API in the metrics. */
  @Xml.name("IncludeAPIs") includeApis?: boolean;

  /** The retention policy of the metrics. */
  @Xml.name("RetentionPolicy") retentionPolicy?: RetentionPolicy;

  /** The service properties of the metrics. */
  @Xml.name("ServiceProperties") serviceProperties?: MetricsServiceProperties;
}

/** The metrics service properties. */
model MetricsServiceProperties {
  /** The hour metrics properties. */
  @Xml.name("HourMetrics") hourMetrics: MetricsProperties;

  /** The minute metrics properties. */
  @Xml.name("MinuteMetrics") minuteMetrics: MetricsProperties;
}

/** The metrics properties. */
model MetricsProperties {
  /** Whether to include API in the metrics. */
  @Xml.name("Enabled") enabled: boolean;

  /** The version of the metrics properties. */
  @Xml.name("Version") version: string;

  /** The retention policy of the metrics. */
  @Xml.name("RetentionPolicy") retentionPolicy: RetentionPolicy;
}

/** The logging properties. */
model Logging {
  /** The version of the logging properties. */
  @Xml.name("Version") version: string;

  /** Whether delete operation is logged. */
  @Xml.name("Delete") delete: boolean;

  /** Whether read operation is logged. */
  @Xml.name("Read") read: boolean;

  /** Whether write operation is logged. */
  @Xml.name("Write") write: boolean;

  /** The retention policy of the logs. */
  @Xml.name("RetentionPolicy") retentionPolicy: RetentionPolicy;
}

/** The retention policy. */
model RetentionPolicy {
  /** Whether to enable the retention policy. */
  @Xml.name("Enabled") enabled: boolean;

  /** The number of days to retain the logs. */
  @Xml.name("Days") days: int32;

  /** Whether to allow permanent delete. */
  @Xml.name("AllowPermanentDelete") allowPermanentDelete: boolean;
}

// List Blobs

/** An enumeration of blobs. */
@Xml.name("EnumerationResults")
model ListBlobsFlatSegmentResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The container name. */
  @Xml.attribute
  @Xml.name("ContainerName")
  containerName: string;

  /** The prefix of the blobs. */
  @Xml.name("Prefix") rrefix?: string;

  /** The marker of the blobs. */
  @Xml.name("Marker") marker?: string;

  /** The max results of the blobs. */
  @Xml.name("MaxResults") maxResults?: int32;

  /** The blob segment. */
  @Xml.name("Segment") segment: BlobFlatListSegment;

  /** The next marker of the blobs. */
  @Xml.name("NextMarker") nextMarker?: string;
}

/** The blob flat list segment. */
@Xml.name("Blobs")
model BlobFlatListSegment {
  /** The blob items. */
  @Xml.name("BlobItems") blobItems: BlobItemInternal[];
}

/** Represents a page list. */
model PageList {
  /** The page ranges. */
  @Xml.name("PageRange") pageRange: PageRange[];

  /** The clear ranges. */
  @Xml.name("ClearRange") clearRange: ClearRange[];

  /** The next marker. */
  @Xml.name("NextMarker") nextMarker?: string;
}

/** The page range. */
@Xml.name("PageRange")
model PageRange {
  /** The start of the byte range. */
  @Xml.name("Start") start: int64;

  /** The end of the byte range. */
  @Xml.name("End") end: int64;
}

/** The clear range. */
model ClearRange {
  /** The start of the byte range. */
  @Xml.name("Start") start: int64;

  /** The end of the byte range. */
  @Xml.name("End") end: int64;
}

/** The blob tags body parameter. */
alias BlobTagsBodyParameter = {
  /** The blob tags. */
  @body
  tags: BlobTags;
};

/** Represents blob tags. */
@Xml.name("Tags")
model BlobTags {
  /** Represents the blob tags. */
  @Xml.name("TagSet") blobTagSet: BlobTag[];
}

/** The query request, note only SQL supported */
union QueryRequestTypeSqlOnly {
  /** The SQL request query type. */
  SQL: "SQL",

  /** Extensible */
  string,
}

/** Groups the set of query request settings. */
@Xml.name("QueryRequest")
model QueryRequest {
  /** Required. The type of the provided query expression. */
  @Xml.name("QueryType") queryType: QueryRequestTypeSqlOnly;

  /** The query expression in SQL. The maximum size of the query expression is 256KiB. */
  @Xml.name("Expression") expression: string;

  /** The input serialization settings. */
  @Xml.name("InputSerialization") inputSerialization?: QuerySerialization;

  /** The output serialization settings. */
  @Xml.name("OutputSerialization") outputSerialization?: QuerySerialization;
}

/** The query serialization settings. */
model QuerySerialization {
  /** The query format. */
  @Xml.name("Format") format: QueryFormat;
}

/** The query format settings. */
model QueryFormat {
  /** The query type. */
  @Xml.name("Type") type: QueryType;

  /** The delimited text configuration. */
  @Xml.name("DelimitedTextConfiguration")
  delimitedTextConfiguration?: DelimitedTextConfiguration;

  /** The JSON text configuration. */
  @Xml.name("JsonTextConfiguration")
  jsonTextConfiguration?: JsonTextConfiguration;

  /** The Apache Arrow configuration. */
  @Xml.name("ArrowConfiguration") arrowConfiguration?: ArrowConfiguration;

  /** The Parquet configuration. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API"
  @Xml.name("ParquetConfiguration") parquetConfiguration?: ParquetConfiguration;
}

/** Represents the delimited text configuration. */
@Xml.name("DelimitedTextConfiguration")
model DelimitedTextConfiguration {
  /** The string used to separate columns. */
  @Xml.name("ColumnSeparator") columnSeparator?: string;

  /** The string used to quote a specific field. */
  @Xml.name("FieldQuote") fieldQuote?: string;

  /** The string used to separate records. */
  @Xml.name("RecordSeparator") recordSeparator?: string;

  /** The string used to escape a quote character in a field. */
  @Xml.name("EscapeChar") escapeChar?: string;

  /** Represents whether the data has headers. */
  @Xml.name("HasHeaders") headersPresent?: boolean;
}

/** Represents the JSON text configuration. */
@Xml.name("JsonTextConfiguration")
model JsonTextConfiguration {
  /** The string used to separate records. */
  @Xml.name("RecordSeparator") recordSeparator?: string;
}

/** Represents the Apache Arrow configuration. */
@Xml.name("ArrowConfiguration")
model ArrowConfiguration {
  /** The Apache Arrow schema */
  @Xml.name("Schema") schema: ArrowField[];
}

/** Represents an Apache Arrow field. */
@Xml.name("Field")
model ArrowField {
  /** The arrow field type. */
  @Xml.name("Type") type: string;

  /** The arrow field name. */
  @Xml.name("Name") name?: string;

  /** The arrow field precision. */
  @Xml.name("Precision") precision?: int32;

  /** The arrow field scale. */
  @Xml.name("Scale") scale?: int32;
}

/** Represents the Parquet configuration. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API"
@Xml.name("ParquetConfiguration")
model ParquetConfiguration is Record<unknown>;

/** The query format type. */
@Xml.name("Type")
union QueryType {
  /** The query format type is delimited. */
  Delimited: "delimited",

  /** The query format type is JSON. */
  JSON: "json",

  /** The query format type is Apache Arrow. */
  Arrow: "arrow",

  /** The query format type is Parquet. */
  Parquet: "parquet",

  /** Extensible */
  string,
}

/// Parameters

/** The blob content MD5 response header. */
alias BlobContentMd5ResponseHeader = {
  /** If the blob has a MD5 hash, and if request contains range header (Range or x-ms-range), this response header is returned with the value of the whole blob's MD5 value. This value may or may not be equal to the value returned in Content-MD5 header, with the latter calculated from the requested range */
  @header("x-ms-blob-content-md5")
  blobContentMd5: string;
};

/** The query request body parameter. */
alias QueryRequestParameter = {
  /** The query request */
  @body
  queryRequest: QueryRequest;
};

/** The blob append offset response header. */
alias BlobAppendOffsetResponseHeader = {
  /** This response header is returned only for append operations. It returns the offset at which the block was committed, in bytes. */
  @header("x-ms-blob-append-offset")
  blobAppendOffset: int64;
};

/** The blob condition append position parameter. */
alias BlobConditionAppendPosParameter = {
  /** Optional conditional header, used only for the Append Block operation. A number indicating the byte offset to compare. Append Block will succeed only if the append position is equal to this number. If it is not, the request will fail with the AppendPositionConditionNotMet error (HTTP status code 412 - Precondition Failed). */
  @clientName("appendPosition")
  @header("x-ms-blob-condition-appendpos")
  blobConditionAppendPosition: int64;
};

/** The blob condition max size parameter. */
alias BlobConditionMaxSizeParameter = {
  /** Optional conditional header. The max length in bytes permitted for the append blob. If the Append Block operation would cause the blob to exceed that limit or if the blob size is already greater than the value specified in this header, the request will fail with MaxBlobSizeConditionNotMet error (HTTP status code 412 - Precondition Failed). */
  @clientName("maxSize")
  @header("x-ms-blob-condition-maxsize")
  blobConditionMaxSize: int64;
};

/** The sequence number action parameter. */
alias SequenceNumberActionParameter = {
  /** Required if the x-ms-blob-sequence-number header is set for the request. This property applies to page blobs only. This property indicates how the service should modify the blob's sequence number */
  @header("x-ms-sequence-number-action")
  sequenceNumberAction: SequenceNumberActionType;
};

/** The sequence number actions. */
union SequenceNumberActionType {
  /** Increment the sequence number. */
  Increment: "increment",

  /** Set the maximum for the sequence number. */
  Max: "max",

  /** Update the sequence number. */
  Update: "update",

  /** Extensible */
  string,
}

/** The sequence number parameter. */
alias SequenceNumberParameter = {
  /** Set for page blobs only. The sequence number is a user-controlled value that you can use to track requests. The value of the sequence number must be between 0 and 2^63 - 1. */
  @header("x-ms-blob-sequence-number")
  blobSequenceNumber: int64;
};

/** The blob content length required parameter. */
alias BlobContentLengthRequired = {
  /** This header specifies the maximum size for the page blob, up to 1 TB. The page blob size must be aligned to a 512-byte boundary. */
  @header("x-ms-blob-content-length")
  blobContentLength: int64;
};

/** The previous snapshot parameter. */
alias PrevSnapshotParameter = {
  /** Optional in version 2015-07-08 and newer. The prevsnapshot parameter is a DateTime value that specifies that the response will contain only pages that were changed between target blob and previous snapshot. Changed pages include both updated and cleared pages. The target blob may be a snapshot, as long as the snapshot specified by prevsnapshot is the older of the two. Note that incremental snapshots are currently supported only for blobs created on or after January 1, 2016. */
  @query
  prevsnapshot: string;
};

/** The previous snapshot URL parameter. */
alias PrevSnapshotUrlParameter = {
  /** Optional. This header is only supported in service versions 2019-04-19 and after and specifies the URL of a previous snapshot of the target blob. The response will only contain pages that were changed between the target blob and its previous snapshot. */
  @clientName("prevSnapshotUrl")
  @header("x-ms-previous-snapshot-url")
  previousSnapshotUrl: string;
};

/** The is immutable storage with versioning enable response header. */
alias IsImmutableStorageWithVersioningEnabledResponseHeader = {
  /** Indicates whether version level worm is enabled on a container */
  @clientName("IsImmutableStorageWithVersioningEnabled")
  @header("x-ms-immutable-storage-with-versioning-enabled")
  immutableStorageWithVersioningEnabled: boolean;
};

/** The deny encryption scope override response header. */
alias DenyEncryptionScopeOverrideResponseHeader = {
  /** If a blob has a lease and the lease is of infinite duration then the value of this header is set to true, otherwise it is set to false. */
  @header("x-ms-deny-encryption-scope-override")
  denyEncryptionScopeOverride: boolean;
};

/** The default encryption scope response header. */
alias DefaultEncryptionScopeResponseHeader = {
  /** The default encryption scope for the container. */
  @header("x-ms-default-encryption-scope")
  defaultEncryptionScope: string;
};

/** The has legal hold response header. */
alias HasLegalHoldResponseHeader = {
  /** Indicates if a blob has a legal hold. */
  @clientName("HasLegalHold")
  @header("x-ms-legal-hold")
  legalHold: boolean;
};

/** The has immutability policy response header. */
alias HasImmutabilityPolicyResponseHeader = {
  /** Indicates if a blob has an active immutability policy. */
  @header("x-ms-has-immutability-policy")
  hasImmutabilityPolicy: boolean;
};

/** The public access response header. */
alias PublicAccessResponseHeader = {
  /** The public access setting for the container. */
  @header("x-ms-blob-public-access")
  publicAccess: PublicAccessType;
};

/** The rehydrate priority response header. */
alias RehydratePriorityResponseHeader = {
  /** If an object is in rehydrate pending state then this header is returned with priority of rehydrate. Valid values are High and Standard. */
  @header("x-ms-rehydrate-priority")
  rehydratePriority: RehydratePriority;
};

/** The expires on response header. */
alias ExpiresOnResponseHeader = {
  /** UTC date/time value generated by the service that indicates the time at which the blob will expire. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @clientName("ExpiresOn")
  @encode("date-time-rfc1123")
  @header("x-ms-expiry-time")
  expiryTime: utcDateTime;
};

/** The access tier change time response header. */
alias AccessTierChangeTimeResponseHeader = {
  /** The time the tier was changed on the object. This is only returned if the tier on the block blob was ever set. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("x-ms-access-tier-change-time")
  accessTierChangeTime: utcDateTime;
};

/** The archive status response header. */
alias ArchiveStatusResponseHeader = {
  /** For blob storage LRS accounts, valid values are rehydrate-pending-to-hot/rehydrate-pending-to-cool. If the blob is being rehydrated and is not complete then this header is returned indicating that rehydrate is pending and also tells the destination tier. */
  @header("x-ms-archive-status")
  archiveStatus: ArchiveStatus;
};

/** The access tier inferred response header. */
alias AccessTierInferredResponseHeader = {
  /** For page blobs on a premium storage account only. If the access tier is not explicitly set on the blob, the tier is inferred based on its content length and this header will be returned with true value. */
  @header("x-ms-access-tier-inferred")
  accessTierInferred: boolean;
};

/** The access tier response header. */
alias AccessTierResponseHeader = {
  /** The tier of page blob on a premium storage account or tier of block blob on blob storage LRS accounts. For a list of allowed premium page blob tiers, see https://docs.microsoft.com/en-us/azure/virtual-machines/windows/premium-storage#features. For blob storage LRS accounts, valid values are Hot/Cool/Archive. */
  @header("x-ms-access-tier")
  accessTier: AccessTier;
};

/** The destination snapshot response header. */
alias DestinationSnapshotResponseHeader = {
  /** Included if the blob is incremental copy blob or incremental copy snapshot, if x-ms-copy-status is success. Snapshot time of the last successful incremental copy snapshot for this blob. */
  @clientName("DestinationSnapshot")
  @header("x-ms-copy-destination-snapshot")
  copyDestinationSnapshot: string;
};

/** The is incremental copy response header. */
alias IsIncrementalCopyResponseHeader = {
  /** Included if the blob is incremental copy blob. */
  @clientName("IsIncrementalCopy")
  @header("x-ms-incremental-copy")
  incrementalCopy: boolean;
};

/** The immutability policy expires on response header. */
alias ImmutabilityPolicyExpiresOnResponseHeader = {
  /** UTC date/time value generated by the service that indicates the time at which the blob immutability policy will expire. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @clientName("ImmutabilityPolicyExpiresOn")
  @encode("date-time-rfc1123")
  @header("x-ms-immutability-policy-until-date")
  immutabilityPolicyUntilDate: utcDateTime;
};

/** The last accessed response header. */
alias LastAccessedResponseHeader = {
  /** UTC date/time value generated by the service that indicates the time at which the blob was last read or written to */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @clientName("LastAccessed")
  @encode("date-time-rfc1123")
  @header("x-ms-last-access-time")
  lastAccessTime: utcDateTime;
};

/** The is sealed response header. */
alias IsSealedResponseHeader = {
  /** If this blob has been sealed */
  @clientName("IsSealed")
  @header("x-ms-blob-sealed")
  blobSealed: boolean;
};

/** The tag count response header. */
alias TagCountResponseHeader = {
  /** The number of tags associated with the blob */
  @header("x-ms-tag-count")
  tagCount: int64;
};

/** The blob committed block count response header. */
alias BlobCommittedBlockCountResponseHeader = {
  /** The number of committed blocks present in the blob. This header is returned only for append blobs. */
  @header("x-ms-blob-committed-block-count")
  blobCommittedBlockCount: int32;
};

/** The accept ranges response header. */
alias AcceptRangesResponseHeader = {
  /** Indicates that the service supports requests for partial blob content. */
  @header("Accept-Ranges") acceptRanges: string;
};

/** The is current version response header. */
alias IsCurrentVersionResponseHeader = {
  /** The value of this header indicates whether version of this blob is a current version, see also x-ms-version-id header. */
  @header("x-ms-is-current-version")
  isCurrentVersion: boolean;
};

/** The lease status response header. */
alias LeaseStatusResponseHeader = {
  /** The lease status of the blob. */
  @header("x-ms-lease-status")
  leaseStatus: LeaseStatus;
};

/** The lease state response header. */
alias LeaseStateResponseHeader = {
  /** Lease state of the blob. */
  @header("x-ms-lease-state")
  leaseState: LeaseState;
};

/** The lease duration response header. */
alias LeaseDurationResponseHeader = {
  /** When a blob is leased, specifies whether the lease is of infinite or fixed duration. */
  @header("x-ms-lease-duration")
  leaseDuration: LeaseDuration;
};

/** The copy source response header. */
alias CopySourceResponseHeader = {
  /** URL up to 2 KB in length that specifies the source blob or file used in the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
  @header("x-ms-copy-source")
  copySource: string;
};

/** The copy progress response header. */
alias CopyProgressResponseHeader = {
  /** Contains the number of bytes copied and the total bytes in the source in the last attempted Copy Blob operation where this blob was the destination blob. Can show between 0 and Content-Length bytes copied. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
  @header("x-ms-copy-progress")
  copyProgress: string;
};

/** The copy status description response header. */
alias CopyStatusDescriptionResponseHeader = {
  /** Only appears when x-ms-copy-status is failed or pending. Describes the cause of the last fatal or non-fatal copy operation failure. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
  @header("x-ms-copy-status-description")
  copyStatusDescription: string;
};

/** The copy completion time response header. */
alias CopyCompletionTimeResponseHeader = {
  /** Conclusion time of the last attempted Copy Blob operation where this blob was the destination blob. This value can specify the time of a completed, aborted, or failed copy attempt. This header does not appear if a copy is pending, if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("x-ms-copy-completion-time")
  copyCompletionTime: utcDateTime;
};

/** The blob type response header. */
alias BlobTypeResponseHeader = {
  /** The type of the blob. */
  @header("x-ms-blob-type")
  blobType: BlobType;
};

/** The object replication policy response header. */
alias ObjectReplicationPolicyIdResponseHeader = {
  /** Optional. Only valid when Object Replication is enabled for the storage container and on the destination blob of the replication. */
  @header("x-ms-or-policy-id")
  objectReplicationPolicyId: string;
};

/** The range required put page from URL parameter. */
alias RangeRequiredPutPageFromUrlParameter = {
  /** Bytes of source data in the specified range. The length of this range should match the ContentLength header and x-ms-range/Range destination range header. */
  @header("x-ms-range")
  range: string;
};

/** The source range required put page from URL parameter. */
alias SourceRangeRequiredPutPageFromUrlParameter = {
  /** Bytes of source data in the specified range. The length of this range should match the ContentLength header and x-ms-range/Range destination range header. */
  @header("x-ms-source-range")
  sourceRange: string;
};

/** The if seuqnce number equal to parameter. */
alias IfSequenceNumberEqualToParameter = {
  /** Specify this header value to operate only on a blob if it has the specified sequence number. */
  @header("x-ms-if-sequence-number-eq")
  ifSequenceNumberEqualTo?: int64;
};

/** THe if sequence number less than parameter. */
alias IfSequenceNumberLessThanParameter = {
  /** Specify this header value to operate only on a blob if it has a sequence number less than the specified. */
  @header("x-ms-if-sequence-number-lt")
  ifSequenceNumberLessThan?: int64;
};

/** The if sequence number less than or equal to parameter. */
alias IfSequenceNumberLessThanOrEqualToParameter = {
  /** Specify this header value to operate only on a blob if it has a sequence number less than or equal to the specified. */
  @header("x-ms-if-sequence-number-le")
  ifSequenceNumberLessThanOrEqualTo?: int64;
};

/** The blob content-length response header. */
alias BlobContentLengthResponseHeader = {
  /** The size of the blob in bytes. */
  @header("x-ms-blob-content-length")
  blobContentLength: int64;
};

/** The block list type parameter. */
alias BlockListTypeParameter = {
  /** Specifies whether to return the list of committed blocks, the list of uncommitted blocks, or both lists together. */
  @query
  @clientName("listType")
  blocklisttype: BlockListType;
};

/** The block list types. */
union BlockListType {
  /** The list of committed blocks. */
  Committed: "committed",

  /** The list of uncommitted blocks. */
  Uncomitted: "uncommitted",

  /** Both lists together. */
  All: "all",

  /** Extensible */
  string,
}

/** The blob blocks body parameter. */
alias BlobBlocksParameter = {
  /** Blob Blocks. */
  @body blocks: BlockLookupList;
};

/** The source content CRC64 parameter. */
alias SourceContentCrc64Parameter = {
  /** Specify the crc64 calculated for the range of bytes that must be read from the copy source. */
  @header("x-ms-source-content-crc64")
  sourceContentCrc64?: string;
};

/** The source range parameter. */
alias SourceRangeParameter = {
  /** Bytes of source data in the specified range. */
  @header("x-ms-source-range")
  sourceRange: string;
};

/** The source URL parameter. */
alias SourceUrlParameter = {
  /** Specify a URL to the copy source. */
  @header("x-ms-source-url")
  sourceUrl: string;
};

/** The Block ID parameter. */
alias BlockIdParameter = {
  /** A valid Base64 string value that identifies the block. Prior to encoding, the string must be less than or equal to 64 bytes in size. For a given blob, the length of the value specified for the blockid parameter must be the same size for each block. */
  @query
  @clientName("blockId")
  blockid: string;
};

/** The is hierarchical namespace enabled response header. */
alias IsHierarchicalNamespaceEnabledResponseHeader = {
  /** Version 2019-07-07 and newer. Indicates if the account has a hierarchical namespace enabled. */
  @header("x-ms-is-hns-enabled")
  isHierarchicalNamespaceEnabled: boolean;
};

/** The account kind response header. */
alias AccountKindResponseHeader = {
  /** Identifies the account kind */
  @header("x-ms-account-kind")
  accountKind: AccountKind;
};

/** The SKU name response header. */
alias SkuNameResponseHeader = {
  /** Identifies the sku name of the account */
  @header("x-ms-sku-name")
  skuName: SkuName;
};

/** The access tier required parameter. */
alias AccessTierRequiredParameter = {
  /** Indicates the tier to be set on the blob. */
  @header("x-ms-access-tier")
  accessTier: AccessTier;
};

/** The copy ID parameter. */
alias CopyIdParameter = {
  /** The copy identifier provided in the x-ms-copy-id header of the original Copy Blob operation. */
  @header("x-ms-copy-id")
  copyId: string;
};

/** The content CRC 64 response header. */
alias ContentCrc64ResponseHeader = {
  /** This response header is returned so that the client can check for the integrity of the copied content. */
  @header("x-ms-content-crc64")
  contentCrc64: string;
};

/** The copy status response header. */
alias CopyStatusResponseHeader = {
  /** State of the copy operation identified by x-ms-copy-id. */
  @header("x-ms-copy-status")
  copyStatus: CopyStatus;
};

/** The copy ID response header. */
alias CopyIdResponseHeader = {
  /** String identifier for this copy operation. Use with Get Blob Properties to check the status of this copy operation, or pass to Abort Copy Blob to abort a pending copy. */
  @header("x-ms-copy-id")
  copyId: string;
};

/** The seal blob parameter. */
alias SealBlobParameter = {
  /** Overrides the sealed state of the destination blob.  Service version 2019-12-12 and newer. */
  @header("x-ms-seal-blob")
  sealBlob?: boolean;
};

/** The source if unmodified since parameter. */
alias SourceIfUnmodifiedSinceParameter = {
  /** Specify this header value to operate only on a blob if it has not been modified since the specified date/time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("x-ms-source-if-unmodified-since")
  sourceIfUnmodifiedSince?: utcDateTime;
};

/** The rehydrate priority parameter. */
alias RehydratePriorityParameter = {
  /** Optional: Indicates the priority with which to rehydrate an archived blob. */
  @header("x-ms-rehydrate-priority")
  rehydratePriority?: RehydratePriority;
};

/** The snapshot response header. */
alias SnapshotResponseHeader = {
  /** Uniquely identifies the snapshot and indicates the snapshot version. It may be used in subsequent requests to access the snapshot. */
  @header("x-ms-snapshot")
  snapshot: string;
};

/** The lease time response header. */
alias LeaseTimeResponseHeader = {
  /** Approximate time remaining in the lease period, in seconds. */
  @header("x-ms-lease-time")
  leaseTime: int32;
};

/** The lease break period parameter. */
alias LeaseBreakPeriodParameter = {
  /** For a break operation, proposed duration the lease should continue before it is broken, in seconds, between 0 and 60. This break period is only used if it is shorter than the time remaining on the lease. If longer, the time remaining on the lease is used. A new lease will not be available before the break period has expired, but the lease may be held for longer than the break period. If this header does not appear with a break operation, a fixed-duration lease breaks after the remaining lease period elapses, and an infinite lease breaks immediately. */
  @clientName("breakPeriod")
  @header("x-ms-lease-break-period")
  leaseBreakPeriod?: int32;
};

/** The lease ID required parameter. */
alias LeaseIdRequiredParameter = {
  /** Required.  A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
  @header("x-ms-lease-id")
  leaseId: string;
};

/** The lease ID response header. */
alias LeaseIdResponseHeader = {
  /** Uniquely identifies a blobs' lease */
  @header("x-ms-lease-id")
  leaseId: string;
};

/** The encryption scope response header. */
alias EncryptionScopeResponseHeader = {
  /** If the blob has a MD5 hash, and if request contains range header (Range or x-ms-range), this response header is returned with the value of the whole blob's MD5 value. This value may or may not be equal to the value returned in Content-MD5 header, with the latter calculated from the requested range */
  @header("x-ms-encryption-scope")
  encryptionScope: string;
};

/** The encryption key SHA256 response header. */
alias EncryptionKeySha256ResponseHeader = {
  /** The SHA-256 hash of the encryption key used to encrypt the blob. This header is only returned when the blob was encrypted with a customer-provided key. */
  @header("x-ms-encryption-key-sha256")
  encryptionKeySha256: string;
};

/** The is server encrypted response header. */
alias IsServerEncryptedResponseHeader = {
  /** The value of this header is set to true if the contents of the request are successfully encrypted using the specified algorithm, and false otherwise. */
  @clientName("isServerEncrypted")
  @header("x-ms-request-server-encrypted")
  requestServerEncrypted?: boolean;
};

/** The legal hold response header. */
alias LegalHoldResponseHeader = {
  /** Specifies the legal hold status to set on the blob. */
  @header("x-ms-legal-hold")
  legalHold: boolean;
};

/** The legal hold required parameter. */
alias LegalHoldRequiredParameter = {
  /** Required.  Specifies the legal hold status to set on the blob. */
  @header("x-ms-legal-hold")
  legalHold: boolean;
};

/** The immutability policy mode response header. */
alias ImmutabilityPolicyModeResponseHeader = {
  /** Indicates the immutability policy mode of the blob. */
  @header("x-ms-immutability-policy-mode")
  immutabilityPolicyMode: BlobImmutabilityPolicyMode;
};

/** The immutability policy expiration response header. */
alias ImmutabilityPolicyExpiryResponseHeader = {
  /** Indicates the time the immutability policy will expire. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @clientName("ImmutabilityPolicyExpiry")
  @header("x-ms-immutability-policy-until-date")
  immutabilityPolicyUntilDate: utcDateTime;
};

/** The blob sequence number response header. */
alias BlobSequenceNumberResponseHeader = {
  /** The current sequence number for a page blob. This header is not returned for block blobs or append blobs. */
  @header("x-ms-blob-sequence-number")
  blobSequenceNumber: int64;
};

/** The blob expiration time parameter. */
alias BlobExpiryTimeParameter = {
  /** The time to set the blob to expiry. */
  @clientName("ExpiresOn")
  @header("x-ms-expiry-time")
  expiryTime: string;
};

/** The blob expiration options parameter. */
alias BlobExpiryOptionsParameter = {
  /** Required. Indicates mode of the expiry time */
  @header("x-ms-expiry-option")
  expiryOptions: BlobExpiryOptions;
};

/** The blob expiration options. */
union BlobExpiryOptions {
  /** Never expire. */
  NeverExpire: "NeverExpire",

  /** Relative to creation time. */
  RelativeToCreation: "RelativeToCreation",

  /** Relative to now. */
  RelativeToNow: "RelativeToNow",

  /** Absolute time. */
  Absolute: "Absolute",

  /** Extensible */
  string,
}

/** The Content-Language response header. */
alias ContentLanguageResponseHeader = {
  /** This header returns the value that was specified for the Content-Language request header. */
  @header("Content-Language") contentLanguage: string;
};

/** The Content-Disposition response header. */
alias ContentDispositionResponseHeader = {
  /** This header returns the value that was specified for the 'x-ms-blob-content-disposition' header. The Content-Disposition response header field conveys additional information about how to process the response payload, and also can be used to attach additional metadata. For example, if set to attachment, it indicates that the user-agent should not display the response, but instead show a Save As dialog with a filename other than the blob name specified. */
  @header("Content-Disposition") contentDisposition: string;
};

/** The Cache-Control response header. */
alias CacheControlResponseHeader = {
  /** This header is returned if it was previously specified for the blob. */
  @header("Cache-Control") cacheControl: string;
};

/** The Content-Encoding response header. */
alias ContentEncodingResponseParameter = {
  /** This header returns the value that was specified for the Content-Encoding request header */
  @header("Content-Encoding") contentEncoding: string;
};

/** The Content-Range response header. */
alias ContentRangeResponseHeader = {
  /** Indicates the range of bytes returned in the event that the client requested a subset of the blob by setting the 'Range' request header. */
  @header("Content-Range") contentRange: string;
};

/** The Content-MD5 response header. */
alias ContentMd5ResponseHeader = {
  /** If the blob has an MD5 hash and this operation is to read the full blob, this response header is returned so that the client can check for message content integrity. */
  @header("Content-MD5") contentMd5: string;
};

/** The Content-Length response header. */
alias ContentLengthResponseHeader = {
  /** The number of bytes present in the response body. */
  @header("Content-Length") contentLength: int64;
};

/** The version ID response header. */
alias VersionIdResponseHeader = {
  /** A DateTime value returned by the service that uniquely identifies the blob. The value of this header indicates the blob version, and may be used in subsequent requests to access this version of the blob. */
  @header("x-ms-version-id")
  versionId: string;
};

/** The creation time response header. */
alias CreationTimeResponseHeader = {
  /** Returns the date and time the blob was created. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("x-ms-creation-time")
  creationTime: utcDateTime;
};

/** The last modified response header */
alias LastModifiedResponseHeader = {
  /** The date/time that the container was last modified. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("Last-Modified")
  lastModified: utcDateTime;
};

/** The Date response header */
alias DateResponseHeader = {
  /** UTC date/time value generated by the service that indicates the time at which the response was initiated */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("Date")
  date: utcDateTime;
};

/** The ETag response header */
alias EtagResponseHeader = {
  /** The ETag contains a value that you can use to perform operations conditionally. */
  @header("ETag") eTag: string;
};

/** The copy source tags header parameter. */
alias CopySourceTagsParameter = {
  /** Optional, default 'replace'.  Indicates if source tags should be copied or replaced with the tags specified by x-ms-tags. */
  @header("x-ms-copy-source-tags")
  copySourceTags?: string;
};

/** The blob copy source tags types. */
union BlobCopySourceTags {
  /** The replace blob source tags option. */
  Replace: "REPLACE",

  /** The copy blob source tags option. */
  Copy: "COPY",

  /** Extensible */
  string,
}

/** The copy source authorization header parameter */
alias CopySourceAuthorizationParameter = {
  /** Only Bearer type is supported. Credentials should be a valid OAuth access token to copy source. */
  @header("x-ms-copy-source-authorization")
  copySourceAuthorization?: string;
};

/** The copy source blob properties parameter. */
alias CopySourceBlobPropertiesParameter = {
  /** Optional, default is true.  Indicates if properties from the source blob should be copied. */
  @header("x-ms-copy-source-blob-properties")
  copySourceBlobProperties?: boolean;
};

/** The copy source header parameter. */
alias CopySourceParameter = {
  /** Specifies the name of the source page blob snapshot. This value is a URL of up to 2 KB in length that specifies a page blob snapshot. The value should be URL-encoded as it would appear in a request URI. The source blob must either be public or must be authenticated via a shared access signature. */
  @header("x-ms-copy-source")
  copySource: string;
};

/** The source content MD5 header parameter. */
alias SourceContentMd5Parameter = {
  /** Specify the md5 calculated for the range of bytes that must be read from the copy source. */
  @header("x-ms-source-content-md5")
  sourceContentMd5?: string;
};

/** The source if tags parameter. */
alias SourceIfTagsParameter = {
  /** Specify a SQL where clause on blob tags to operate only on blobs with a matching value. */
  @header("x-ms-source-if-tags")
  sourceIfTags?: string;
};

/** The source if match parameter. */
alias SourceIfMatchParameter = {
  /** Specify an ETag value to operate only on blobs with a matching value. */
  @header("x-ms-source-if-match")
  sourceIfMatch?: string;
};

/** The source if none match parameter. */
alias SourceIfNoneMatchParameter = {
  /** Specify this header value to operate only on a blob if it has been modified since the specified date/time. */
  @header("x-ms-source-if-none-match")
  sourceIfNoneMatch?: string;
};

/** The source if modified since parameter. */
alias SourceIfModifiedSinceParameter = {
  /** Specify this header value to operate only on a blob if it has been modified since the specified date/time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @header("x-ms-source-if-modified-since")
  @encode("date-time-rfc1123")
  sourceIfModifiedSince?: utcDateTime;
};

/** The content CRC64 parameter. */
alias ContentCrc64Parameter = {
  /** Specify the transactional crc64 for the body, to be validated by the service. */
  @clientName("transactionalContentCrc64")
  @header("x-ms-content-crc64")
  contentCrc64?: string;
};

/** The access tier optional parameter. */
alias AccessTierOptionalParameter = {
  /** Optional.  The tier to be set on the blob. */
  @clientName("tier")
  @header("x-ms-access-tier")
  accessTier?: AccessTier;
};

/** The content MD5 parameter. */
alias ContentMd5Parameter = {
  /** Optional. An MD5 hash of the blob content. Note that this hash is not validated, as the hashes for the individual blocks were validated when each was uploaded. */
  @clientName("transactionalContentMD5")
  @header("Content-MD5")
  contentMd5?: string;
};

/** The legal hold optional parameter. */
alias LegalHoldOptionalParameter = {
  /** Specified if a legal hold should be set on the blob. */
  @header("x-ms-legal-hold")
  legalHold?: boolean;
};

/** The immutability policy mode parameter. */
alias ImmutabilityPolicyModeParameter = {
  /** Specifies the immutability policy mode to set on the blob. */
  @header("x-ms-immutability-policy-mode")
  immutabilityPolicyMode?: BlobImmutabilityPolicyMode;
};

/** The immutability policy expiration parameter. */
alias ImmutabilityPolicyExpiryParameter = {
  /** Specifies the date time when the blobs immutability policy is set to expire. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("x-ms-immutability-policy-until-date")
  immutabilityPolicyExpiry?: string;
};

/** The blobs tags header parameter. */
alias BlobTagsHeaderParameter = {
  /** Optional.  Used to set blob tags in various blob operations. */
  @clientName("BlobTagsString")
  @header("x-ms-tags")
  blobTags?: string;
};

/** The blob sequence number parameter. */
alias BlobSequenceNumberParameter = {
  /** Optional.  The sequence number is a user-controlled property that you can use to track requests. The value of the sequence number must be between 0 and 2^63 - 1. The default value is 0. */
  @header("x-ms-blob-sequence-number")
  blobSequenceNumber?: int64;
};

/** The blob content length parameter. */
alias BlobContentLengthRequiredParameter = {
  /** This header specifies the maximum size for the page blob, up to 1 TB. The page blob size must be aligned to a 512-byte boundary. */
  @header("x-ms-blob-content-length")
  blobContentLength: int64;
};

/** The encryption scope parameter. */
alias EncryptionScopeParameter = {
  /** Optional.  Version 2019-07-07 and later.  Specifies the encryption scope to use to encrypt the data provided in the request. If not specified, the request will be encrypted with the root account key. */
  @header("x-ms-encryption-scope")
  encryptionScope?: string;
};

/** The blob content disposition parameter. */
alias BlobContentDispositionParameter = {
  /** Optional. Sets the blob's content disposition. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-blob-content-disposition")
  blobContentDisposition?: string;
};

/** The blob cache control parameter. */
alias BlobCacheControlParameter = {
  /** Optional. Sets the blob's cache control. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-blob-cache-control")
  blobCacheControl?: string;
};

/** The blob content MD5 parameter. */
alias BlobContentMd5Parameter = {
  /** Optional. An MD5 hash of the blob content. Note that this hash is not validated, as the hashes for the individual blocks were validated when each was uploaded. */
  @header("x-ms-blob-content-md5")
  blobContentMd5?: string;
};

/** The blob content type parameter. */
alias BlobContentLanguageParameter = {
  /** Optional. Set the blob's content language. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-blob-content-language")
  blobContentLanguage?: string;
};

/** The blob content type parameter. */
alias BlobContentEncodingParameter = {
  /** Optional. Sets the blob's content encoding. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-blob-content-encoding")
  blobContentEncoding?: string;
};

/** The blob content type parameter. */
alias BlobContentTypeParameter = {
  /** Optional. Sets the blob's content type. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-blob-content-type")
  blobContentType?: string;
};

/** The optional premium page blob access tier parameter. */
model PremiumPageBlobAccessTierOptional {
  /** Optional. Indicates the tier to be set on the page blob. */
  @header("x-ms-access-tier")
  accessTier?: PremiumPageBlobAccessTier;
}

/** The premium page blob access tier types. */
union PremiumPageBlobAccessTier {
  /** The premium page blob access tier is P4. */
  P4: "P4",

  /** The premium page blob access tier is P6. */
  P6: "P6",

  /** The premium page blob access tier is P10. */
  P10: "P10",

  /** The premium page blob access tier is P15. */
  P15: "P15",

  /** The premium page blob access tier is P20. */
  P20: "P20",

  /** The premium page blob access tier is P30. */
  P30: "P30",

  /** The premium page blob access tier is P40. */
  P40: "P40",

  /** The premium page blob access tier is P50. */
  P50: "P50",

  /** The premium page blob access tier is P60. */
  P60: "P60",

  /** The premium page blob access tier is P70. */
  P70: "P70",

  /** The premium page blob access tier is P80. */
  P80: "P80",

  /** Extensible */
  string,
}

/** The blob name parameter. */
alias BlobNameParameter = {
  /** The name of the blob. */
  @minLength(1)
  @maxLength(1024)
  @pattern("^[a-zA-Z0-9]+(?:/[a-zA-Z0-9]+)*(?:\\.[a-zA-Z0-9]+){0,1}$")
  @path
  blob: string;
};

/** The blob delete type parameter. */
alias BlobDeleteTypeParameter = {
  /** Optional.  Only possible value is 'permanent', which specifies to permanently delete a blob if blob soft delete is enabled. */
  @query
  @clientName("blobDeleteType")
  deletetype?: DeleteSnapshotsOptionType;
};

/** The type of blob deletions. */
union BlobDeleteType {
  /** Permanently delete the blob. */
  Permanent: "Permanent",

  /** Extensible */
  string,
}

/** The delete snapshot parameter. */
alias DeleteSnapshotsParameter = {
  /** Required if the blob has associated snapshots. Specify one of the following two options: include: Delete the base blob and all of its snapshots. only: Delete only the blob's snapshots and not the blob itself */
  @header("x-ms-delete-snapshots")
  deleteSnapshots?: DeleteSnapshotsOptionType;
};

/** The delete snapshots option type. */
union DeleteSnapshotsOptionType {
  /** The delete snapshots include option is not specified. */
  Nonne: "none",

  /** The delete snapshots include option is include. */
  Include: "include",

  /** Extensible */
  string,
}

/** The encryption algorithm parameter. */
alias EncryptionAlgorithmParameter = {
  /** Optional.  Version 2019-07-07 and later.  Specifies the algorithm to use for encryption. If not specified, the default is AES256. */
  @header("x-ms-encryption-algorithm")
  encryptionAlgorithm?: string;
};

/** The encryption key SHA256 hash parameter. */
alias EncryptionKeySha256Parameter = {
  /** Optional.  Version 2019-07-07 and later.  Specifies the SHA256 hash of the encryption key used to encrypt the data provided in the request. This header is only used for encryption with a customer-provided key. If the request is authenticated with a client token, this header should be specified using the SHA256 hash of the encryption key. */
  @header("x-ms-encryption-key-sha256")
  encryptionKeySha256?: string;
};

/** The encryption key parameter. */
alias EncryptionKeyParameter = {
  /** Optional.  Version 2019-07-07 and later.  Specifies the encryption key to use to encrypt the data provided in the request. If not specified, the request will be encrypted with the root account key. */
  @header("x-ms-encryption-key")
  encryptionKey?: string;
};

/** The If-Tags parameters. */
alias IfTagsParameter = {
  /** Specify a SQL where clause on blob tags to operate only on blobs with a matching value. */
  @header("x-ms-if-tags")
  ifTags?: string;
};

/** The If-Match parameter. */
alias IfMatchParameter = {
  /** A condition that must be met in order for the request to be processed. */
  @header("If-Match")
  ifMatch?: string;
};

/** The If-None-Match parameter. */
alias IfNoneMatchParameter = {
  /** A condition that must be met in order for the request to be processed. */
  @header("If-None-Match")
  ifNoneMatch?: string;
};

/** The get range content CRC64 parameter. */
alias GetRangeContentCrc64Parameter = {
  /** Optional.  When this header is set to true and specified together with the Range header, the service returns the CRC64 hash for the range, as long as the range is less than or equal to 4 MB in size. */
  @header("x-ms-range-get-content-crc64") rangeContentCrc64?: boolean;
};

/** The get range content MD5 parameter. */
alias GetRangeContentMd5Parameter = {
  /** Optional.  When this header is set to true and specified together with the Range header, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4 MB in size. */
  @header("x-ms-range-get-content-md5") rangeContentMd5?: boolean;
};

/** The range parameter. */
alias RangeParameter = {
  /** Return only the bytes of the blob in the specified range. */
  @header("x-ms-range")
  range?: string;
};

/** The version ID parameter. */
alias VersionIdParameter = {
  /** The version id parameter is an opaque DateTime value that, when present, specifies the version of the blob to operate on. It's for service version 2019-10-10 and newer. */
  @header
  @clientName("versionId")
  versionid: string;
};

/** The snapshot parameter. */
alias SnapshotParameter = {
  @doc("The snapshot parameter is an opaque DateTime value that, when present, specifies the blob snapshot to retrieve. For more information on working with blob snapshots, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/creating-a-snapshot-of-a-blob\">Creating a Snapshot of a Blob.</a>")
  @query
  snapshot?: string;
};

/** Represents a blob name. */
model BlobName {
  /** Whether the blob name is encoded. */
  @Xml.attribute
  @Xml.name("Encoded")
  encoded: boolean;

  /** The blob name. */
  @Xml.unwrapped content: string;
}

/** Represents a blob prefix. */
model BlobPrefix {
  /** The blob name. */
  @Xml.name("Name") name: BlobName;
}

/** Represents an array of blobs. */
@Xml.name("Blobs")
model BlobHierarchyListSegment {
  /** The blob items */
  @Xml.name("BlobItems") blobItems: BlobItemInternal[];

  /** The blob prefixes. */
  @Xml.name("BlobPrefixes") blobPrefixes: BlobPrefix[];
}

/** An enumeration of blobs */
@Xml.name("EnumerationResults")
model ListBlobsHierarchySegmentResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The container name. */
  @Xml.attribute
  @Xml.name("ContainerName")
  containerName: string;

  /** The delimiter of the blobs. */
  @Xml.name("Delimiter") delimiter?: string;

  /** The prefix of the blobs. */
  @Xml.name("Prefix") prefix?: string;

  /** The marker of the blobs. */
  @Xml.name("Marker") marker?: string;

  /** The max results of the blobs. */
  @Xml.name("MaxResults") maxResults?: int32;

  /** The blob segment. */
  @Xml.name("Segment") segment: BlobHierarchyListSegment;

  /** The next marker of the blobs. */
  @Xml.name("NextMarker") nextMarker?: string;
}

/** The delimiter parameter. */
alias DelimiterParameter = {
  /** When the request includes this parameter, the operation returns a BlobPrefix element in the response body that acts as a placeholder for all blobs whose names begin with the same substring up to the appearance of the delimiter character. The delimiter may be a single character or a string. */
  @query delimiter: string;
};

/** The list blob includes parameter. */
alias ListBlobsIncludeParameter = {
  /** Include this parameter to specify one or more datasets to include in the response. */
  @query
  include?: ListBlobsIncludes[];
};

/** The list blob includes parameter values. */
union ListBlobsIncludes {
  /** The include copies. */
  Copies: "copies",

  /** The include deleted blobs. */
  Deleted: "deleted",

  /** The include metadata. */
  Metadata: "metadata",

  /** The include snapshots. */
  Snapshots: "snapshots",

  /** The include uncommitted blobs. */
  UncommittedBlobs: "uncommittedblobs",

  /** The include versions. */
  Versions: "versions",

  /** The include tags. */
  Tags: "tags",

  /** The include immutable policy. */
  ImmutabilityPolicy: "immutabilitypolicy",

  /** The include legal hold. */
  LegalHold: "legalhold",

  /** The include deleted with versions. */
  DeletedWithVersions: "deletedwithversions",

  /** Extensible */
  string,
}

/** The lease duration parameter. */
alias LeaseDurationParameter = {
  /** Specifies the duration of the lease, in seconds, or negative one (-1) for a lease that never expires. A non-infinite lease can be between 15 and 60 seconds. A lease duration cannot be changed using renew or change. */
  @clientName("duration")
  @header("x-ms-lease-duration")
  leaseDuration: int32;
};

/** The source lease ID header parameter. */
alias SourceLeaseIdParameter = {
  /** A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
  @header("x-ms-source-lease-id")
  sourceLeaseId?: string;
};

/** The source container name header parameter. */
alias SourceContainerNameParameter = {
  /** Required.  Specifies the name of the container to rename. */
  @header("x-ms-source-container-name")
  sourceContainerName: string;
};

/** The deleted container name header. */
alias DeletedContainerNameParameter = {
  /** Optional.  Version 2019-12-12 and later.  Specifies the name of the deleted container to restore. */
  @header("x-ms-deleted-container-name")
  deletedContainerName?: string;
};

/** The deleted container version header. */
alias DeletedContainerVersionParameter = {
  /** Optional.  Version 2019-12-12 and later.  Specifies the version of the deleted container to restore. */
  @header("x-ms-deleted-container-version")
  deletedContainerVersion?: string;
};

/** The container ACL parameter. */
alias ContainerAclParameter = {
  /** The access control list for the container. */
  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
  @body
  acl: SignedIdentifiers;
};

/** The container name header */
alias ContainerNameParameter = {
  /** The name of the container. */
  @path
  containerName: string;
};

/** The If-Unmodified-Since header. */
alias IfUnmodifiedSinceParameter = {
  /** A date-time value. A request is made under the condition that the resource has not been modified since the specified date-time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("If-Unmodified-Since")
  ifUnmodifiedSince?: utcDateTime;
};

/** The If-Modified-Since header. */
alias IfModifiedSinceParameter = {
  /** A date-time value. A request is made under the condition that the resource has been modified since the specified date-time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("date-time-rfc1123")
  @header("If-Modified-Since")
  ifModifiedSince?: utcDateTime;
};

/** The lease ID parameter. */
alias LeaseIdOptionalParameter = {
  /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
  @header("x-ms-lease-id") leaseId?: string;
};

/** The deny encryption scope override parameter. */
alias DenyEncryptionScopeOverrideParameter = {
  /** Optional.  Version 2019-07-07 and later.  Specifies that the request will fail if the target container does not have the same encryption scope as the source container. */
  @header("x-ms-deny-encryption-scope-override")
  denyEncryptionScopeOverride?: boolean;
};

/** The default encryption scope parameter. */
alias DefaultEncryptionScopeParameter = {
  /** Optional.  Version 2019-07-07 and later.  Specifies the default encryption scope to set on the container and use for all future writes. */
  @header("x-ms-default-encryption-scope") defaultEncryptionScope?: string;
};

/** The blob public access parameter. */
alias BlobPublicAccessParameter = {
  /** Specifies whether data in the container may be accessed publicly and the level of access. Possible values include: 'container', 'blob'. */
  @clientName("access")
  @header("x-ms-blob-public-access")
  publicAccess?: PublicAccessType;
};

// TODO: Figure out how to better represent this
/** Optional. Specifies a user-defined name-value pair associated with the blob. If no name-value pairs are specified, the operation will copy the metadata from the source blob or file to the destination blob. If one or more name-value pairs are specified, the destination blob is created with the specified metadata, and metadata is not copied from the source blob or file. Note that beginning with version 2009-09-19, metadata names must adhere to the naming rules for C# identifiers. See Naming and Referencing Containers, Blobs, and Metadata for more information. */
// @header("x-ms-meta") meta?: string;
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API"
alias MetadataParameter = Record<string>;

// TODO: Figure out how to better represent this
/** Optional. Specifies a user-defined name-value pair associated with the blob. If no name-value pairs are specified, the operation will copy the metadata from the source blob or file to the destination blob. If one or more name-value pairs are specified, the destination blob is created with the specified metadata, and metadata is not copied from the source blob or file. Note that beginning with version 2009-09-19, metadata names must adhere to the naming rules for C# identifiers. See Naming and Referencing Containers, Blobs, and Metadata for more information. */
// @header("x-ms-meta") meta?: string;
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API"
alias MetadataResponseHeader = Record<string>;

/** The filter blobs include parameter. */
alias FilterBlobsIncludeParameter = {
  /** Include this parameter to specify one or more datasets to include in the response. */
  @query
  include?: FilterBlobsIncludes[];
};

/** The filter blobs where parameter. */
alias FilterBlobsWhereParameter = {
  /** Filters the results to return only to return only blobs whose tags match the specified expression. */
  @query
  where?: string;
};

/** The Content-Length header. */
alias ContentLengthParameter = {
  /** The length of the request. */
  @header("Content-Length") contentLength: int64;
};

/** The max results parameter. */
alias MaxResultsParameter = {
  /** Specifies the maximum number of containers to return. If the request does not specify maxresults, or specifies a value greater than 5000, the server will return up to 5000 items. */
  @query maxresults?: int32;
};

/** The marker parameter. */
alias MarkerParameter = {
  /** A string value that identifies the portion of the list of containers to be returned with the next listing operation. The operation returns the NextMarker value within the response body if the listing operation did not return all containers remaining to be listed with the current page. The NextMarker value can be used as the value for the marker parameter in a subsequent call to request the next page of list items. The marker value is opaque to the client. */
  @query marker?: string;
};

/** The prefix parameter. */
alias PrefixParameter = {
  /** Filters the results to return only containers whose name begins with the specified prefix. */
  @query prefix?: string;
};

/** The timeout parameter. */
alias TimeoutParameter = {
  @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
  @query
  timeout?: int32;
};

/** The required lease ID header. */
alias ProposedLeaseIdRequiredParameter = {
  /** Required.  The proposed lease ID for the container. */
  @header("x-ms-proposed-lease-id") proposedLeaseId: string;
};

/** The optional lease ID header. */
alias ProposedLeaseIdOptionalParameter = {
  /** Optional.  The proposed lease ID for the container. */
  @header("x-ms-proposed-lease-id") proposedLeaseId?: string;
};

/** The body parameter. */
alias BodyParameter = {
  /** The body of the request. */
  @body
  body: bytes;
};
