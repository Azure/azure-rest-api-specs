import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DeviceUpdate;
@doc("Device Update instance details.")
@parentResource(Account)
model Instance is TrackedResource<InstanceProperties> {
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
interface Instances {
  @doc("Returns instance details for the given instance and account name.")
  get is ArmResourceRead<Instance>;
  @doc("Checks whether instance exists.")
  @head
  head(
    ...ResourceInstanceParameters<Instance, BaseParameters<Instance>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates or updates instance.")
  create is ArmResourceCreateOrUpdateAsync<Instance>;
  @doc("Updates instance's tags.")
  update is ArmTagsPatchSync<Instance>;
  @doc("Deletes instance.")
  delete is ArmResourceDeleteAsync<Instance>;
  @doc("Returns instances for the given account name.")
  listByAccount is ArmResourceListByParent<Instance>;
}
