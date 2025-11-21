import "@azure-tools/typespec-client-generator-core";

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LiftrBase.Storage.FileSystemResource.properties,
  "autorest"
);
