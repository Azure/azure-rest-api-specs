import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Azure.ResourceManager.CommonTypes.Origin,
  "ArmOrigin",
  "python,go"
);
