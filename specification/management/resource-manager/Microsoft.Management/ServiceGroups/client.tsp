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

// csharp: avoid name collision between the ServiceGroups operation interface
// and the ServiceGroups namespace segment; rename the model factory ProvisioningState
// to keep the historical SDK name; hide the page envelope from the public API.
@@clientName(ServiceGroups, "ServiceGroupsOperationGroup", "csharp");
@@clientName(ProvisioningState, "ServiceGroupProvisioningState", "csharp");
@@access(ServiceGroupCollectionResponse, Access.internal, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mark listAncestors as pageable to match the previous SDK Pageable<ServiceGroupResource> return type"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(ServiceGroups.listAncestors,
  "csharp"
);
