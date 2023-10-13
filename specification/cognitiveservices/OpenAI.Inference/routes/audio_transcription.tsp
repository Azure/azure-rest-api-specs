import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/audio/audio_transcription.tsp";
import "./common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

// The order in which the operations are defined matters for the purpose of OpenAPIv2 generation

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
@doc("""
Gets transcribed text and associated metadata from provided spoken audio data. Audio will be transcribed in the
written language corresponding to the language it was spoken in.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionAsPlainText is Azure.Core.Foundations.ResourceOperation<
  Deployment,
  AudioTranscriptionOptions,  // response_format must be one of: text, srt, vtt
  string,
  MultipartFormDataRequestHeadersTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
@doc("""
Gets transcribed text and associated metadata from provided spoken audio data. Audio will be transcribed in the
written language corresponding to the language it was spoken in.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionAsResponseObject is Azure.Core.ResourceAction<
  Deployment,
  AudioTranscriptionOptions,  // response_format must be unspecified (json) or one of: json, verbose_json
  AudioTranscription,
  MultipartFormDataRequestHeadersTraits
>;
