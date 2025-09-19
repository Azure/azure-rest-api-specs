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
    body: {
      @doc("Metadata for a transcription request. This field contains a JSON-serialized object of type `TranscriptionOptions`.")
      definition?: HttpPart<string>;

      @doc("The content of the audio file to be transcribed. The audio file must be shorter than 2 hours in audio duration and smaller than 250 MB in size. Optional if audioUrl is provided in the definition.")
      audio?: HttpPart<bytes>;
    };
  },
  TranscriptionResult
>;

/**
 * DOCUMENTATION ENDPOINT - NOT FOR IMPLEMENTATION
 *
 * This endpoint exists solely to ensure that the TranscriptionOptions model and its
 * dependent models (EnhancedModeProperties, PhraseListProperties) are included in
 * the generated OpenAPI specification. This is required due to TypeSpec limitations
 * with multipart form data where complex models are not automatically exported.
 *
 * Implementation note: This endpoint should be excluded from actual service implementation.
 */
@doc("Internal documentation endpoint - provides schema definitions for TranscriptionOptions model")
@summary("Schema definitions (internal use only)")
@tag("Internal")
@route("/internal/schemas/transcription-options")
op getTranscriptionOptionsSchema is Azure.Core.RpcOperation<
  {
    @doc("Returns the TranscriptionOptions schema definition for reference. See the TranscriptionOptions model in the OpenAPI specification.")
    @query
    definition?: string;
  },
  TranscriptionOptions
>;
