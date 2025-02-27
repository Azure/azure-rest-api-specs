import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "../models/fast.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace SpeechToText.FastTranscriptionClient;

#suppress "@azure-tools/typespec-azure-core/byos" "Support streaming input files"
@post
@route("/transcriptions:transcribe")
@doc("Transcribes the provided audio stream.")
op transcribe is Azure.Core.RpcOperation<
  {
    @header @doc("request content type") contentType: "multipart/form-data";

    @doc("Metadata for a fast transcription request. This field contains a JSON-serialized object of type `TranscribeDefinition`.")
    definition?: TranscribeDefinition;

    @doc("The content of the audio file to be transcribed. The audio file must be shorter than 2 hours in audio duration and smaller than 250 MB in size.")
    audio: bytes;
  },
  TranscribeResult
>;
