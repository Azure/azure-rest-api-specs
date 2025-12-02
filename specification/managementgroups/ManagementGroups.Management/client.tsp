import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Management;

namespace ClientCustomizations;

@@clientName(Microsoft.Management, "ManagementGroupsMgmtClient", "python");

@@clientLocation(checkNameAvailability, "API", "go");
@@clientLocation(startTenantBackfill, "API", "go");
@@clientLocation(tenantBackfillStatus, "API", "go");
@@usage(CreateManagementGroupChildInfo, Usage.input, "javascript");
