import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;


alias AgentServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias AgentOperations = Azure.Core.ResourceOperations<AgentServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v1)
interface Agents {
  @doc("Get a deployed agent.")
  get is DeploymentOperations.ResourceRead<Agent>;

  @doc("List all deployed agents in the project")
  list is DeploymentOperations.ResourceList<
    Agent,
    ListQueryParametersTrait<{
      @doc("blueprint to filter on")
      @query("blueprintId")
      blueprintId?: string;
    }>
  >;

  @doc("updates revisions of an agent")
  @Rest.action("updateRevisions")
  updateRevisions is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {
      @doc("The updated revision log")
      @Http.bodyRoot
      revisionUpdateRequest: AgentRevisionUpdateRequest;
    },
    void
  >;

  @doc("get revisions of an agent")
  @Rest.action("listRevisions")
  getRevisions is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {},
    AgentRevisionGetResponse
  >;

  @doc("Revert latest revision of an agent")
  @Rest.action("revertLatest")
  revertLatest is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {},
    void
  >;

  @doc("Revert latest revision of an agent")
  @Rest.action("deploy")
  deployAgent is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {
      @doc("The deployment request parameters")
      @Http.bodyRoot
      deploymentRequest: AgentDeploymentRequest;
    },
    void
  >;

 @doc("Pause or resume an agent instance")
  @Rest.action("pauseOrResume")
  pauseOrResumeAgent is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {
      @doc("The pause or resume request parameters")
      @Http.bodyRoot
      pauseOrResumeRequest: PauseOrResumeRequest;
    },
    void
  >;
}
