import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
@@clientName(Microsoft.Kusto, "KustoManagementClient", "javascript");

@@clientName(Microsoft.Kusto.ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties,
  "IdentityUserAssignedIdentities",
  "java"
);

// Java breaking change mitigations
@@clientName(Microsoft.Kusto.PublicIPType, "PublicIpType", "java");
@@clientName(Microsoft.Kusto.ClusterProperties.publicIPType,
  "publicIpType",
  "java"
);

// Ensure paging models used only as list responses are correctly classified
@@access(Microsoft.Kusto.CalloutPoliciesList, Access.public, "java");
@@usage(Microsoft.Kusto.CalloutPoliciesList, Usage.output, "java");
@@access(Microsoft.Kusto.LanguageExtensionsList, Access.public, "java");
@@usage(Microsoft.Kusto.LanguageExtensionsList, Usage.output, "java");
