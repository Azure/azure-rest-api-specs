//
// This file is used for emitting the Python client (package azure-ai-voiceagents).
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
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "VoiceAgentsClient");

// --------------------------------------------------------------------------------
// Namespace remapping
// --------------------------------------------------------------------------------
// The voice routes reuse OpenAI Realtime/Responses leaf models; emit any remaining
// OpenAI types under this package's namespace to avoid a circular dependency in Python.
@@clientNamespace(OpenAI, "azure.ai.voiceagents", "python");

// --------------------------------------------------------------------------------
// Type workarounds
// --------------------------------------------------------------------------------
// VoiceAgentAvatarVideoCrop's corners are declared as a [uint32, uint32] tuple type
// (VoiceAgentAvatarVideoCoordinate), which @typespec/http-client-python cannot emit
// ("Not supported tuple"). Represent them as a two-element array for this client instead.
@@alternateType(VoiceAgentAvatarVideoCrop.bottom_right, uint32[], "python");
@@alternateType(VoiceAgentAvatarVideoCrop.top_left, uint32[], "python");
