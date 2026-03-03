import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using CustomVoiceApi;

// AZC0012: Rename generic interface/client names for C#
@@clientName(Projects, "CustomVoiceProjects", "csharp");
@@clientName(Consents, "CustomVoiceConsents", "csharp");
@@clientName(Endpoints, "CustomVoiceEndpoints", "csharp");

// AZC0012: Rename generic model names for C#
@@clientName(Model, "CustomVoiceModel", "csharp");
@@clientName(Endpoint, "CustomVoiceEndpoint", "csharp");
@@clientName(Dataset, "CustomVoiceDataset", "csharp");
@@clientName(Status, "CustomVoiceStatus", "csharp");

// AZC0034: Operation conflicts with Azure.Operation from Azure.Core
@@clientName(Operation, "CustomVoiceOperation", "csharp");
