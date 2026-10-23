import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureDataTransfer;

@@clientName(ActionType, "DateTransferActionType", "!autorest");

@@clientName(FlowProperties.sourceAddresses, "streamSourceAddresses", "csharp");
