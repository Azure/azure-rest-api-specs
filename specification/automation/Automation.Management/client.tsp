import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automation;

@@clientName(ErrorResponse, "AutomationErrorResponse", "java");

// Model renames
@@clientName(SUCScheduleProperties, "SucScheduleProperties", "java");
@@clientName(UserAssignedIdentitiesProperties,
  "IdentityUserAssignedIdentities",
  "java"
);

// Property renames
@@clientName(DscNodeReport.hostName, "hostname", "java");
@@clientName(CredentialProperties.userName, "username", "java");
@@clientName(CredentialCreateOrUpdateProperties.userName, "username", "java");
@@clientName(CredentialUpdateProperties.userName, "username", "java");

// Interface/client renames
@@clientLocation(AutomationAccounts.convertGraphRunbookContent,
  "ResourceProviders",
  "java"
);

// Type renames for provisioning state enums
/**
 * Provisioning state for DSC Configuration
 */
union DscConfigurationProvisioningState {
  /** The provisioning state succeeded */
  Succeeded: "Succeeded",
  string,
}
@@alternateType(DscConfigurationProperties.provisioningState,
  DscConfigurationProvisioningState,
  "java"
);

/**
 * Provisioning state for Runbook
 */
union RunbookProvisioningState {
  /** The provisioning state succeeded */
  Succeeded: "Succeeded",
  string,
}
@@alternateType(RunbookProperties.provisioningState,
  RunbookProvisioningState,
  "java"
);
