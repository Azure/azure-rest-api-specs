import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kusto;

@@clientName(Microsoft.Kusto, "KustoManagementClient", "javascript,python");
@@clientName(Microsoft.Kusto.ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties,
  "IdentityUserAssignedIdentities",
  "java"
);
@@clientName(Microsoft.Kusto.PublicIPType, "PublicIpType", "java");
@@clientName(Microsoft.Kusto.ClusterProperties.publicIPType,
  "publicIpType",
  "java"
);
@@access(CalloutPoliciesList, Access.public, "java");
@@access(LanguageExtensionsList, Access.public, "java");

@@clientName(IotHubDataFormat.W3CLOGFILE, "W3_CLOGFILE", "python");
@@clientName(EventHubDataFormat.W3CLOGFILE, "W3_CLOGFILE", "python");
@@clientName(EventGridDataFormat.W3CLOGFILE, "W3_CLOGFILE", "python");
