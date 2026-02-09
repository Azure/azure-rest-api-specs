import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataFactory;

@@clientName(Microsoft.DataFactory,
  "DataFactoryManagementClient",
  "python,javascript"
);
@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python"
);
@@clientName(FactoryVstsConfiguration, "FactoryVSTSConfiguration", "go");
