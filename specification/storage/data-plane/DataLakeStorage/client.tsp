import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@clientNamespace(Storage.DataLake, "Azure.Storage.Files.DataLake", "!python");

@@clientName(Storage.DataLake.EtagResponseHeader.eTag, "etag", "javascript");
@@clientName(Storage.DataLake.FileSystemItem.eTag, "etag", "javascript");
@@clientName(Storage.DataLake.PathItem.eTag, "etag", "javascript");

@@clientName(Storage.DataLake.BlobItemInternal, "BlobItemModel", "javascript");
@@clientName(Storage.DataLake.BlobPropertiesInternal,
  "BlobPropertiesModel",
  "javascript"
);
@@clientName(Storage.DataLake.BlobPropertiesInternal.isSealed,
  "sealed",
  "javascript"
);

@@clientOption(Storage.DataLake.StorageError,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
@@clientOption(Storage.DataLake.StorageError,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

@@clientOption(Storage.DataLake, "includeRootSlash", false, "javascript");
