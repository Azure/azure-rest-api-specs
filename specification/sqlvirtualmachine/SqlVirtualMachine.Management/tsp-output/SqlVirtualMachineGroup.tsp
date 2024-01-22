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
/**
 * A SQL virtual machine group.
 */
model SqlVirtualMachineGroup
  is TrackedResource<SqlVirtualMachineGroupProperties> {
  /**
   * Name of the SQL virtual machine group.
   */
  @path
  @key("sqlVirtualMachineGroupName")
  @segment("sqlVirtualMachineGroups")
  name: string;
}

@armResourceOperations
interface SqlVirtualMachineGroups {
  /**
   * Gets a SQL virtual machine group.
   */
  get is ArmResourceRead<
    SqlVirtualMachineGroup,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  /**
   * Creates or updates a SQL virtual machine group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SqlVirtualMachineGroup,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  /**
   * Updates SQL virtual machine group tags.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    SqlVirtualMachineGroup,
    SqlVirtualMachineGroupUpdate,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  /**
   * Deletes a SQL virtual machine group.
   */
  delete is ArmResourceDeleteAsync<
    SqlVirtualMachineGroup,
    {
      ...BaseParameters<SqlVirtualMachineGroup>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  /**
   * Gets all SQL virtual machine groups in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlVirtualMachineGroups_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SqlVirtualMachineGroup>;

  /**
   * Gets all SQL virtual machine groups in a subscription.
   */
  list is ArmListBySubscription<SqlVirtualMachineGroup>;

  /**
   * Gets the list of sql virtual machines in a SQL virtual machine group.
   */
  // FIXME: SqlVirtualMachines_ListBySqlVmGroup could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlVirtualMachines_ListBySqlVmGroup")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/sqlVirtualMachines")
  @get
  listBySqlVmGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;

      /**
       * Subscription ID that identifies an Azure subscription.
       */
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
