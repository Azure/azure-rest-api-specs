import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Management;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "For backward compatibility"
namespace Microsoft.Management;

@@clientName(Microsoft.Management,
  "ServiceGroupsManagementClient",
  "javascript"
);

// Rename the ServiceGroups interface to avoid C# namespace-type name conflict
// (namespace segment "ServiceGroups" would conflict with the interface type)
@@clientName(ServiceGroups, "ServiceGroupClient", "csharp");

// Rename ServiceGroupCollectionResponse to avoid AZC0030 (model name ending with 'Response')
@@clientName(ServiceGroupCollectionResponse,
  "ServiceGroupCollectionResult",
  "csharp"
);
