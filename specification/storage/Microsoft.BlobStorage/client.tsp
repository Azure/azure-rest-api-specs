import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Blob;

namespace Customizations;

@@clientNamespace(Storage.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.AppendBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.BlockBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.PageBlob, "Azure.Storage.Blobs");

@@clientName(Storage.Blob.Service, "BlobServiceClient", "rust");
@@clientName(Storage.Blob.Container, "BlobContainerClient", "rust");
@@clientName(Storage.Blob.Blob, "BlobClient", "rust");
@@clientName(Storage.Blob.AppendBlob, "AppendBlobClient", "rust");
@@clientName(Storage.Blob.BlockBlob, "BlockBlobClient", "rust");
@@clientName(Storage.Blob.PageBlob, "PageBlobClient", "rust");

@@clientName(ContainerProperties.denyEncryptionScopeOverride,
  "PreventEncryptionScopeOverride"
);
@@clientName(ContainerProperties.immutableStorageWithVersioningEnabled,
  "IsImmutableStorageWithVersioningEnabled"
);
@@clientName(BlobPropertiesInternal.expiryTime, "ExpiresOn");
@@clientName(BlobPropertiesInternal.sealed, "IsSealed");
@@clientName(BlobPropertiesInternal.lastAccessTime, "LastAccessedOn");
@@clientName(BlobPropertiesInternal.immutabilityPolicyUntilDate,
  "ImmutabilityPolicyExpiresOn"
);
@@clientName(MetadataHeaders.metadata, "metadata", "rust");
@@clientName(ObjectReplicationHeaders.objectReplicationRules,
  "objectReplicationRules",
  "rust"
);
@@clientName(ImmutabilityPolicyExpiryRequiredParameter.immutabilityPolicyExpiry,
  "expiry"
);

@@alternateType(AccessPolicy.start, string, "javascript");
@@alternateType(AccessPolicy.expiry, string, "javascript");
@@clientName(AccessPolicy.start, "startsOn", "javascript");
@@clientName(AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(AccessPolicy.permission, "permissions", "javascript");
@@clientName(BlobPropertiesInternal.accessTierChangeTime,
  "accessTierChangedOn",
  "javascript"
);
@@clientName(BlobPropertiesInternal.creationTime, "createdOn", "javascript");
@@clientName(BlobPropertiesInternal.copyCompletionTime,
  "copyCompletedOn",
  "javascript"
);
@@clientName(BlobPropertiesInternal.deletedTime, "deletedOn", "javascript");
@@clientName(ContainerProperties.deletedTime, "deletedOn", "javascript");
@@clientName(GeoReplication.lastSyncTime, "lastSyncOn", "javascript");
@@clientName(KeyInfo.start, "startsOn", "javascript");
@@clientName(KeyInfo.expiry, "expiresOn", "javascript");
@@clientName(BlobServiceProperties.logging,
  "blobAnalyticsLogging",
  "javascript"
);
@@clientName(Logging.delete, "deleteProperty", "javascript");
@@clientName(UserDelegationKey.signedOid, "signedObjectId", "javascript");
@@clientName(UserDelegationKey.signedTid, "signedTenantId", "javascript");
@@clientName(UserDelegationKey.signedStart, "signedStartsOn", "javascript");
@@clientName(UserDelegationKey.signedExpiry, "signedExpiresOn", "javascript");

@@alternateType(BlobPropertiesInternal.contentLength, uint64, "rust");
@@alternateType(BlobContentLengthRequired.size, uint64, "rust");
@@alternateType(ContentLengthResponseHeader.contentLength, uint64, "rust");
@@alternateType(ContentLengthParameter.contentLength, uint64, "rust");
@@alternateType(StructuredContentLengthParameter.structuredContentLength,
  uint64,
  "rust"
);
@@alternateType(StructuredContentLengthResponseHeader.structuredContentLength,
  uint64,
  "rust"
);

@@scope(Storage.Blob.Container.submitBatch, "!rust");
@@scope(Storage.Blob.Service.submitBatch, "!rust");

@@clientName(BlobPropertiesInternal, "BlobProperties", "go");
@@clientName(BlobItemInternal, "BlobItem", "go");
@@clientName(UserDelegationKey.signedOid, "SignedOID", "go");
@@clientName(UserDelegationKey.signedTid, "SignedTID", "go");
@@alternateType(AccessPolicy.start, utcDateTime, "go");
@@alternateType(AccessPolicy.expiry, utcDateTime, "go");
@@alternateType(BlobItemInternal.name, string, "go");
@@alternateType(BlobPrefix.name, string, "go");
