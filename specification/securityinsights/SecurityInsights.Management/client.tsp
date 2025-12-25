import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.SecurityInsights;
using Azure.ClientGenerator.Core;

@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "OperationActionType",
  "java"
);
@@clientName(MCASDataConnector, "McasDataConnector", "java");
@@clientName(ASCDataConnector, "AscDataConnector", "java");
@@clientName(MDATPDataConnector, "MdatpDataConnector", "java");
@@clientName(AADDataConnector, "AadDataConnector", "java");
@@clientName(AATPDataConnector, "AatpDataConnector", "java");
@@clientName(MCASDataConnectorDataTypes, "McasDataConnectorDataTypes", "java");
@@clientName(ScheduledAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "lastUpdatedDateUtc",
  "java"
);
@@clientName(ScheduledAlertRuleTemplateProperties.createdDateUTC,
  "createdDateUtc",
  "java"
);
@@clientName(FusionAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "lastUpdatedDateUtc",
  "java"
);
@@clientName(FusionAlertRuleTemplateProperties.createdDateUTC,
  "createdDateUtc",
  "java"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "lastUpdatedDateUtc",
  "java"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties.createdDateUTC,
  "createdDateUtc",
  "java"
);
@@clientName(MailMessageEntityProperties.senderIP, "senderIp", "java");
@@clientName(HostEntityProperties.omsAgentID, "omsAgentId", "java");
@@clientName(HostEntityProperties.azureID, "azureId", "java");
@@clientName(HostEntityProperties.hostName, "hostname", "java");
@@clientName(IncidentEntitiesResponse.metaData, "metadata", "java");
