import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using CustomVoiceApi;

// AZC0012: Rename generic interface/client names for C#
@@clientName(Projects, "CustomVoiceProjects", "csharp");
@@clientName(Consents, "CustomVoiceConsents", "csharp");
@@clientName(Endpoints, "CustomVoiceEndpoints", "csharp");
@@clientName(Operations, "CustomVoiceOperations", "csharp");
@@clientName(Models, "CustomVoiceModels", "csharp");

// AZC0012: Rename generic model names for C#
@@clientName(Model, "CustomVoiceModel", "csharp");
@@clientName(Endpoint, "CustomVoiceEndpoint", "csharp");
@@clientName(Dataset, "CustomVoiceDataset", "csharp");
@@clientName(Status, "CustomVoiceStatus", "csharp");
@@clientName(Project, "CustomVoiceProject", "csharp");
@@clientName(Recipe, "CustomVoiceRecipe", "csharp");
@@clientName(Consent, "CustomVoiceConsent", "csharp");

// AZC0034: Operation conflicts with Azure.Operation from Azure.Core
@@clientName(Operation, "CustomVoiceOperation", "csharp");

@@clientName(ConsentPostFormData.audiodata, "audioData", "java");
