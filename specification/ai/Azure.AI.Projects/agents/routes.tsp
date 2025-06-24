import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListAgentVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_05_01)
interface Agents
  extends VersionedOperations<
      Agent,
      InputParameters<Agent, "agent">,
      ListAgentVersionsParameters,
      ListAgentVersionsParameters
    > {
  @doc("Start a new or get an existing pending upload of a dataset for a specific version.")
  @Rest.action("deploy")
  deployAgent is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {
      @doc("The deployment request parameters")
      @Http.bodyRoot
      deploymentRequest: AgentDeploymentRequest;

      @doc("The specific version id of the Agent to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AgentDeploymentResponse
  >;

  @doc("Pause or resume an agent instance")
  @Rest.action("pauseOrResume")
  pauseOrResumeAgent is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {
      @doc("The pause or resume request parameters")
      @Http.bodyRoot
      pauseOrResumeRequest: PauseOrResumeRequest;

      @doc("The specific version id of the Agent to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    PauseOrResumeResponse;
}
