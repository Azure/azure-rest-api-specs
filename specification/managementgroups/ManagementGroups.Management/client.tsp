import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ClientCustomizations;

@@clientName(Microsoft.Management, "ManagementGroupsMgmtClient", "python");

@@clientLocation(checkNameAvailability, "API", "go");
@@clientLocation(startTenantBackfill, "API", "go");
@@clientLocation(tenantBackfillStatus, "API", "go");
