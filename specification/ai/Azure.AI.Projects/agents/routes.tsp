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
  get is AgentOperations.ResourceRead<Agent>;

  @doc("Delete a deployed agent")
  delete is AgentOperations.ResourceDelete<Agent>;

  @doc("get revisions of an agent")
  @Rest.action("listPreviousVersions")
  getPreviousVersions is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {},
    Azure.Core.Page<Agent>
  >;

  @doc("Revert latest revision of an agent")
  @Rest.action("deploy")
  deploy is Azure.Core.Foundations.ResourceOperation<
    Agent,
    {
      @doc("The deployment request parameters")
      @Http.bodyRoot
      deploymentRequest: AgentDeploymentRequest;
    },
    void
  >;
}
