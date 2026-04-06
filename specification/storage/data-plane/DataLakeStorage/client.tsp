import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@clientNamespace(Storage.DataLake, "Azure.Storage.Files.DataLake", "!python");

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
@@clientOption(Storage.DataLake, "omitSlashFromEmptyRoute", true, "python");

@@clientName(Storage.DataLake.PathItem, "Path", "python");
