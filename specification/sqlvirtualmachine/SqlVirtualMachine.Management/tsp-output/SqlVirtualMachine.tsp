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
model SqlVirtualMachine is TrackedResource<SqlVirtualMachineProperties> {
  @doc("Name of the SQL virtual machine.")
  @path
  @key("sqlVirtualMachineName")
  @segment("sqlVirtualMachines")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SqlVirtualMachines {
  @doc("Gets a SQL virtual machine.")
  get is ArmResourceRead<
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

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
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Updates a SQL virtual machine.")
  update is ArmTagsPatchAsync<
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Deletes a SQL virtual machine.")
  delete is ArmResourceDeleteAsync<
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Gets all SQL virtual machines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SqlVirtualMachine>;
  @doc("Gets all SQL virtual machines in a subscription.")
  list is ArmListBySubscription<SqlVirtualMachine>;
  @doc("Uninstalls and reinstalls the SQL Iaas Extension.")
  redeploy is ArmResourceActionAsync<
    SqlVirtualMachine,
    void,
    void,
    {
      ...BaseParameters<SqlVirtualMachine>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
  @doc("Starts Assessment on SQL virtual machine.")
  startAssessment is ArmResourceActionAsync<
    SqlVirtualMachine,
    void,
    void,
    {
      ...BaseParameters<SqlVirtualMachine>;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;
    }
  >;
}
