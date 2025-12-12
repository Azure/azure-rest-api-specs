import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Cache, "RedisEnterpriseManagementClient", "javascript");

// Ensure AccessPolicyAssignments interface generates with full client name prefix in Go
@@clientName(Microsoft.Cache, "RedisEnterpriseManagementClient", "go");
