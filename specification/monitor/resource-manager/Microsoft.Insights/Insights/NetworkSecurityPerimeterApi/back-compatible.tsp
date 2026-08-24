import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NetworkSecurityPerimeterApi;

@@clientLocation(NetworkSecurityPerimeterConfigurations.getNSP, "ActionGroups");
@@clientLocation(
  NetworkSecurityPerimeterConfigurations.listNSP,
  "ActionGroups"
);
@@clientLocation(
  NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "ActionGroups"
);
