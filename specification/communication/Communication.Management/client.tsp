import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

@@clientName(Microsoft.Communication,
  "CommunicationServiceManagementClient",
  "javascript,python"
);
@@clientName(CommunicationServices_ProvisioningState,
  "CommunicationServicesProvisioningState",
  "python"
);
@@clientName(Domains_ProvisioningState,
  "DomainsProvisioningState",
  "python"
);
@@clientName(EmailServices_ProvisioningState,
  "EmailServicesProvisioningState",
  "python"
);
