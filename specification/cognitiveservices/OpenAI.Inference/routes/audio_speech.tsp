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

@doc("Generates audio from the input text.")
@added(ServiceApiVersions.v2024_02_15_Preview)
@action("audio/speech")
@actionSeparator("/")
op getAudioSpeech is ResourceAction<
  Deployment,
  AudioSpeechOptions,
  AudioSpeechResponse
>;
