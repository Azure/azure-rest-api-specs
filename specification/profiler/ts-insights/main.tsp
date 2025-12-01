import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Foundations;
using Http;
using Rest;
using Versioning;

@server(
  "{endpoint}",
  "App Insights Profiler and Debugger service endpoint",
  {
    /** Fully-qualified base URI of the Profiler & Debugger service (e.g. https://dataplane.diagnosticservices.azure.com). */
    endpoint: url,
  }
)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["api://dataplane.diagnosticservices.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "App Insights Profiler and Debugger" })
@versioned(Microsoft.DiagnosticServices.Versions)
namespace Microsoft.DiagnosticServices;

@doc("The App Insights Profiler and Debugger service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-01-07-preview version of the App Insights Profiler and Debugger service.")
  `2025-01-07-preview`,
}

@doc("The code optimization insights.")
@resource("insights")
model Insights {
  @key("key")
  @doc("The key of the insight. MD5 hash of the aggregated properties (IssueCategory, Function, ParentFunction, AppId, RoleName, IssueId). Joined with a underscore.")
  @visibility(Lifecycle.Read)
  key: string;

  @doc("Number of insights returned with the record.")
  count: int64;

  @doc("The Application ID.")
  appId: uuid;

  @doc("The registry ID correlating to an issue in the issue registry.")
  issueId: string;

  @doc("The largest threshold value in the result list.")
  criteria: float64;

  @doc("A string to describe where the issue is.")
  issueCategory: string;

  @doc("A relation descriptor for criteria to value. See the substitute below for an example.")
  relation: string = "<";

  @doc("Value of the performance metric.")
  value: float64;

  @doc("If the blob is derived from, or closely associated with another blob, then the value is the URI to the original artifact. For example, this is used for the output of a transcoder, or the result of running analysis on an ingested artifact. Blobs without Provenance may be deleted by the clean-up service. Blobs with Provenance may be deleted when the primary artifact is deleted by the clean-up service.")
  provenance?: string;

  @doc("The CorrelationId. Used to track artifacts across services. One is created if not provided.")
  correlationId?: string;

  @doc("Source that produced the artifact. (e.g. 'Agent', 'PerfLens', 'Transcoder', 'Aggregator')")
  source?: string;

  @doc("The role name, if any.")
  roleName?: string;

  @doc("A list of all containers that have insights in this result.")
  containers: string[];

  @doc("The most recent timestamp from this result.")
  timestamp: utcDateTime;

  @doc("The call stack of the issue.")
  context?: string[];

  @doc("The symbol that is the bottleneck of the issue.")
  symbol?: string;

  @doc("The parent symbol of the issue.")
  parentSymbol?: string;

  @doc("Processed method used in rationale")
  function?: string;

  @doc("Processed component used in rationale")
  parentFunction?: string;

  @doc("Total number of trace occurrences across all insights in this result.")
  traceOccurrences: int64;

  @doc("Whether the issue is automatically fixable.")
  isFixable: boolean = false;
}

interface InsightsService {
  /**
   * Retrieves performance insights for multiple applications over a specified time interval.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @post
  @route("/api/apps/bulk/insights/rollups")
  listBulkInsights(
    @query
    @doc("The start of the time interval.")
    startTime: utcDateTime,

    @query
    @doc("The end of the time interval.")
    endTime: utcDateTime,

    @query
    @doc("How many rows to return.")
    take?: int64,

    /**
     * The API version to use.
     */
    ...Azure.Core.Foundations.ApiVersionParameter,

    @body
    @doc("The request body.")
    requestBody: {
      @doc("The Application IDs.")
      appIds: uuid[];
    },
  ): Insights[] | ErrorResponse;
}
