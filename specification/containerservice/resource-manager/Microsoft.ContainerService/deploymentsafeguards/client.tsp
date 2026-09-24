import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Microsoft.ContainerService;

@@clientName(
  Microsoft.ContainerService,
  "ContainerServiceSafeguardsMgmtClient",
  "python"
);

@@alternateType(DeploymentSafeguard.eTag, Azure.Core.eTag, "csharp");
