import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

// Rename the request model to follow .NET naming conventions (AZC0030)
@@clientName(TranscribeRequestContent, "TranscribeRequestContent", "csharp");

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");

// Java: Make models use setters instead of builders for backward compatibility
@@access(TranscriptionOptions, Access.public, "java");
@@access(TranscriptionDiarizationOptions, Access.public, "java");
@@access(EnhancedModeProperties, Access.public, "java");
@@access(PhraseListProperties, Access.public, "java");
