import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Logic;

@@clientName(WorkflowTriggerListCallbackUrlQueries.`api-version`, "apiVersion");

@@clientName(PartnerContent.b2b, "b2B");

@@clientName(ApiResourceMetadata.apiType, "apiType");

@@clientName(WsdlService.endpointQualifiedNames, "endpointQualifiedNames");

@@clientName(SwaggerCustomDynamicTreeSettings.canSelectParentNodes,
  "canSelectParentNodes"
);
@@clientName(SwaggerCustomDynamicTreeSettings.canSelectLeafNodes,
  "canSelectLeafNodes"
);
