import "@azure-tools/typespec-client-generator-core";
import "./LiftrBase.Storage/main.tsp";

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LiftrBase.Storage.FileSystemResource.properties,
  "autorest"
);
