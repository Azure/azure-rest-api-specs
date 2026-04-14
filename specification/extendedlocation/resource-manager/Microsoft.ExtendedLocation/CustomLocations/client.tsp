import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ExtendedLocation,
  "CustomLocationsManagementClient",
  "javascript"
);
@@clientName(Microsoft.ExtendedLocation,
  "CustomLocationsMgmtClient",
  "python"
);
