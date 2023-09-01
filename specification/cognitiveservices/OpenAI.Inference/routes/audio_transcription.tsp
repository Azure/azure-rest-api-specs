import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/audio/transcription_create.tsp";
import "../models/audio/translation_create.tsp";
import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

#suppress "@azure-tools/typespec-azure-core/byos"
@doc("Transcribes audio into the input language.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions") //@convenientAPI(true)
op getAudioTranscription is Azure.Core.ResourceAction<
    Deployment,
    AudioTranscriptionOptions,
    AudioTranscription,
    RequestHeaders
>;

#suppress "@azure-tools/typespec-azure-core/byos"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/translations") //@convenientAPI(true)
op getAudioTranslation is Azure.Core.ResourceAction<
    Deployment,
    AudioTranslationOptions,
    AudioTranscription,  // AudioTranscriptionJson for sharedRoute where content-type is app/json
    RequestHeaders
>;
