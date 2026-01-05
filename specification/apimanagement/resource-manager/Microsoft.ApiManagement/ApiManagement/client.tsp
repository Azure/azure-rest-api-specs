import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(Microsoft.ApiManagement.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(Microsoft.ApiManagement.TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java,python"
);
@@clientName(Microsoft.ApiManagement.ConnectivityCheckRequest.preferredIPVersion,
  "preferredIpVersion",
  "java"
);

@@clientName(Microsoft.ApiManagement.ApiManagementSkuCosts.meterID,
  "meterId",
  "java"
);
@@clientName(Microsoft.ApiManagement.KeyVaultLastAccessStatusContractProperties.timeStampUtc,
  "timestampUtc",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.HostnameConfiguration.hostName,
  "hostname",
  "java"
);

@@clientLocation(Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.get,
  "ApiManagementWorkspaceLinkOperations",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.listByService,
  "ApiManagementWorkspaceLinkOperations",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementServiceOperationGroup.checkNameAvailability,
  "ResourceProviders",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementServiceOperationGroup.getDomainOwnershipIdentifier,
  "ResourceProviders",
  "java"
);

@@clientName(Microsoft.ApiManagement, "ApiManagementClient", "python");
@@clientName(ConnectivityCheckRequestProtocolConfigurationHttpConfiguration,
  "ConnectivityCheckRequestProtocolConfigurationHTTPConfiguration",
  "python"
);

