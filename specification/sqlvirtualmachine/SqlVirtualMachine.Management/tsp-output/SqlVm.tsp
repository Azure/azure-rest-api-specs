import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SqlVirtualMachine;
@doc("A SQL virtual machine.")
model SqlVm is TrackedResource<SqlVirtualMachineProperties> {
  @doc("Name of the SQL virtual machine.")
  @path
  @key("sqlVirtualMachineName")
  @segment("sqlVirtualMachines")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SqlVms {
  @doc("Gets a SQL virtual machine.")
  get is ArmResourceRead<
    SqlVm,
    {
      ...BaseParameters<SqlVm>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates or updates a SQL virtual machine.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SqlVm,
    {
      ...BaseParameters<SqlVm>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Updates a SQL virtual machine.")
  update is ArmTagsPatchAsync<
    SqlVm,
    {
      ...BaseParameters<SqlVm>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Deletes a SQL virtual machine.")
  delete is ArmResourceDeleteAsync<
    SqlVm,
    {
      ...BaseParameters<SqlVm>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Gets all SQL virtual machines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SqlVm>;
  @doc("Gets all SQL virtual machines in a subscription.")
  list is ArmListBySubscription<SqlVm>;
  @doc("Uninstalls and reinstalls the SQL Iaas Extension.")
  redeploy is ArmResourceActionAsync<
    SqlVm,
    void,
    void,
    {
      ...BaseParameters<SqlVm>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Starts Assessment on SQL virtual machine.")
  startAssessment is ArmResourceActionAsync<
    SqlVm,
    void,
    void,
    {
      ...BaseParameters<SqlVm>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
}
