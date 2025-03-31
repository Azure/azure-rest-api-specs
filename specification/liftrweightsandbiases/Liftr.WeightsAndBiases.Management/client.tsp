import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.WeightsAndBiases, "WeightsAndBiasesMgmt", "python");
@@clientName(Microsoft.WeightsAndBiases,
  "WeightsAndBiasesManagementClient",
  "java"
);
