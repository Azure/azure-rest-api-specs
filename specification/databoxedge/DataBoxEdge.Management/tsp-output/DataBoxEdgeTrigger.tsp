import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
// FIXME: DataBoxEdgeTrigger has no properties property
@doc("Trigger details.")
@parentResource(DataBoxEdgeDevice)
model DataBoxEdgeTrigger is ProxyResource<{}> {
  @doc("The trigger name.")
  @path
  @key("name")
  @segment("triggers")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataBoxEdgeTriggers {
  @doc("Get a specific trigger by name.")
  get is ArmResourceRead<DataBoxEdgeTrigger>;
  @doc("Creates or updates a trigger.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeTrigger>;
  @doc("Deletes the trigger on the gateway device.")
  delete is ArmResourceDeleteAsync<DataBoxEdgeTrigger>;
  @doc("Lists all the triggers configured in the device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    DataBoxEdgeTrigger,
    {
      ...BaseParameters<DataBoxEdgeTrigger>;

      @doc("Specify $filter='CustomContextTag eq <tag>' to filter on custom context tag property")
      @query("$filter")
      $filter?: string;
    }
  >;
}
