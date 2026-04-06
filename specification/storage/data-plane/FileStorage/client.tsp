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

@@alternateType(Storage.File.AccessPolicy.start, utcDateTime, "go");
@@alternateType(Storage.File.AccessPolicy.expiry, utcDateTime, "go");

@@alternateType(Storage.File.AccessPolicy.start, string, "javascript,python");
@@alternateType(Storage.File.AccessPolicy.expiry, string, "javascript,python");
@@clientName(Storage.File.AccessPolicy.start, "startsOn", "javascript");
@@clientName(Storage.File.AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(Storage.File.AccessPolicy.permission, "permissions", "javascript");

@@alternateType(Storage.File.UserDelegationKey.signedStart,
  string,
  "javascript,python"
);
@@alternateType(Storage.File.UserDelegationKey.signedExpiry,
  string,
  "javascript,python"
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

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.Error,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.Error,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.MetadataHeaders.metadata,
  "headerCollectionPrefix",
  "x-ms-meta",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File, "includeRootSlash", false, "javascript");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File, "omitSlashFromEmptyRoute", true, "python,csharp");

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.Service.listSharesSegment,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.Directory.listFilesAndDirectoriesSegment,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.Directory.listHandles,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.File.listHandles,
  "python,javascript,csharp"
);

// csharp customizations
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model ShareClientParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRequestIntent?: ShareTokenIntent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model FileClientParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRequestIntent?: ShareTokenIntent;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowTrailingDot?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowSourceTrailingDot?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRangeWriteFromUrl: FileRangeWriteFromUrlType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model DirectoryClientParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRequestIntent?: ShareTokenIntent;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowTrailingDot?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowSourceTrailingDot?: boolean;
}

@@clientInitialization(Storage.File,
  {
    parameters: ShareClientParameters,
  },
  "csharp"
);

@@clientInitialization(Storage.File.Directory,
  {
    parameters: DirectoryClientParameters,
  },
  "csharp"
);

@@clientInitialization(Storage.File.File,
  {
    parameters: FileClientParameters,
  },
  "csharp"
);

@@alternateType(AccessPolicy.start, utcDateTime, "csharp");
@@alternateType(AccessPolicy.expiry, utcDateTime, "csharp");
@@alternateType(MetadataHeaders.metadata, Record<string>, "csharp");
@@alternateType(FileProperty.eTag, string, "csharp");

@@clientName(Storage.File, "ShareClient", "csharp");
@@clientName(AccessPolicy.start, "StartsOn", "csharp");
@@clientName(AccessPolicy.expiry, "ExpiresOn", "csharp");
@@clientName(Directory, "DirectoryRestClient", "csharp");
@@clientName(File, "FileRestClient", "csharp");
@@clientName(Service, "ServiceRestClient", "csharp");
@@clientName(Share, "ShareRestClient", "csharp");
@@clientName(StorageErrorCode, "ShareErrorCode", "csharp");
@@clientName(PermissionCopyModeType, "PermissionCopyMode", "csharp");
@@access(FileRangeWriteFromUrlType, Access.internal, "csharp");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.MetadataHeaders.metadata,
  "collectionHeaderPrefix",
  "x-ms-meta-",
  "csharp"
);
