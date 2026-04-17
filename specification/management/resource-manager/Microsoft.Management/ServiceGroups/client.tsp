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
