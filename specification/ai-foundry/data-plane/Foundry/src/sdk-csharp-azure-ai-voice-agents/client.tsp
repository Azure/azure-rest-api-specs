//
// This file is used for emitting the .NET client (package Azure.AI.VoiceAgents).
//
// It is a dedicated permutation of the Foundry API surface that consumes only the
// voice-first prompt agent routes authored under ../voice-agents (Azure/azure-rest-api-specs#43970),
// plus the shared default error. It does not modify any existing sdk-* folder.
//

import "../voice-agents/routes.tsp";
import "../toolboxes/models.tsp";
import "../sdk-common/error.default.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Fix the xref.
// --------------------------------------------------------------------------------
// The voice routes reuse OpenAI Realtime/Responses leaf models; emit any remaining
// OpenAI and Azure.Core.Foundations types under this package's namespace.
// Azure.AI.Projects is the root spec namespace the voice routes/models live in; without
// this remap every generated type would leak into the Azure.AI.Projects namespace.
@@clientNamespace(Azure.AI.Projects, "Azure.AI.VoiceAgents", "csharp");
@@clientNamespace(OpenAI, "Azure.AI.VoiceAgents", "csharp");
@@clientNamespace(Azure.Core.Foundations, "Azure.AI.VoiceAgents", "csharp");

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "VoiceAgentsClient");

// The `VoiceAgents` operation-group subclient would otherwise share the exact name of
// this package's namespace tail (Azure.AI.VoiceAgents), which C# forbids (it escapes the
// namespace to Azure.AI._VoiceAgents). Rename the subclient to match Python's generated
// operation-group name (VoiceAgentsOperations) and keep the namespace clean.
@@clientName(Azure.AI.Projects.VoiceAgents, "VoiceAgentsOperations", "csharp");
