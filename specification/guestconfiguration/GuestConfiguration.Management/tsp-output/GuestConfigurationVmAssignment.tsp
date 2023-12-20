import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.GuestConfiguration;
@doc("Guest configuration assignment is an association between a machine and guest configuration.")
model GuestConfigurationVmAssignment
  is ExtensionResource<GuestConfigurationAssignmentProperties> {
  @doc("The guest configuration assignment name.")
  @path
  @key("guestConfigurationAssignmentName")
  @segment("guestConfigurationAssignments")
  name: string;
}

@armResourceOperations
interface GuestConfigurationVmAssignments {
  @doc("Get information about a guest configuration assignment")
  get is ArmResourceRead<GuestConfigurationVmAssignment>;
  @doc("Creates an association between a VM and guest configuration")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GuestConfigurationVmAssignment>;
  @doc("Delete a guest configuration assignment")
  delete is ArmResourceDeleteSync<GuestConfigurationVmAssignment>;
  @doc("List all guest configuration assignments for a virtual machine.")
  list is ArmResourceListByParent<GuestConfigurationVmAssignment>;
  @doc("List all guest configuration assignments for a subscription.")
  subscriptionList is ArmListBySubscription<GuestConfigurationVmAssignment>;
  @doc("List all reports for the guest configuration assignment, latest report first.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
  @get
  List is Azure.Core.Foundations.Operation<
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

      @doc("The name of the virtual machine.")
      @path
      vmName: string;
    },
    GuestConfigurationAssignmentReportList
  >;

  @doc("Get a report for the guest configuration assignment, by reportId.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
  @get
  Get is Azure.Core.Foundations.Operation<
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

      @doc("The name of the virtual machine.")
      @path
      vmName: string;
    },
    GuestConfigurationAssignmentReport
  >;
}
