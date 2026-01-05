import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.HealthBot;

@@clientName(Microsoft.HealthBot, "HealthbotClient", "javascript");
@@clientName(Microsoft.HealthBot, "HealthBotMgmtClient", "python");
@@clientName(IdentityType, "IdentityType", "python");
