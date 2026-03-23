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

@@alternateType(ReplaceContentRequest.runbookContent, string, "javascript");

@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "go"
);
