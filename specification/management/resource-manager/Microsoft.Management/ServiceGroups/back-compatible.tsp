import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Management;

@@clientName(Microsoft.Management, "ServiceGroupsMgmtClient", "python");

@@clientLocation(ServiceGroups.createOrUpdateServiceGroup,
  Microsoft.Management
);
@@clientName(ServiceGroups.createOrUpdateServiceGroup::parameters.resource,
  "createServiceGroupRequest"
);
@@clientLocation(ServiceGroups.updateServiceGroup, Microsoft.Management);
@@clientName(ServiceGroups.updateServiceGroup::parameters.properties,
  "updateServiceGroupRequest"
);
@@clientLocation(ServiceGroups.deleteServiceGroup, Microsoft.Management);
