import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DeviceUpdateAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceUpdate;
@doc("Device Update instance details.")
@parentResource(DeviceUpdateAccount)
model DeviceUpdateInstance is TrackedResource<InstanceProperties> {
  @doc("Instance name.")
  @maxLength(36)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;
}

@armResourceOperations
interface DeviceUpdateInstances {
  @doc("Returns instance details for the given instance and account name.")
  get is ArmResourceRead<DeviceUpdateInstance>;
  @doc("Creates or updates instance.")
  create is ArmResourceCreateOrUpdateAsync<DeviceUpdateInstance>;
  @doc("Updates instance's tags.")
  update is ArmTagsPatchSync<DeviceUpdateInstance>;
  @doc("Deletes instance.")
  delete is ArmResourceDeleteAsync<DeviceUpdateInstance>;
  @doc("Returns instances for the given account name.")
  listByAccount is ArmResourceListByParent<DeviceUpdateInstance>;
}
