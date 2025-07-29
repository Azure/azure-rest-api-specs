import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(DeploymentScriptsClient.ContainerConfiguration,
  "ScriptContainerConfiguration",
  "csharp"
);
@@clientName(DeploymentScriptsClient.ContainerGroupSubnetId,
  "ScriptContainerGroupSubnet",
  "csharp"
);
