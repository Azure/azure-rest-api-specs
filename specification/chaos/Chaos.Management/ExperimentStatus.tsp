import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Experiment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Chaos;
@doc("Model that represents the status of a Experiment.")
@parentResource(Experiment)
model ExperimentStatus is ProxyResource<ExperimentStatusProperties> {
  @doc("GUID that represents a Experiment status.")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  @path
  @key("statusId")
  @segment("statuses")
  name: string;
}

@armResourceOperations
interface ExperimentStatuses {
  @doc("Get a status of a Experiment resource.")
  getStatus is ArmResourceRead<ExperimentStatus>;
  @doc("Get a list of statuses of a Experiment resource.")
  listAllStatuses is ArmResourceListByParent<ExperimentStatus>;
}
