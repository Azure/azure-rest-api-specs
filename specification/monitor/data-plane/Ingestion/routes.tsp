import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace LogsIngestion;

/**
 * Ingestion API used to directly ingest data using Data Collection Rules.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@summary("Ingestion API used to directly ingest data using Data Collection Rules.")
@route("/dataCollectionRules/{ruleId}/streams/{stream}")
@post
op upload is Azure.Core.Foundations.Operation<
  {
    /** The immutable ID of the Data Collection Rule resource. */
    @path
    ruleId: string;

    /** The streamDeclaration name as defined in the Data Collection Rule. */
    @path("stream")
    streamName: string;

    /** The content encoding of the request body which is always 'gzip'. */
    @header("Content-Encoding")
    contentEncoding?: string;

    /** The array of objects matching the schema defined by the provided stream. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem"
    @alternateType(unknown, "go")
    @clientName("logs", "go")
    @body
    body: Record<unknown>[];

    ...ClientRequestIdHeader;
  },
  void
>;
