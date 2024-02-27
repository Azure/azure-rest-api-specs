import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.BlobStorage;

@doc("Key information")
model KeyInfo {
  @doc("The date-time the key is active.")
  Start: string;
  
  @doc("The date-time the key expires.")
  Expiry: string;
}

@doc("A user delegation key.")
model UserDelegationKey {
  @doc("The Azure Active Directory object ID in GUID format.")
  SignedOid: string;

  @doc("The Azure Active Directory tenant ID in GUID format.")
  SignedTid: string;

  @doc("The date-time the key is active.")
  SignedStart: string;

  @doc("The date-time the key expires.")
  SignedExpiry: string;

  @doc("Abbreviation of the Azure Storage service that accepts the key.")
  SignedService: string;

  @doc("The service version that created the key.")
  SignedVersion: string;

  @doc("The key as a base64 string.")
  Value: string;
}

@doc("The public access types.")
enum PublicAccessType {
  @doc("Blob access.")
  blob,
  @doc("Container access.")
  container,
}

@doc("The copy status.")
enum CopyStatus {
  @doc("The copy operation is pending.")
  pending,
  @doc("The copy operation succeeded.")
  success,
  @doc("The copy operation failed.")
  failed,
  @doc("The copy operation is aborted.")
  aborted,
}

@doc("The lease duration.")
enum LeaseDuration {
  @doc("The lease is of infinite duration.")
  infinite,
  @doc("The lease is of fixed duration.")
  fixed,
}

@doc("The lease state.")
enum LeaseState {
  @doc("The lease is available.")
  available,
  @doc("The lease is currently leased.")
  leased,
  @doc("The lease is expired.")
  expired,
  @doc("The lease is breaking.")
  breaking,
  @doc("The lease is broken.")
  broken,
}

@doc("The lease status.")
enum LeaseStatus {
  @doc("The lease is unlocked.")
  unlocked,
  @doc("The lease is locked.")
  locked,
}

@doc("Represents an access policy.")
model AccessPolicy {
  @doc("The date-time the policy is active.")
  Start: string;
  
  @doc("The date-time the policy expires.")
  Expiry: string;
  
  @doc("The permissions for acl the policy.")
  Permission: string;
}

@doc("The access tiers.")
enum AccessTier {
  @doc("The hot P4 tier.")
  P4,
  @doc("The hot P6 tier.")
  P6,
  @doc("The hot P10 tier.")
  P10,
  @doc("The hot P15 tier.")
  P15,
  @doc("The hot P20 tier.")
  P20,
  @doc("The hot P30 tier.")
  P30,
  @doc("The hot P40 tier.")
  P40,
  @doc("The hot P50 tier.")
  P50,
  @doc("The hot P60 tier.")
  P60,
  @doc("The hot P70 tier.")
  P70,
  @doc("The hot P80 tier.")
  P80,
  @doc("The hot access tier.")
  Hot,
  @doc("The cool access tier.")
  Cool,
  @doc("The archive access tier.")
  Archive,
}

@doc("The archive status.")
enum ArchiveStatus {
  @doc("The archive status is rehydrating pending to hot.")
  `rehydrate-pending-to-hot`,
  @doc("The archive status is rehydrating pending to cool.")
  `rehydrate-pending-to-cool`,
  @doc("The archive status is rehydrating pending to archive.")
  `rehydrate-pending-to-archive`,
  @doc("The archive status is rehydrating pending to expired.")
  `rehydrate-pending-to-expired`,
}

@doc("An Azure Storage Blob")
model BlobItem {
  // TODO: Add XML attribute of Encoded
  @doc("The name of the blob.")
  Name: string;

  @doc("Whether the blob is deleted.")
  Deleted: boolean;

  @doc("The snapshot of the blob.")
  Snapshot: string;

  @doc("The version id of the blob.")
  VersionId?: string;

  @doc("Whether the blob is the current version.")
  IsCurrentVersion?: boolean;

  @doc("The properties of the blob.")
  Properties: BlobProperties;

  @doc("The metadata of the blob.")
  Metadata?: BlogMetadata;

  @doc("The tags of the blob.")
  Tags?: BlobTags;

  @doc("The object replication metadata of the blob.")
  ObjectReplicationMetadata?: ObjectReplicationMetadata;

  @doc("Whether the blog has versions only.")
  HasVersionsOnly?: boolean;
}

@doc("The properties of a blob.")
model BlobProperties {
  @doc("The date-time the blob was created in RFC1123 format.")
  `Creation-Time`?: DateTimeKnownEncoding.rfc7231;

  @doc("The date-time the blob was last modified in RFC1123 format.")
  `Last-Modified`: DateTimeKnownEncoding.rfc7231;

  @doc("The blog ETag.")
  ETag: string;

  @doc("The content length of the blob.")
  `Content-Length`?: int64;

  @doc("The content type of the blob.")
  `Content-Type`?: string;

  @doc("The content encoding of the blob.")
  `Content-Encoding`?: string;

  @doc("The content language of the blob.")
  `Content-Language`?: string;

  @doc("The content MD5 of the blob.")
  `Content-MD5`?: string;

  @doc("The content disposition of the blob.")
  `Content-Disposition`?: string;

  @doc("The cache control of the blob.")
  `Cache-Control`?: string;

  @doc("The sequence number of the blob.")
  `x-ms-blob-sequence-number`?: int64;

  @doc("The blob type.")
  `Blob-Type`: "BlockBlob" | "PageBlob" | "AppendBlob";

  @doc("The lease status of the blob.")
  LeaseStatus?: LeaseStatus;

  @doc("The lease state of the blob.")
  LeaseState?: LeaseState;

  @doc("The lease duration of the blob.")
  LeaseDuration?: LeaseDuration;

  @doc("The copy ID of the blob.")
  CopyId?: string;

  @doc("The copy status of the blob.")
  CopyStatus?: CopyStatus;

  @doc("The copy source of the blob.")
  CopySource?: string;

  @doc("The copy progress of the blob.")
  CopyProgress?: string;

  @doc("The copy completion time of the blob.")
  CopyCompletionTime?: DateTimeKnownEncoding.rfc7231;

  @doc("The copy status description of the blob.")
  CopyStatusDescription?: string;

  @doc("Whether the blog is encrypted on the server.")
  ServerEncrypted?: boolean;

  @doc("Whether the blog is incremental copy.")
  IncrementalCopy?: boolean;

  @doc("The name of the desination snapshot.")
  DestinationSnapshot?: string;

  @doc("The time the blob was deleted.")
  DeletedTime?: DateTimeKnownEncoding.rfc7231;

  @doc("The remaining retention days of the blob.")
  RemainingRetentionDays?: int32;

  @doc("The access tier of the blob.")
  AccessTier?: AccessTier;

  @doc("Whether the access tier is inferred.")
  AccessTierInferred?: boolean;

  @doc("The archive status of the blob.")
  ArchiveStatus?: ArchiveStatus;

  @doc("The encryption scope of the blob.")
  EncryptionScope?: string;

  @doc("The access tier change time of the blob.")
  AccessTierChangeTime?: DateTimeKnownEncoding.rfc7231;

  @doc("The number of tags for the blob.")
  TagCount?: int32;

  @doc("The expire time of the blob.")
  `Expiry-Time`?: DateTimeKnownEncoding.rfc7231;
}

model BlogMetadata {

}

model BlobTags {

}

model ObjectReplicationMetadata {

}
