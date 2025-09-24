import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DevCenter, "DevCenterMgmtClient", "python");

@@clientName(Microsoft.DevCenter.DevCenterProjectCatalogSettings,
  "ProjectCatalogSettingsInfo",
  "go"
);

@@clientName(Microsoft.DevCenter.DevCenterSku, "SkuInfo", "go");

@@clientName(Microsoft.DevCenter.UserRoleAssignment, "UserRoleAssignmentValue");
