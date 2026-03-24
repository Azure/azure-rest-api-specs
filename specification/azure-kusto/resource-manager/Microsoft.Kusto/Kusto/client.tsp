import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
@@clientName(Microsoft.Kusto, "KustoManagementClient", "javascript");
@@clientName(Microsoft.Kusto.ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties,
  "IdentityUserAssignedIdentities",
  "java"
);
@@clientName(Microsoft.Kusto.ClusterProperties.publicIPType,
  "publicIpType",
  "java"
);
@@clientName(Microsoft.Kusto.LanguageExtensionsList,
  "LanguageExtensionsListPage",
  "java"
);
@@clientName(Microsoft.Kusto.LanguageExtensionsListRequest,
  "LanguageExtensionsList",
  "java"
);
@@clientName(Microsoft.Kusto.CalloutPoliciesList,
  "CalloutPoliciesListPage",
  "java"
);
@@clientName(Microsoft.Kusto.CalloutPoliciesListRequest,
  "CalloutPoliciesList",
  "java"
);
@@alternateType(Microsoft.Kusto.ClusterProperties.languageExtensions,
  Microsoft.Kusto.LanguageExtensionsListRequest,
  "java"
);
