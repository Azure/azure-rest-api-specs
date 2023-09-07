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
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionSimpleJson is AOAIMultipartRequestDeploymentAction<
  AudioTranscriptionOptionsSimpleJson,
  AudioTranscriptionSimpleJson
>;

#suppress "@azure-tools/typespec-azure-core/byos"
@doc("Transcribes audio into the input language.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionVerboseJson is AOAIMultipartRequestDeploymentAction<
  AudioTranscriptionOptionsVerboseJson,
  AudioTranscriptionVerboseJson
>;

#suppress "@azure-tools/typespec-azure-core/byos"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Transcribes audio into the input language.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionPlainText is AOAIMultipartTextPlainAction<
  AudioTranscriptionOptionsPlainText
>;

#suppress "@azure-tools/typespec-azure-core/byos"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Transcribes audio into the input language.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionSrt is AOAIMultipartTextPlainAction<
  AudioTranscriptionOptionsSrt
>;

#suppress "@azure-tools/typespec-azure-core/byos"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Transcribes audio into the input language.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionVtt is AOAIMultipartTextPlainAction<
  AudioTranscriptionOptionsVtt
>;

#suppress "@azure-tools/typespec-azure-core/byos"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/translations") //@convenientAPI(true)
@sharedRoute
op getAudioTranslationSimpleJson is AOAIMultipartRequestDeploymentAction<
  AudioTranslationOptionsSimpleJson,
  AudioTranscriptionSimpleJson
>;

#suppress "@azure-tools/typespec-azure-core/byos"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@sharedRoute
@action("audio/translations") //@convenientAPI(true)
op getAudioTranslationVerboseJson is AOAIMultipartRequestDeploymentAction<
  AudioTranslationOptionsVerboseJson,
  AudioTranscriptionVerboseJson
>;

#suppress "@azure-tools/typespec-azure-core/byos"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@sharedRoute
@action("audio/translations") //@convenientAPI(true)
op getAudioTranslationPlainText is AOAIMultipartTextPlainAction<
  AudioTranslationOptionsPlainText
>;

#suppress "@azure-tools/typespec-azure-core/byos"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@sharedRoute
@action("audio/translations") //@convenientAPI(true)
op getAudioTranslationSrt is AOAIMultipartTextPlainAction<
  AudioTranslationOptionsSrt
>;

#suppress "@azure-tools/typespec-azure-core/byos"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Transcribes and translates input audio into English text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@sharedRoute
@action("audio/translations") //@convenientAPI(true)
op getAudioTranslationVtt is AOAIMultipartTextPlainAction<
  AudioTranslationOptionsVtt
>;
