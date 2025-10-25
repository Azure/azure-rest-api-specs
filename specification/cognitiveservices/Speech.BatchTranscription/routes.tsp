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
alias CustomOperations = CustomResourceOperations<ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
#suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "This is an existing service, we have a non-conforming operation."
@post
@route("/transcriptions:submit")
@doc("Starts a new transcription job.")
op startTranscription is CustomOperations.ResourceCreate<TranscriptionJob>;

@get
@sharedRoute
@doc("Gets the transcription identified by the given ID.")
op getTranscription is Operations.ResourceRead<TranscriptionJob>;

@delete
@doc("Deletes the specified transcription task.")
@sharedRoute
op deleteTranscription is Operations.ResourceDelete<TranscriptionJob>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@get
@doc("Gets a list of transcriptions for the authenticated subscription.")
op listTranscriptions is CustomOperations.ResourceListWithCustomPage<
  TranscriptionJob,
  ListQueryParametersTrait<TopQueryParameter &
    SkipQueryParameter &
    FilterQueryParameter>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@get
@doc("Gets the files of the transcription identified by the given ID")
op listTranscriptionFiles is CustomOperations.ResourceListWithCustomPage<
  TranscriptionFile,
  ListQueryParametersTrait<TopQueryParameter &
    SkipQueryParameter &
    FilterQueryParameter>
>;
