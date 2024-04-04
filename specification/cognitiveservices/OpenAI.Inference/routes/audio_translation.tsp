import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/audio/audio_translation.tsp";
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
Gets English language transcribed text and associated metadata from provided spoken audio data.
""")
@added(ServiceApiVersions.v2024_02_15_Preview)
@actionSeparator("/")
@action("audio/translations")
@sharedRoute
op getAudioTranslationAsPlainText is Azure.Core.ResourceAction<
  Deployment,
  AudioTranslationOptions,  // response_format must be one of: text, srt, vtt
  AudioTextResponse,
  MultipartFormDataRequestHeadersTraits & TextPlainResponseHeadersTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
@doc("""
Gets English language transcribed text and associated metadata from provided spoken audio data.
""")
@added(ServiceApiVersions.v2024_02_15_Preview)
@actionSeparator("/")
@action("audio/translations")
@sharedRoute
op getAudioTranslationAsResponseObject is Azure.Core.ResourceAction<
  Deployment,
  AudioTranslationOptions,  // response_format must be unspecified (json) or one of: json, verbose_json
  AudioTranslation,
  MultipartFormDataRequestHeadersTraits
>;
