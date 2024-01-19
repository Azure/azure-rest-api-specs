import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SqlVirtualMachine;
@doc("A SQL virtual machine group.")
model SqlVirtualMachineGroup
  is TrackedResource<SqlVirtualMachineGroupProperties> {
  @doc("Name of the SQL virtual machine group.")
  @path
  @key("sqlVirtualMachineGroupName")
  @segment("sqlVirtualMachineGroups")
  name: string;
}

@armResourceOperations
interface SqlVirtualMachineGroups {
  @doc("Gets a SQL virtual machine group.")
  get is ArmResourceRead<
    SqlVirtualMachineGroup,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  @doc("Creates or updates a SQL virtual machine group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SqlVirtualMachineGroup,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  @doc("Updates SQL virtual machine group tags.")
  update is ArmCustomPatchAsync<
    SqlVirtualMachineGroup,
    SqlVirtualMachineGroupUpdate,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  @doc("Deletes a SQL virtual machine group.")
  delete is ArmResourceDeleteAsync<
    SqlVirtualMachineGroup,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  @doc("Gets all SQL virtual machine groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SqlVirtualMachineGroup>;

  @doc("Gets all SQL virtual machine groups in a subscription.")
  list is ArmListBySubscription<SqlVirtualMachineGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlVirtualMachines_ListBySqlVmGroup")
  @doc("Gets the list of sql virtual machines in a SQL virtual machine group.")
  // FIXME: SqlVirtualMachines_ListBySqlVmGroup could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/sqlVirtualMachines")
  @get
  listBySqlVmGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVirtualMachine>
  >;
}

@@projectedName(SqlVirtualMachineGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SqlVirtualMachineGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlVirtualMachineGroups.createOrUpdate::parameters.resource,
  "The SQL virtual machine group."
);
@@projectedName(SqlVirtualMachineGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SqlVirtualMachineGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlVirtualMachineGroups.update::parameters.properties,
  "The SQL virtual machine group."
);
