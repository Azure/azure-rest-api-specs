import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "./models.tsp";

using TypeSpec.Http;

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
    body: TranscriptionContent;
  },
  TranscriptionResult
>;
