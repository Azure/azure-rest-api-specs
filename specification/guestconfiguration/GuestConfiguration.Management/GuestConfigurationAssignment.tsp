import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.GuestConfiguration;
/**
 * Guest configuration assignment is an association between a machine and guest configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GuestConfigurationAssignment extends ProxyResource {
  /**
   * Properties of the Guest configuration assignment.
   */
  properties?: GuestConfigurationAssignmentProperties;

  /**
   *  Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.CommonTypes.SystemData;
}

alias VirtualMachine = Extension.ExternalResource<
  "Microsoft.Compute",
  "virtualMachines",
  "vmName",
  NamePattern = "^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$",
  Description = "The name of the virtual machine"
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is Extension.Read<
    VirtualMachine,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignment>,
    Error = ErrorResponse
  >;

  /**
   * Creates an association between a VM and guest configuration
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    VirtualMachine,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  delete is Extension.DeleteSync<
    VirtualMachine,
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse,
    Error = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for a virtual machine.
   */
  list is Extension.ListByTarget<
    VirtualMachine,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>,
    Error = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SubscriptionList is Extension.ListByTarget<
    Extension.Subscription,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList> | NoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  @get
  @action("reports")
  guestConfigurationAssignmentReportsList is Extension.ActionSync<
    VirtualMachine,
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    Error = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  @get
  guestConfigurationAssignmentReportsGet is Extension.Read<
    VirtualMachine,
    GuestConfigurationAssignment,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      @segment("reports")
      reportId: string;
    },
    Response = ArmResponse<GuestConfigurationAssignmentReport>,
    Error = ErrorResponse
  >;
}

alias HybridCompute = Extension.ExternalResource<
  "Microsoft.HybridCompute",
  "machines",
  "machineName",
  Description = "The name of the ARC machine."
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationHCRPAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is Extension.Read<
    HybridCompute,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Creates an association between a ARC machine and guest configuration
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    HybridCompute,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is Extension.DeleteSync<
    HybridCompute,
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse,
    Error = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  list is Extension.ListByTarget<
    HybridCompute,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>,
    Error = ErrorResponse
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  guestConfigurationHCRPAssignmentReportsList is Extension.ActionSync<
    HybridCompute,
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    Error = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  guestConfigurationHCRPAssignmentReportsGet is Extension.Read<
    HybridCompute,
    GuestConfigurationAssignment,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      @segment("reports")
      reportId: string;
    },
    Response = ArmResponse<GuestConfigurationAssignmentReport>,
    Error = ErrorResponse
  >;
}

alias VirtualMachineScaleSets = Extension.ExternalResource<
  "Microsoft.Compute",
  "virtualMachineScaleSets",
  "vmssName",
  Description = "The name of the virtual machine scale set."
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignmentsVMSS {
  /**
   * Get information about a guest configuration assignment for VMSS
   */
  get is Extension.Read<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Creates an association between a VMSS and guest configuration
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Parameters = {},
    Error = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment for VMSS
   */
  delete is Extension.DeleteSync<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Parameters = {},
    Response = ArmResponse<GuestConfigurationAssignment> | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for VMSS.
   */
  list is Extension.ListByTarget<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>,
    Error = ErrorResponse
  >;

  /**
   * List all reports for the VMSS guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  guestConfigurationAssignmentReportsVMSSList is Extension.Read<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    Error = ErrorResponse
  >;

  /**
   * Get a report for the VMSS guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  guestConfigurationAssignmentReportsVMSSGet is Extension.Read<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      @segment("reports")
      id: string;
    },
    Response = ArmResponse<GuestConfigurationAssignmentReport>,
    Error = ErrorResponse
  >;
}

alias ConnectedVMwarevSphere = Extension.ExternalResource<
  "Microsoft.ConnectedVMwarevSphere",
  "virtualmachines",
  "vmName",
  NamePattern = "^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$",
  Description = "The name of the virtual machine."
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationConnectedVMwarevSphereAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is Extension.Read<
    ConnectedVMwarevSphere,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Creates an association between a Connected VM Sphere machine and guest configuration
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    ConnectedVMwarevSphere,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  delete is Extension.DeleteSync<
    ConnectedVMwarevSphere,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  list is Extension.ListByTarget<
    ConnectedVMwarevSphere,
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>,
    Error = ErrorResponse
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsList is Extension.ActionSync<
    ConnectedVMwarevSphere,
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    Error = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet is Extension.ActionSync<
    ConnectedVMwarevSphere,
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      @segment("reports")
      reportId: string;
    },
    Error = ErrorResponse
  >;
}

@@doc(GuestConfigurationAssignment.name,
  "The guest configuration assignment name."
);
@@doc(GuestConfigurationAssignment.properties,
  "Properties of the Guest configuration assignment."
);
@@doc(GuestConfigurationAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update guest configuration assignment."
);
@@doc(GuestConfigurationHCRPAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update guest configuration assignment."
);
@@doc(GuestConfigurationAssignmentsVMSS.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update guest configuration assignment."
);
@@doc(GuestConfigurationConnectedVMwarevSphereAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update guest configuration assignment."
);
