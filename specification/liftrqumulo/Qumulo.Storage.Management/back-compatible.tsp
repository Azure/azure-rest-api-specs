import "@azure-tools/typespec-client-generator-core";
import "./LiftrBase.Storage/main.tsp";

<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LiftrBase.Storage.FileSystemResource.properties,
  "autorest"
);
