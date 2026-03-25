import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Storage.File;

namespace Customizations;

@@clientNamespace(Storage.File,
  "Azure.Storage.Files.Shares",
  "!csharp,!python"
);
@@clientNamespace(Storage.File.Service,
  "Azure.Storage.Files.Shares",
  "!csharp,!python"
);
@@clientNamespace(Storage.File.Share,
  "Azure.Storage.Files.Shares",
  "!csharp,!python"
);
@@clientNamespace(Storage.File.Directory,
  "Azure.Storage.Files.Shares",
  "!csharp,!python"
);
@@clientNamespace(Storage.File.File,
  "Azure.Storage.Files.Shares",
  "!csharp,!python"
);

@@alternateType(Storage.File.AccessPolicy.start, string, "javascript");
@@alternateType(Storage.File.AccessPolicy.expiry, string, "javascript");
@@clientName(Storage.File.AccessPolicy.start, "startsOn", "javascript");
@@clientName(Storage.File.AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(Storage.File.AccessPolicy.permission, "permissions", "javascript");

@@alternateType(Storage.File.UserDelegationKey.signedStart,
  string,
  "javascript"
);
@@alternateType(Storage.File.UserDelegationKey.signedExpiry,
  string,
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedOid,
  "signedObjectId",
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedTid,
  "signedTenantId",
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedStart,
  "signedStartsOn",
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedExpiry,
  "signedExpiresOn",
  "javascript"
);

@@clientName(Storage.File.Metrics.includeApis, "includeAPIs", "javascript");

@@clientName(Storage.File.StorageServiceProperties,
  "FileServiceProperties",
  "javascript"
);

@@clientName(Storage.File.TimeoutParameter.timeout,
  "timeoutInSeconds",
  "javascript"
);

@@clientName(Storage.File.ShareSnapshotParameter.sharesnapshot,
  "shareSnapshot",
  "javascript"
);

@@clientName(Storage.File.MaxResultsParameter.maxresults,
  "maxResults",
  "javascript"
);

@@clientName(Storage.File.ListSharesResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(Storage.File.ListFilesAndDirectoriesSegmentResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(Storage.File.ListHandlesResponse.nextMarker,
  "continuationToken",
  "javascript"
);

@@clientName(Storage.File.EtagResponseHeader.etag, "etag", "javascript");
@@clientName(Storage.File.SharePropertiesInternal.eTag, "etag", "javascript");
@@clientName(Storage.File.FileProperty.eTag, "etag", "javascript");

@@clientName(Storage.File.FileSmtPropertyRequestHeaders.fileCreationTime,
  "fileCreatedOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyRequestHeaders.fileLastWriteTime,
  "fileLastWriteOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyRequestHeaders.fileChangeTime,
  "fileChangeOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyResponseHeaders.fileCreationTime,
  "fileCreatedOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyResponseHeaders.fileLastWriteTime,
  "fileLastWriteOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyResponseHeaders.fileChangeTime,
  "fileChangeOn",
  "javascript"
);

@@clientName(Storage.File.CopyStatusResponseHeaders.copyCompletionTime,
  "copyCompletedOn",
  "javascript"
);

@@clientName(Storage.File.LeaseTimeResponseHeader.leaseTime,
  "leaseTimeInSeconds",
  "javascript"
);

@@clientName(Storage.File.OptionalBody.optionalBody, "body", "javascript");

@@clientOption(Storage.File.Error,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
@@clientOption(Storage.File.Error,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

@@clientOption(Storage.File.MetadataHeaders.metadata,
  "headerCollectionPrefix",
  "x-ms-meta",
  "javascript"
);

@@clientOption(Storage.File.MetadataHeaders.metadata,
  "collectionHeaderPrefix",
  "x-ms-meta-",
  "csharp"
);

@@clientOption(Storage.File, "includeRootSlash", false, "javascript");

@@clientOption(Storage.File, "omitSlashFromEmptyRoute", true, "python");

@@clientName(Storage.File.UserDelegationKey.signedDelegatedUserTid,
  "signedDelegatedUserTenantId",
  "javascript"
);

@@clientName(Storage.File.ShareUsageResponseHeader.shareUsageBytes,
  "usageBytes",
  "javascript"
);
@@clientName(Storage.File.ShareSnapshotUsageResponseHeader.shareSnapshotUsageBytes,
  "snapshotUsageBytes",
  "javascript"
);

@@Legacy.disablePageable(Storage.File.Service.listSharesSegment,
  "python,javascript"
);
@@Legacy.disablePageable(Storage.File.Directory.listFilesAndDirectoriesSegment,
  "python,javascript"
);
@@Legacy.disablePageable(Storage.File.Directory.listHandles,
  "python,javascript"
);
@@Legacy.disablePageable(Storage.File.File.listHandles, "python,javascript");
