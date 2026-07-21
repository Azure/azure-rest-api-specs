import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ContainerService;

@@clientName(Microsoft.ContainerService, "PreparedImgSpecMgmtClient", "java");
@@clientName(
  Microsoft.ContainerService,
  "ContainerServicePreparedImageSpecificationClient",
  "python"
);
@@alternateType(Azure.ResourceManager.EntityTagProperty.eTag, eTag, "csharp");
@@clientName(
  ExecutionPoint,
  "PreparedImageSpecificationExecutionPoint",
  "csharp"
);
@@clientName(ScriptType, "PreparedImageSpecificationScriptType", "csharp");
