import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/audio/audio_speech.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

@doc("Generates text-to-speech audio from the input text.")
@added(ServiceApiVersions.v2024_02_15_Preview)
@action("audio/speech")
@actionSeparator("/")
op generateSpeechFromText is ResourceAction<
  Deployment,
  SpeechGenerationOptions,
  SpeechGenerationResponse
>;
