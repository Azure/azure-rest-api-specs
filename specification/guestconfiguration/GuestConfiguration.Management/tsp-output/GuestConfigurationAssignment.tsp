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

namespace Microsoft.GuestConfiguration;
@doc("Guest configuration assignment is an association between a machine and guest configuration.")
model GuestConfigurationAssignment
  is ExtensionResource<GuestConfigurationAssignmentProperties> {
  @doc("The guest configuration assignment name.")
  @path
  @key("guestConfigurationAssignmentName")
  @segment("guestConfigurationAssignments")
  name: string;
}

@armResourceOperations
interface GuestConfigurationAssignments {
  @doc("Get information about a guest configuration assignment")
  get is ArmResourceRead<GuestConfigurationAssignment>;

  @doc("Creates an association between a VM and guest configuration")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GuestConfigurationAssignment>;

  @doc("Delete a guest configuration assignment")
  delete is ArmResourceDeleteSync<GuestConfigurationAssignment>;

  @doc("List all guest configuration assignments for a virtual machine.")
  list is ArmResourceListByParent<GuestConfigurationAssignment>;

  @doc("List all guest configuration assignments for a subscription.")
  subscriptionList is ArmListBySubscription<GuestConfigurationAssignment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GuestConfigurationAssignmentReports_List")
  @doc("List all reports for the guest configuration assignment, latest report first.")
  // FIXME: GuestConfigurationAssignmentReports_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
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

      @doc("The name of the virtual machine.")
      @path
      vmName: string;
    },
    GuestConfigurationAssignmentReportList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GuestConfigurationAssignmentReports_Get")
  @doc("Get a report for the guest configuration assignment, by reportId.")
  // FIXME: GuestConfigurationAssignmentReports_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
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

      @doc("The name of the virtual machine.")
      @path
      vmName: string;
    },
    GuestConfigurationAssignmentReport
  >;
}

@@projectedName(GuestConfigurationAssignments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(GuestConfigurationAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(GuestConfigurationAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update guest configuration assignment."
);
