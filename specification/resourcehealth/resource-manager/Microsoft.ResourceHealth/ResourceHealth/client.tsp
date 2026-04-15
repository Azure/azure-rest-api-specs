import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.ResourceManager.CommonTypes.ProxyResource,
  "ArmProxyResource",
  "python"
);

@@clientName(Microsoft.ResourceHealth, "ResourceHealthMgmtClient", "python");
