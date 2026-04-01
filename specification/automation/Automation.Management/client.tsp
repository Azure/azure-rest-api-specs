import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automation;

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
@@alternateType(softwareUpdateConfigurationProperties.error,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "java"
);
@@alternateType(updateConfigurationMachineRunProperties.error,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "go"
);
@@clientLocation(AutomationAccounts.convertGraphRunbookContent, "Client", "go");

@@clientLocation(AutomationAccounts.convertGraphRunbookContent,
  Microsoft.Automation,
  "python,javascript"
);
@@clientLocation(deletedAutomationAccountsOperationGroup.listBySubscription,
  "DeletedAutomationAccounts",
  "python"
);
@@clientName(AutomationAccounts.automation, "listAutomation", "javascript");
@@clientName(UserAssignedIdentitiesProperties,
  "ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties",
  "javascript"
);
@@alternateType(UnknownType.unknownType, Record<unknown>, "javascript");
