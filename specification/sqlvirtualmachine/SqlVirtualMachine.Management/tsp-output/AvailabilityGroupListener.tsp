import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlVirtualMachineGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SqlVirtualMachine;
@doc("A SQL Server availability group listener.")
@parentResource(SqlVirtualMachineGroup)
model AvailabilityGroupListener
  is ProxyResource<AvailabilityGroupListenerProperties> {
  @doc("Name of the availability group listener.")
  @path
  @key("availabilityGroupListenerName")
  @segment("availabilityGroupListeners")
  name: string;
}

@armResourceOperations
interface AvailabilityGroupListeners {
  @doc("Gets an availability group listener.")
  get is ArmResourceRead<
    AvailabilityGroupListener,
    {
      ...BaseParameters<AvailabilityGroupListener>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates or updates an availability group listener.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvailabilityGroupListener>;
  @doc("Deletes an availability group listener.")
  delete is ArmResourceDeleteAsync<AvailabilityGroupListener>;
  @doc("Lists all availability group listeners in a SQL virtual machine group.")
  listByGroup is ArmResourceListByParent<AvailabilityGroupListener>;
}
