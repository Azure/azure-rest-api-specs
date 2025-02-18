import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using SpeechToText;
using Azure.ClientGenerator.Core;

namespace SpeechToText.ClientCustomizations;

@@clientName(Status, "ApiStatus", "csharp");
@@clientName(Transcription, "AsynchronousTranscription", "csharp");
@@clientName(File, "TranscriptionFile", "csharp");
