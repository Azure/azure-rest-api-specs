import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/audio/transcription_create.tsp";
import "../models/audio/translation_create.tsp";
import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
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
@sharedRoute
op getAudioTranslationJsonSimple is Azure.Core.ResourceAction<
    Deployment,
    AudioTranslationOptionsJsonSimple,
    AudioTranscriptionJsonSimple,
    RequestHeaders
>;

#suppress "@azure-tools/typespec-azure-core/byos"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@sharedRoute
@action("audio/translations") //@convenientAPI(true)
op getAudioTranslationJsonVerbose is Azure.Core.ResourceAction<
    Deployment,
    AudioTranslationOptionsJsonVerbose,
    AudioTranscriptionJsonVerbose,
    RequestHeaders
>;
