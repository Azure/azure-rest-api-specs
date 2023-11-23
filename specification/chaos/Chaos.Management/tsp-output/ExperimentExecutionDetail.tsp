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
@doc("Model that represents the execution details of a Experiment.")
@parentResource(Experiment)
model ExperimentExecutionDetail
  is ProxyResource<ExperimentExecutionDetailsProperties> {
  @doc("GUID that represents a Experiment execution detail.")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  @path
  @key("executionDetailsId")
  @segment("executionDetails")
  name: string;
}

@armResourceOperations
interface ExperimentExecutionDetails {
  @doc("Get an execution detail of a Experiment resource.")
  getExecutionDetails is ArmResourceRead<ExperimentExecutionDetail>;
  @doc("Get a list of execution details of a Experiment resource.")
  listExecutionDetails is ArmResourceListByParent<ExperimentExecutionDetail>;
}
