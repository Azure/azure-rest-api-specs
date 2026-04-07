import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

@@clientLocation(NetworkSecurityPerimeterConfigurations.getNSP, "ActionGroups");
@@clientLocation(NetworkSecurityPerimeterConfigurations.listNSP,
  "ActionGroups"
);
@@clientLocation(NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "ActionGroups"
);
