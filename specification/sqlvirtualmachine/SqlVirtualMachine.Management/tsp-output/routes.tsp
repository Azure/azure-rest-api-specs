import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SqlVirtualMachineManagementClient;

interface AvailabilityGroupListenersOperations {
  @doc("Gets an availability group listener.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/availabilityGroupListeners/{availabilityGroupListenerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Name of the availability group listener.")
      @path
      availabilityGroupListenerName: string;

      @doc("The child resources to include in the response.")
      @query
      $expand: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    AvailabilityGroupListener
  >;

  @doc("Creates or updates an availability group listener.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/availabilityGroupListeners/{availabilityGroupListenerName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Name of the availability group listener.")
      @path
      availabilityGroupListenerName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The availability group listener.")
      @body
      parameters: AvailabilityGroupListener;
    },
    AvailabilityGroupListener
  >;

  @doc("Deletes an availability group listener.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/availabilityGroupListeners/{availabilityGroupListenerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Name of the availability group listener.")
      @path
      availabilityGroupListenerName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Lists all availability group listeners in a SQL virtual machine group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/availabilityGroupListeners")
  @get
  ListByGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    AvailabilityGroupListenerListResult
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available SQL Virtual Machine Rest API operations.")
  @route("/providers/Microsoft.SqlVirtualMachine/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface SqlVirtualMachineGroupsOperations {
  @doc("Gets a SQL virtual machine group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachineGroup
  >;

  @doc("Creates or updates a SQL virtual machine group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The SQL virtual machine group.")
      @body
      parameters: SqlVirtualMachineGroup;
    },
    SqlVirtualMachineGroup
  >;

  @doc("Deletes a SQL virtual machine group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Updates SQL virtual machine group tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The SQL virtual machine group.")
      @body
      parameters: SqlVirtualMachineGroupUpdate;
    },
    SqlVirtualMachineGroup
  >;

  @doc("Gets all SQL virtual machine groups in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachineGroupListResult
  >;

  @doc("Gets all SQL virtual machine groups in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachineGroupListResult
  >;
}

interface SqlVirtualMachinesOperations {
  @doc("Gets the list of sql virtual machines in a SQL virtual machine group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups/{sqlVirtualMachineGroupName}/sqlVirtualMachines")
  @get
  ListBySqlVmGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine group.")
      @path
      sqlVirtualMachineGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachineListResult
  >;

  @doc("Gets all SQL virtual machines in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachineListResult
  >;

  @doc("Gets a SQL virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("The child resources to include in the response.")
      @query
      $expand: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachine
  >;

  @doc("Creates or updates a SQL virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The SQL virtual machine.")
      @body
      parameters: SqlVirtualMachine;
    },
    SqlVirtualMachine
  >;

  @doc("Deletes a SQL virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Updates a SQL virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The SQL virtual machine.")
      @body
      parameters: SqlVirtualMachineUpdate;
    },
    SqlVirtualMachine
  >;

  @doc("Gets all SQL virtual machines in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVirtualMachineListResult
  >;

  @doc("Uninstalls and reinstalls the SQL Iaas Extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}/redeploy")
  @post
  Redeploy is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Starts Assessment on SQL virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}/startAssessment")
  @post
  StartAssessment is Azure.Core.Foundations.Operation<
    {
      @doc("""
Name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL virtual machine.")
      @path
      sqlVirtualMachineName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}
