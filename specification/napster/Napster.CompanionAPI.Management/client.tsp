import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Napster.CompanionAPI;

@@clientName(Napster.CompanionAPI, "NapsterOmniAgentApiMgmtClient", "python");
