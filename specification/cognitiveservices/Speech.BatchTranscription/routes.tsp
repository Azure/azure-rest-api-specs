import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.Ai.Speech.BatchTranscription;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
#suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "This is an existing service, we have a non-conforming operation."
@post
@route("/transcriptions:submit")
@doc("Starts a new transcription job.")
op startTranscription is Azure.Core.RpcOperation<
  TranscriptionJob,
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
