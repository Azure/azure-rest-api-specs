import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

@@clientName(Microsoft.Communication,
  "CommunicationServiceManagementClient",
  "javascript,python,java"
);
@@clientName(CommunicationServices_ProvisioningState,
  "CommunicationServicesProvisioningState",
  "python"
);
@@clientName(Domains_ProvisioningState, "DomainsProvisioningState", "python");
@@clientName(EmailServices_ProvisioningState,
  "EmailServicesProvisioningState",
  "python"
);

// Rename properties in DomainPropertiesVerificationStates to restore fluent method names
@@clientName(DomainPropertiesVerificationStates.DKIM, "dkim", "java");
@@clientName(DomainPropertiesVerificationStates.DKIM2, "dkim2", "java");
@@clientName(DomainPropertiesVerificationStates.SPF, "spf", "java");
@@clientName(DomainPropertiesVerificationStates.DMARC, "dmarc", "java");

// Rename properties in DomainPropertiesVerificationRecords to restore fluent method names
@@clientName(DomainPropertiesVerificationRecords.DKIM, "dkim", "java");
@@clientName(DomainPropertiesVerificationRecords.DKIM2, "dkim2", "java");
@@clientName(DomainPropertiesVerificationRecords.SPF, "spf", "java");
@@clientName(DomainPropertiesVerificationRecords.DMARC, "dmarc", "java");

@@clientName(CommunicationServiceProperties.hostName, "hostname", "java");
