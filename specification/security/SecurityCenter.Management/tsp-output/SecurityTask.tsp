import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AscLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security task that we recommend to do in order to strengthen security")
@parentResource(AscLocation)
model SecurityTask is ProxyResource<SecurityTaskProperties> {
  @doc("Name of the task object, will be a GUID")
  @key("taskName")
  @segment("tasks")
  name: string;
}

@armResourceOperations
interface Tasks {
  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  getSubscriptionLevelTask is ArmResourceRead<SecurityTask>;
  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  listByHomeRegion is ArmResourceListByParent<
    SecurityTask,
    {
      ...BaseParameters<SecurityTask>;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
