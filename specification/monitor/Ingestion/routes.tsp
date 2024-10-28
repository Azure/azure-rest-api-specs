import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace LogsIngestionClient;

/**
 * Ingestion API used to directly ingest data using Data Collection Rules.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@summary("Ingestion API used to directly ingest data using Data Collection Rules.")
@route("/dataCollectionRules/{ruleId}/streams/{stream}")
@post
op upload is Azure.Core.Foundations.Operation<
  {
    @doc("The immutable ID of the Data Collection Rule resource.")
    @path
    ruleId: string;

    @doc("The streamDeclaration name as defined in the Data Collection Rule.")
    @clientName("streamName")
    @path
    stream: string;

    @doc("The content encoding of the request body which is always 'gzip'.")
    @header("Content-Encoding")
    contentEncoding?: string;

    #suppress "@azure-tools/typespec-azure-core/request-body-problem"
    @doc("The array of objects matching the schema defined by the provided stream.")
    @body
    body: Record<unknown>[];

    ...ClientRequestIdHeader;
  },
  void
>;
