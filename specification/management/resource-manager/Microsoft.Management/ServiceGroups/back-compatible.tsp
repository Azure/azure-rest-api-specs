import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Management;

@@clientName(Microsoft.Management, "GroupsRPAPIs", "python");

@@clientLocation(ServiceGroups.createOrUpdateServiceGroup, "");
@@clientName(ServiceGroups.createOrUpdateServiceGroup::parameters.resource,
  "createServiceGroupRequest"
);
@@clientLocation(ServiceGroups.updateServiceGroup, "");
@@clientName(ServiceGroups.updateServiceGroup::parameters.properties,
  "updateServiceGroupRequest"
);
@@clientLocation(ServiceGroups.deleteServiceGroup, "");
