import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AscLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Security task that we recommend to do in order to strengthen security")
@parentResource(AscLocation)
model SecurityTask is ProxyResource<SecurityTaskProperties> {
  @doc("Name of the task object, will be a GUID")
  @path
  @key("taskName")
  @segment("tasks")
  name: string;
}

@armResourceOperations
interface SecurityTasks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  @operationId("Tasks_GetSubscriptionLevelTask")
  getSubscriptionLevelTask is ArmResourceRead<SecurityTask>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  @operationId("Tasks_ListByHomeRegion")
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
