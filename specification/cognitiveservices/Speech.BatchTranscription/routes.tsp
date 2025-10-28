import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;

namespace Azure.Ai.Speech.BatchTranscription;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

// Request model for creating a transcription (excludes read-only properties)
@doc("Request model for creating a new transcription job.")
model TranscriptionJobCreate {
  @doc("TranscriptionProperties")
  properties: TranscriptionProperties;

  @doc("EntityReference")
  `model`?: EntityReference;

  @doc("EntityReference")
  dataset?: EntityReference;

  @doc("A list of content urls to get audio files to transcribe. Up to 1000 urls are allowed.\r\nThis property will not be returned in a response.")
  contentUrls?: Array<url>;

  @doc("A URL for an Azure blob container that contains the audio files. A container is allowed to have a maximum size of 5GB and a maximum number of 10000 blobs.\r\nThe maximum size for a blob is 2.5GB.\r\nContainer SAS should contain 'r' (read) and 'l' (list) permissions.\r\nThis property will not be returned in a response.")
  contentContainerUrl?: url;

  @minLength(1)
  @doc("The locale of the contained data. If Language Identification is used, this locale is used to transcribe speech for which no language could be detected.")
  locale: string;

  @minLength(1)
  @doc("The display name of the object.")
  displayName: string;

  @doc("The description of the object.")
  description?: string;

  @doc("The custom properties of this entity. The maximum allowed key length is 64 characters, the maximum\r\nallowed value length is 256 characters and the count of allowed entries is 10.")
  customProperties?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
#suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "This is an existing service, we have a non-conforming operation."
@post
@route("/transcriptions:submit")
@doc("Starts a new transcription job.")
op startTranscription is Azure.Core.Foundations.Operation<
  TranscriptionJobCreate,
  TranscriptionJob
>;

@get
@sharedRoute
@doc("Gets the transcription identified by the given ID.")
op getTranscription is Operations.ResourceRead<TranscriptionJob>;

@delete
@doc("Deletes the specified transcription task.")
@sharedRoute
op deleteTranscription is Operations.ResourceDelete<TranscriptionJob>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service, operation name cannot be changed."
@get
@route("/transcriptions")
@doc("Gets a list of transcriptions for the authenticated subscription.")
op listTranscriptions is Azure.Core.Foundations.Operation<
  {
    /** Maximum number of transcriptions to return */
    @query top?: int32;

    /** Number of transcriptions to skip */
    @query skip?: int32;

    /** Filter expression for transcriptions */
    @query filter?: string;
  },
  SpeechToTextCustomPage<TranscriptionJob>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service, operation name cannot be changed."
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "This is an existing service, operation signature cannot be changed."
@get
@route("/transcriptions/{id}/files")
@doc("Gets the files of the transcription identified by the given ID")
op listTranscriptionFiles is Azure.Core.Foundations.Operation<
  {
    /** Transcription job identifier */
    @path id: string;

    /** Maximum number of files to return */
    @query top?: int32;

    /** Number of files to skip */
    @query skip?: int32;

    /** Filter expression for files */
    @query filter?: string;
  },
  SpeechToTextCustomPage<TranscriptionFile>
>;
