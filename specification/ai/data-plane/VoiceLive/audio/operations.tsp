import "@typespec/http";
import "@typespec/openapi";

import "../common";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace OpenAI;

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

  @route("transcriptions")
  @post
  @operationId("createTranscription")
  @tag("Audio")
  @summary("Transcribes audio into the input language.")
  createTranscription(
    ...AcceptJsonOrEventStreamHeader,
    @header contentType: "multipart/form-data",
    @body requestBody: CreateTranscriptionRequest,
  ):
    | CreateTranscriptionResponseVerboseJson
    | CreateTranscriptionResponseJson
    | SseResponseOf<CreateTranscriptionResponseStreamEvent>
    | {
        // TODO: This response is not defined in the OpenAPI spec.
        @header contentType: "text/plain";

        @body responseBody: string;
      }
    | ErrorResponse;

  @route("translations")
  @post
  @operationId("createTranslation")
  @tag("Audio")
  @summary("Translates audio into English..")
  createTranslation(
    @header accept: "application/json",
    @header contentType: "multipart/form-data",
    @body requestBody: CreateTranslationRequest,
  ):
    | CreateTranslationResponseVerboseJson
    | CreateTranslationResponseJson
    | {
        // TODO: This response is not defined in the OpenAPI spec.
        @header contentType: "text/plain";

        @body responseBody: string;
      }
    | ErrorResponse;
}
