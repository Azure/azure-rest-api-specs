import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("AFDOrigin group comprising of origins is used for load balancing to origins when the content cannot be served from CDN.")
@parentResource(Profile)
model AFDOriginGroup is ProxyResource<AFDOriginGroupProperties> {
  @doc("Name of the origin group which is unique within the endpoint.")
  @key("originGroupName")
  @segment("originGroups")
  name: string;
}

@armResourceOperations
interface FrontDoorOriginGroups {
  @doc("Gets an existing origin group within a profile.")
  get is ArmResourceRead<AFDOriginGroup>;
  @doc("Creates a new origin group within the specified profile.")
  create is ArmResourceCreateOrUpdateAsync<AFDOriginGroup>;
  @doc("Updates an existing origin group within a profile.")
  update is ArmCustomPatchAsync<AFDOriginGroup, AFDOriginGroupUpdateParameters>;
  @doc("Deletes an existing origin group within a profile.")
  delete is ArmResourceDeleteAsync<AFDOriginGroup>;
  @doc("Lists all of the existing origin groups within a profile.")
  listByProfile is ArmResourceListByParent<AFDOriginGroup>;
  @doc("Checks the quota and actual usage of the given AzureFrontDoor origin group under the given CDN profile.")
  listResourceUsage is ArmResourceActionSync<
    AFDOriginGroup,
    void,
    UsagesListResult
  >;
}
