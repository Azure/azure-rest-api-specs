import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@clientNamespace(Storage.DataLake, "Azure.Storage.Files.DataLake", "!python, !csharp");

@@clientName(Storage.DataLake.EtagResponseHeader.eTag,
  "etag",
  "javascript,python"
);
@@clientName(Storage.DataLake.FileSystemItem.eTag, "etag", "javascript,python");
@@clientName(Storage.DataLake.PathItem.eTag, "etag", "javascript,python");

@@clientName(Storage.DataLake.BlobItemInternal, "BlobItemModel", "javascript");
@@clientName(Storage.DataLake.BlobPropertiesInternal,
  "BlobPropertiesModel",
  "javascript"
);
@@clientName(Storage.DataLake.BlobPropertiesInternal.isSealed,
  "sealed",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.DataLake.StorageError,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.DataLake.StorageError,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.DataLake, "includeRootSlash", false, "javascript");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.DataLake, "omitSlashFromEmptyRoute", true, "csharp,python");

@@clientName(Storage.DataLake.PathItem, "Path", "python");

// csharp customizations

// Make resource a client-level parameter for FileSystem
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model FileSystemClientParameters {
  resource: Storage.DataLake.FileSystemResourceType;
}

@@clientInitialization(Storage.DataLake.FileSystem,
  {
    parameters: FileSystemClientParameters,
  },
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Legacy.disablePageable(Storage.DataLake.Service.listFileSystems, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Legacy.disablePageable(Storage.DataLake.FileSystem.listPaths, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Legacy.disablePageable(Storage.DataLake.FileSystem.listBlobHierarchySegment, "csharp");

@@clientName(Storage.DataLake.Service, "ServiceRestClient", "csharp");
@@clientName(Storage.DataLake.FileSystem, "FileSystemRestClient", "csharp");
@@clientName(Storage.DataLake.Path, "PathRestClient", "csharp");
@@clientName(Storage.DataLake.LeaseAction, "DataLakeLeaseAction", "csharp");
@@clientName(Storage.DataLake.PathItem, "Path", "csharp");

@@alternateType(Storage.DataLake.PathItem.lastModified, utcDateTime, "csharp");
@@alternateType(Storage.DataLake.PathItem.contentLength, string, "csharp");
@@alternateType(Storage.DataLake.PathItem.isDirectory, string, "csharp");

@@access(Storage.DataLake.PathGetPropertiesAction, Access.`public`, "csharp");
@@access(Storage.DataLake.PathLeaseAction, Access.`public`, "csharp");
@@access(Storage.DataLake.PathRenameMode, Access.`public`, "csharp");
@@access(Storage.DataLake.PathUpdateAction, Access.`public`, "csharp");
