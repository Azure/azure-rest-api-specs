import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./typespec/azureMonitorWorkspace.tsp";
import "./typespec/pipelineGroup.tsp";

using Microsoft.Monitor;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureMonitorWorkspace.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PipelineGroup.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
