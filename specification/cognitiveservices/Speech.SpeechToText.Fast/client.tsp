import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using SpeechToText;
using Azure.ClientGenerator.Core;

namespace SpeechToText.ClientCustomizations;

@@clientName(Phrase, "TranscribedPhrase", "csharp");
@@clientName(Word, "TimestampedWord", "csharp");
@@clientName(TranscribeDefinition, "TranscribeMetadata", "csharp");
