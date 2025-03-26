import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "./models.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

#suppress "@azure-tools/typespec-azure-core/byos" "Support streaming input files"
@post
@route("/transcriptions:transcribe")
@doc("Transcribes the provided audio stream.")
op transcribe is Azure.Core.RpcOperation<
  {
    @header @doc("request content type") contentType: "multipart/form-data";

    @doc("The body of the multipart request.")
    @multipartBody
    body: {
      @clientName("options")
      @doc("Metadata for a transcription request. This field contains a JSON-serialized object of type `TranscribeDefinition`.")
      definition?: HttpPart<TranscriptionOptions>;

      @doc("The content of the audio file to be transcribed. The audio file must be shorter than 2 hours in audio duration and smaller than 250 MB in size.")
      audio: HttpPart<bytes>;
    };
  },
  TranscriptionResult
>;
