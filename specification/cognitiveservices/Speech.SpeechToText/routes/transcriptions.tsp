import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

import "../models/transcriptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

using Azure.Core;

namespace Azure.Speech;

@post
@route("/transcriptions:submit")
@doc("Submits a new transcription job.")
op submitTranscription(
  @body transcription: Transcription,

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,
): {
  @statusCode statusCode: 201;

  @header("Location")
  @doc("The location of the created resource.")
  location?: url;

  @body transcription: Transcription;
};

@post
@route("/transcriptions:transcribe")
@doc("Transcribes the provided audio stream.")
op transcribeTranscription(
  @header contentType: "multipart/form-data",

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,

  @madeOptional(ServiceApiVersions.V20241115)
  @doc("Metadata for a fast transcription request. This field contains a JSON-serialized object of type `TranscribeDefinition`.")
  definition?: TranscribeDefinition,

  @doc("The audio as a stream of bytes.") audio: bytes,
): {
  @statusCode statusCode: 200;
  @body transcription: TranscribeResult;
};

@get
@route("/transcriptions")
@doc("Gets a list of transcriptions for the authenticated subscription.")
op getTranscriptions(
  @query("skip")
  @doc("Number of datasets that will be skipped.")
  skip?: int32,

  @query("top")
  @doc("Number of datasets that will be included after skipping.")
  top?: int32,

  @query("filter")
  @doc("A filtering expression for selecting a subset of the available transcriptions.\r\n            - Supported properties: displayName, description, createdDateTime, lastActionDateTime, status, locale.\r\n            - Operators:\r\n              - eq, ne are supported for all properties.\r\n              - gt, ge, lt, le are supported for createdDateTime and lastActionDateTime.\r\n              - and, or, not are supported.\r\n            - Example:\r\n              filter=createdDateTime gt 2022-02-01T11:00:00Z")
  filter?: string,

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,
): {
  @header("Retry-After")
  @doc("The minimum number of seconds to wait for a non terminal operation to complete.")
  retryAfter?: int32;

  @body transcriptions: Pageable<Transcription>;
};

@get
@route("/transcriptions/{id}")
@doc("Gets the transcription identified by the given ID.")
@sharedRoute
op getTranscription(
  @path @doc("The identifier of the transcription.") id: string,

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,
): {
  @header("Retry-After")
  @doc("The minimum number of seconds to wait for a non terminal operation to complete.")
  retryAfter?: int32;

  @body transcription: Transcription;
};

@patch
@route("/transcriptions/{id}")
@doc("Updates the mutable details of the transcription identified by its ID.")
@sharedRoute
op patchTranscription(
  @path @doc("The identifier of the transcription.") id: string,
  @header contentType: "application/json" | "application/merge-patch+json",

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,

  @body transcriptionUpdate: TranscriptionUpdate,
): {
  @header("Retry-After")
  @doc("The minimum number of seconds to wait for a non terminal operation to complete.")
  retryAfter?: int32;

  @body transcription: Transcription;
};

@delete
@route("/transcriptions/{id}")
@doc("Deletes the specified transcription task.")
@sharedRoute
op deleteTranscription(
  @path @doc("The identifier of the transcription.") id: string,

  @query("api-version")
  @doc("The identifier of the transcription.")
  serviceApiVersionsQueryParameter?: ServiceApiVersions,
): {
  @statusCode statusCode: 204;
};
