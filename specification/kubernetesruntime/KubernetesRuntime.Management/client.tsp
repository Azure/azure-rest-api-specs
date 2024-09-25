import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.KubernetesRuntime;

@@clientName(Microsoft.KubernetesRuntime,
  "ContainerOrchestratorRuntimeMgmt",
  "python"
);
