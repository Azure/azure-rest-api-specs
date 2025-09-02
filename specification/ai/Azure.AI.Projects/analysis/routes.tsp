import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias AnalysisServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias AnalysisOperations = Azure.Core.ResourceOperations<AnalysisServiceTraits>;

@route("analysis")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface Analysis {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Run a one-off cluster error analysis.")
  @post
  @route("error-clusters")
  createErrorClusterReport is Azure.Core.Foundations.Operation<
    {
      @header("Repeatability-Request-ID")
      @doc("Unique, client-generated identifier for ensuring request idempotency. Use the same ID for retries to prevent duplicate evaluations.")
      repeatabilityRequestId?: string;

      @doc("Timestamp indicating when this request was first initiated. Used in conjunction with repeatability-request-id for idempotency control.")
      @header("Repeatability-First-Sent")
      repeatabilityFirstSent?: utcDateTime;

      @doc("Complete evaluation configuration including data source, evaluators, and result settings")
      @body
      request: ErrorClusterReport;
    },
    ResourceCreatedResponse<ErrorClusterReport>
  >;

  @doc("Get a specific cluster error analysis.")
  @get
  getErrorClusterReport is AnalysisOperations.ResourceRead<ErrorClusterReport>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("errors-clusters:latest")
  @doc("Get the latest cluster error analysis.")
  @get
  getLatestErrorClusterReport is Operation<{}, OkResponse<ErrorClusterReport>>;

  @doc("List all cluster error analyses.")
  @get
  listErrorClusterReports is AnalysisOperations.ResourceList<
    ErrorClusterReport,
    ListQueryParametersTrait<{
      @query("scope")
      @doc("The scope of the analysis.")
      scope?: AnalysisScope;

      @query("scopeId")
      @doc("The unique identifier for the scope.")
      scopeId?: string;

      @query("state")
      @doc("The state of the analysis.")
      state?: OperationState;
    }>
  >;
}
