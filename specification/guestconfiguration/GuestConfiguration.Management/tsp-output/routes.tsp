import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.GuestConfiguration;

interface GuestConfigurationHCRPAssignmentsOperations {
  @doc("Creates an association between a ARC machine and guest configuration")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the guest configuration assignment.")
      @path
      guestConfigurationAssignmentName: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the ARC machine.")
      @path
      machineName: string;

      @doc("Parameters supplied to the create or update guest configuration assignment.")
      @body
      parameters: GuestConfigurationAssignment;
    },
    GuestConfigurationAssignment
  >;

  @doc("Get information about a guest configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The guest configuration assignment name.")
      @path
      guestConfigurationAssignmentName: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the ARC machine.")
      @path
      machineName: string;
    },
    GuestConfigurationAssignment
  >;

  @doc("Delete a guest configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("Name of the guest configuration assignment")
      @path
      guestConfigurationAssignmentName: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the ARC machine.")
      @path
      machineName: string;
    },
    void
  >;

  @doc("List all guest configuration assignments for an ARC machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the ARC machine.")
      @path
      machineName: string;
    },
    ResourceListResult<GuestConfigurationAssignment>
  >;
}

interface GuestConfigurationHCRPAssignmentReportsOperations {
  @doc("List all reports for the guest configuration assignment, latest report first.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The guest configuration assignment name.")
      @path
      guestConfigurationAssignmentName: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the ARC machine.")
      @path
      machineName: string;
    },
    GuestConfigurationAssignmentReportList
  >;

  @doc("Get a report for the guest configuration assignment, by reportId.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The guest configuration assignment name.")
      @path
      guestConfigurationAssignmentName: string;

      @doc("The GUID for the guest configuration assignment report.")
      @path
      reportId: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the ARC machine.")
      @path
      machineName: string;
    },
    GuestConfigurationAssignmentReport
  >;
}

interface GuestConfigurationAssignmentsVMSSOperations {
  @doc("Get information about a guest configuration assignment for VMSS")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual machine scale set.")
      @path
      vmssName: string;

      @doc("The guest configuration assignment name.")
      @path
      name: string;
    },
    GuestConfigurationAssignment
  >;

  @doc("Delete a guest configuration assignment for VMSS")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual machine scale set.")
      @path
      vmssName: string;

      @doc("The guest configuration assignment name.")
      @path
      name: string;
    },
    GuestConfigurationAssignment | void
  >;

  @doc("List all guest configuration assignments for VMSS.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the virtual machine scale set.")
      @path
      vmssName: string;
    },
    ResourceListResult<GuestConfigurationAssignment>
  >;
}

interface GuestConfigurationAssignmentReportsVMSSOperations {
  @doc("List all reports for the VMSS guest configuration assignment, latest report first.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}/reports")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual machine scale set.")
      @path
      vmssName: string;

      @doc("The guest configuration assignment name.")
      @path
      name: string;
    },
    GuestConfigurationAssignmentReportList
  >;

  @doc("Get a report for the VMSS guest configuration assignment, by reportId.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}/reports/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual machine scale set.")
      @path
      vmssName: string;

      @doc("The guest configuration assignment name.")
      @path
      name: string;

      @doc("The GUID for the guest configuration assignment report.")
      @path
      id: string;
    },
    GuestConfigurationAssignmentReport
  >;
}
