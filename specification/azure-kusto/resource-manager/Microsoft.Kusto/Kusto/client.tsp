import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Kusto, "KustoManagementClient", "javascript");
@@clientName(Microsoft.Kusto.ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties,
  "UserAssignedIdentity",
  "java"
);
@@access(Microsoft.Kusto.CalloutPoliciesList, Access.public, "java");
@@access(Microsoft.Kusto.LanguageExtensionsList, Access.public, "java");
@@clientName(Microsoft.Kusto.PublicIPType, "PublicIpType", "java");
