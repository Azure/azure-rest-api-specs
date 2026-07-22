import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace VoiceLive;

// VoiceLive's message/content-part hierarchy has been migrated onto OpenAI GA
// Realtime. Message items carry their own per-role inline content
// (`RealtimeConversationItemMessage{Role}Content`), and streamed response content
// parts come from the GA server events' native `part` payloads
// (`RealtimeServerEventResponseContentPart{Added,Done}Part`). No VoiceLive
// content-part models remain.
