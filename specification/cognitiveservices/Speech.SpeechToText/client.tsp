import "./main.tsp";
import "./models/batch.tsp";
import "./models/fast.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using SpeechToText.FastTranscriptionClient;
using SpeechToText.BatchTranscriptionClient;

namespace SpeechToText;

@@clientName(Phrase, "TranscribedPhrase", "csharp");
@@clientName(Word, "TranscribedWord", "csharp");
@@clientName(TranscribeDefinition, "TranscribeMetadata", "csharp");
