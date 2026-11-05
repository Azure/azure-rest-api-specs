import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureDataTransfer;

@@clientName(ActionType, "DateTransferActionType", "!autorest");
@@clientName(Microsoft.AzureDataTransfer, "DataTransferMgmtClient", "python");

@@clientName(FlowProperties.sourceAddresses, "streamSourceAddresses", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing flattened C# SourceAddresses collection name; automatic flattening otherwise renames both the collection and its wrapper to StreamSourceAddresses."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FlowProperties.sourceAddresses, "csharp");
