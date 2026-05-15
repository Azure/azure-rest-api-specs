import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Storage.DataLake;

namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.DataLake,
  },
  "go"
)
interface FileSystemClient extends FileSystem {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.DataLake,
  },
  "go"
)
interface PathClient extends Path {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.DataLake,
  },
  "go"
)
interface ServiceClient extends Service {}

@@clientName(
  Storage.DataLake.EtagResponseHeader.eTag,
  "etag",
  "javascript,python"
);
@@clientName(Storage.DataLake.FileSystemItem.eTag, "etag", "javascript,python");
@@clientName(Storage.DataLake.PathItem.eTag, "etag", "javascript,python");

@@clientName(Storage.DataLake.BlobItem, "BlobItemModel", "javascript");
@@clientName(
  Storage.DataLake.BlobPropertiesInternal,
  "BlobPropertiesModel",
  "javascript"
);
@@clientName(
  Storage.DataLake.BlobPropertiesInternal.isSealed,
  "sealed",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.DataLake.StorageError,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.DataLake.StorageError,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.DataLake, "includeRootSlash", false, "javascript");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.DataLake,
  "omitSlashFromEmptyRoute",
  true,
  "csharp,python"
);

@@clientName(Storage.DataLake.PathItem, "Path", "python");
@@clientName(Storage.DataLake.BlobItem, "BlobItemInternal", "python");

// csharp customizations

// Make resource a client-level parameter for FileSystem
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model FileSystemClientParameters {
  resource: Storage.DataLake.FileSystemResourceType;
}

@@clientInitialization(
  Storage.DataLake.FileSystem,
  {
    parameters: FileSystemClientParameters,
  },
  "csharp"
);

/** The algorithm used to produce the encryption key hash. Currently, the only accepted value is \"AES256\". Must be provided if the x-ms-encryption-key header is provided. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum EncryptionAlgorithmTypeCustom {
  /** Deprecated */
  None: "None",

  /** AES256 */
  AES256: "AES256",
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Legacy.disablePageable(
  Storage.DataLake.Service.listFileSystems,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Legacy.disablePageable(
  Storage.DataLake.FileSystem.listPaths,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Legacy.disablePageable(
  Storage.DataLake.FileSystem.listBlobHierarchySegment,
  "python,javascript,csharp,go"
);

@@clientName(Storage.DataLake.Service, "ServiceRestClient", "csharp");
@@clientName(Storage.DataLake.FileSystem, "FileSystemRestClient", "csharp");
@@clientName(Storage.DataLake.Path, "PathRestClient", "csharp");
@@clientName(Storage.DataLake.LeaseAction, "DataLakeLeaseAction", "csharp");
@@clientName(Storage.DataLake.PathItem, "Path", "csharp");
@@clientName(Storage.DataLake.BlobItem, "BlobItemInternal", "csharp");
@@clientName(
  EncryptionAlgorithmTypeCustom,
  "EncryptionAlgorithmType",
  "csharp,go"
);

@@alternateType(Storage.DataLake.PathItem.lastModified, utcDateTime, "csharp");
@@alternateType(Storage.DataLake.PathItem.contentLength, string, "csharp");
@@alternateType(Storage.DataLake.PathItem.isDirectory, string, "csharp");
@@alternateType(Storage.DataLake.PathItem.eTag, string, "csharp");
@@alternateType(Storage.DataLake.BlobPropertiesInternal.etag, string, "csharp");
@@alternateType(
  Storage.DataLake.EncryptionAlgorithmType,
  EncryptionAlgorithmTypeCustom,
  "csharp,go"
);
@@alternateType(Storage.DataLake.IfMatchParameter.ifMatch, string, "csharp");
@@alternateType(
  Storage.DataLake.IfNoneMatchParameter.ifNoneMatch,
  string,
  "csharp"
);
@@alternateType(
  Storage.DataLake.SourceIfMatchParameter.sourceIfMatch,
  string,
  "csharp"
);
@@alternateType(
  Storage.DataLake.SourceIfNoneMatchParameter.sourceIfNoneMatch,
  string,
  "csharp"
);

@@access(Storage.DataLake.PathGetPropertiesAction, Access.public, "csharp");
@@access(Storage.DataLake.PathLeaseAction, Access.public, "csharp");
@@access(Storage.DataLake.PathRenameMode, Access.public, "csharp");
@@access(Storage.DataLake.PathUpdateAction, Access.public, "csharp");

// Go customizations

/** The show only filter for list blobs. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
@clientName("ListBlobsShowOnly", "go")
enum ListBlobsShowOnlyGo {
  /** Show only deleted blobs. */
  deleted: "deleted",

  /** Show only directories. */
  directories: "directories",
}
@@alternateType(ListBlobsShowOnly, ListBlobsShowOnlyGo, "go");
@@clientName(PathItem, "Path", "go");
@@clientName(BlobItem, "PathItemInternal", "go");
@@clientName(BlobHierarchyListSegment.blobItems, "PathItems", "go");
@@clientName(BlobPropertiesInternal, "PathPropertiesInternal", "go");
@@clientName(BlobPrefix, "PathPrefix", "go");
@@clientName(BlobItem, "PathItemInternal", "go");
@@clientName(ClientRequestIdParameter.clientRequestId, "RequestID", "go");
@@clientName(
  ListBlobsHierarchySegmentResponse,
  "ListPathsHierarchySegmentResponse",
  "go"
);
@@clientName(BlobHierarchyListSegment, "PathHierarchyListSegment", "go");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  FileSystem.listBlobHierarchySegment,
  "responseEnvelopeName",
  "FileSystemClientListPathHierarchySegmentResponse",
  "go"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(PathItem, "omitSerdeMethods", "all", "go");
