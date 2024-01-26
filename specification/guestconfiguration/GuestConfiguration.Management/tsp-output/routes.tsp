import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.GuestConfiguration;

interface GuestConfigurationHCRPAssignmentsOperations {
  /**
   * Creates an association between a ARC machine and guest configuration
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the guest configuration assignment.
       */
      @path
      guestConfigurationAssignmentName: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the ARC machine.
       */
      @path
      machineName: string;

      /**
       * Parameters supplied to the create or update guest configuration assignment.
       */
      @body
      parameters: GuestConfigurationAssignment;
    },
    GuestConfigurationAssignment
  >;

  /**
   * Get information about a guest configuration assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      guestConfigurationAssignmentName: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the ARC machine.
       */
      @path
      machineName: string;
    },
    GuestConfigurationAssignment
  >;

  /**
   * Delete a guest configuration assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the guest configuration assignment
       */
      @path
      guestConfigurationAssignmentName: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the ARC machine.
       */
      @path
      machineName: string;
    },
    void
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the ARC machine.
       */
      @path
      machineName: string;
    },
    ResourceListResult<GuestConfigurationAssignment>
  >;
}

interface GuestConfigurationHCRPAssignmentReportsOperations {
  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      guestConfigurationAssignmentName: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the ARC machine.
       */
      @path
      machineName: string;
    },
    GuestConfigurationAssignmentReportList
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      guestConfigurationAssignmentName: string;

      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      reportId: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the ARC machine.
       */
      @path
      machineName: string;
    },
    GuestConfigurationAssignmentReport
  >;
}

interface GuestConfigurationAssignmentsVMSSOperations {
  /**
   * Get information about a guest configuration assignment for VMSS
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the virtual machine scale set.
       */
      @path
      vmssName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      name: string;
    },
    GuestConfigurationAssignment
  >;

  /**
   * Delete a guest configuration assignment for VMSS
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the virtual machine scale set.
       */
      @path
      vmssName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      name: string;
    },
    GuestConfigurationAssignment | void
  >;

  /**
   * List all guest configuration assignments for VMSS.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the virtual machine scale set.
       */
      @path
      vmssName: string;
    },
    ResourceListResult<GuestConfigurationAssignment>
  >;
}

interface GuestConfigurationAssignmentReportsVMSSOperations {
  /**
   * List all reports for the VMSS guest configuration assignment, latest report first.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}/reports")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the virtual machine scale set.
       */
      @path
      vmssName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      name: string;
    },
    GuestConfigurationAssignmentReportList
  >;

  /**
   * Get a report for the VMSS guest configuration assignment, by reportId.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}/reports/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the virtual machine scale set.
       */
      @path
      vmssName: string;

      /**
       * The guest configuration assignment name.
       */
      @path
      name: string;

      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      id: string;
    },
    GuestConfigurationAssignmentReport
  >;
}
