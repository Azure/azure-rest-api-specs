import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using OpenAI;

@@visibility(CreateTranscriptionResponseVerboseJson.words, "read");
@@visibility(CreateTranscriptionResponseVerboseJson.segments, "read");

@@visibility(CreateTranslationResponseVerboseJson.segments, "read");
