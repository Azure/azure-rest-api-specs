import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.BareMetalInfrastructure;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.BareMetalInfrastructure,
  "BareMetalInfrastructureClient",
  "python"
);

@@clientName(Microsoft.BareMetalInfrastructure.OperationDisplay,
  "Display",
  "java"
);
