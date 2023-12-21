import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("Run resource properties")
@parentResource(Registry)
model Run is ProxyResource<RunProperties> {
  @doc("The run ID.")
  @path
  @key("runId")
  @segment("runs")
  name: string;
}

@armResourceOperations
interface Runs {
  @doc("Gets the detailed information for a given run.")
  get is ArmResourceRead<Run>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Patch the run properties.")
  update is ArmCustomPatchAsync<Run, RunUpdateParameters>;
  @doc("Gets all the runs for a registry.")
  list is ArmResourceListByParent<
    Run,
    {
      ...BaseParameters<Run>;

      @doc("The runs filter to apply on the operation. Arithmetic operators are not supported. The allowed string function is 'contains'. All logical operators except 'Not', 'Has', 'All' are allowed.")
      @query("$filter")
      $filter?: string;

      @doc("$top is supported for get list of runs, which limits the maximum number of runs to return.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Gets a link to download the run logs.")
  getLogSasUrl is ArmResourceActionSync<Run, void, RunGetLogResult>;
  @doc("Cancel an existing run.")
  cancel is ArmResourceActionAsync<Run, void, void>;
}
