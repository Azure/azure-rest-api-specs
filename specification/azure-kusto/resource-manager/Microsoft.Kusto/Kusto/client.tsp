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

// Java breaking change mitigations - LanguageExtensionsList / CalloutPoliciesList renames
// The paging models (LanguageExtensionsList, CalloutPoliciesList) are placed in
// implementation.models by the Java emitter. Rename them to free the name for the
// request models, and use @@alternateType on the languageExtensions property so that
// it uses the public request model instead of the internal paging model.
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
