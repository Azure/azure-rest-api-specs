import "@typespec/http";
import "@typespec/openapi";

import "../common";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace VoiceLive;

@route("/audio")
interface Audio {
  @route("speech")
  @post
  @operationId("createSpeech")
  @tag("Audio")
  @summary("Generates audio from the input text.")
  createSpeech(
    @header accept: "application/octet-stream",
    @body requestBody: CreateSpeechRequest,
  ): {
    /** chunked */
    @header("Transfer-Encoding") transferEncoding?: string;

    @header contentType: "application/octet-stream";
    @body responseBody: bytes;
  } | SseResponseOf<CreateSpeechResponseStreamEvent> | ErrorResponse;
}
