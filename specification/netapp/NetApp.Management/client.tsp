import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.NetApp,
  "NetAppManagementClient",
  "java,python,javascript"
);

// Fix property name case changes
@@clientName(Microsoft.NetApp.AccountProperties.nfsV4IDDomain,
  "nfsV4IdDomain",
  "java"
);
@@clientName(Microsoft.NetApp.ActiveDirectory.kdcIP, "kdcIp", "java");
@@clientName(Microsoft.NetApp.ActiveDirectory.ldapOverTLS,
  "ldapOverTls",
  "java"
);
@@clientName(Microsoft.NetApp.RemotePath.externalHostName,
  "externalHostname",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.accessedTimeStamp,
  "accessedTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.modifiedTimeStamp,
  "modifiedTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.changedTimeStamp,
  "changedTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.creationTimeStamp,
  "creationTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.VolumeGroupListProperties.groupMetaData,
  "groupMetadata",
  "java"
);

// Fix model name changes
@@clientName(Microsoft.NetApp.VolumeGroupMetaData,
  "VolumeGroupMetadata",
  "java"
);

@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserRequest,
  "GetGroupIdListForLDAPUserRequest",
  "go,python"
);

@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserResponse,
  "GetGroupIdListForLDAPUserResponse",
  "go,python"
);

@@clientName(Microsoft.NetApp.NetAppProvisioningState,
  "NetappProvisioningState",
  "go"
);

@@clientName(Microsoft.NetApp.ReplicationSchedule._10minutely,
  "10Minutely",
  "javascript"
);
