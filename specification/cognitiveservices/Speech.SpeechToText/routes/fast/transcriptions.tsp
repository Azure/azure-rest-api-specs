import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

import "../../models/transcriptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

using Azure.Core;

namespace Azure.Speech.SpeechToText.Fast;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is an existing service, the api-version is required to be in the 'api-version' parameter"
#suppress "@azure-tools/typespec-azure-core/byos" "Support streaming input files"
@post
@route("/transcriptions:transcribe")
@doc("Transcribes the provided audio stream.")
op transcribeTranscription(
  @header @doc("request content type") contentType: "multipart/form-data",

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,

  @madeOptional(ServiceApiVersions.V20241115)
  @doc("Metadata for a fast transcription request. This field contains a JSON-serialized object of type `TranscribeDefinition`.")
  definition?: TranscribeDefinition,

  @doc("The content of the audio file to be transcribed. The audio file must be shorter than 2 hours in audio duration and smaller than 250 MB in size.")
  audio: bytes,
): {
  @statusCode statusCode: 200;
  @body transcription: TranscribeResult;
};
