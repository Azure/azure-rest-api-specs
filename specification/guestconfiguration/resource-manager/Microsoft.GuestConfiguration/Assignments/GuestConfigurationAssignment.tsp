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

alias GuestConfigurationAssignmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Compute";

    /**
     * The name of the virtual machine.
     */
    @segment("virtualMachines")
    @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
    @key
    @path
    vmName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>;
  },
  {
    ...Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>;

    /**
     * The guest configuration assignment name.
     */
    @path
    @key
    @segment("guestConfigurationAssignments")
    guestConfigurationAssignmentName: string;
  }
>;

@armResourceOperations
interface GuestConfigurationAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is GuestConfigurationAssignmentOps.Read<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignment>,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates an association between a VM and guest configuration
   */
  createOrUpdate is GuestConfigurationAssignmentOps.CreateOrUpdateSync<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  delete is GuestConfigurationAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse,
    ErrorType = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for a virtual machine.
   */
  list is GuestConfigurationAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>,
    ErrorType = ErrorResponse
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
  guestConfigurationAssignmentReportsList is GuestConfigurationAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    ErrorType = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  @get
  guestConfigurationAssignmentReportsGet is GuestConfigurationAssignmentOps.Read<
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
    ErrorType = ErrorResponse
  >;
}

alias HybridCompute = Extension.ExternalResource<
  "Microsoft.HybridCompute",
  "machines",
  "machineName",
  Description = "The name of the ARC machine."
>;

alias GuestConfigurationHCRPAssignmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.HybridCompute";

    /**
     * The name of the ARC machine.
     */
    @segment("machines")
    @key
    @path
    machineName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>;
  },
  {
    ...Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>;

    /**
     * The guest configuration assignment name.
     */
    @path
    @key
    @segment("guestConfigurationAssignments")
    guestConfigurationAssignmentName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GuestConfigurationHCRPAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_Get")
  get is GuestConfigurationHCRPAssignmentOps.Read<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates an association between a ARC machine and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_CreateOrUpdate")
  createOrUpdate is GuestConfigurationHCRPAssignmentOps.CreateOrUpdateSync<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_Delete")
  delete is GuestConfigurationHCRPAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse,
    ErrorType = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_List")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  @operationId("GuestConfigurationHCRPAssignmentReports_List")
  guestConfigurationHCRPAssignmentReportsList is GuestConfigurationHCRPAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    ErrorType = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("GuestConfigurationHCRPAssignmentReports_Get")
  guestConfigurationHCRPAssignmentReportsGet is GuestConfigurationHCRPAssignmentOps.Read<
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
    ErrorType = ErrorResponse
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_Get")
  get is Extension.Read<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Creates an association between a VMSS and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_CreateOrUpdate")
  createOrUpdate is Extension.CreateOrReplaceSync<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Parameters = {},
    Error = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment for VMSS
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_Delete")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_List")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  @operationId("GuestConfigurationAssignmentReportsVMSS_List")
  @list
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("GuestConfigurationAssignmentReportsVMSS_Get")
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

alias GuestConfigurationConnectedVMwarevSphereAssignmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ConnectedVMwarevSphere";

    /**
     * The name of the virtual machine.
     */
    @segment("virtualmachines")
    @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
    @key
    @path
    vmName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>;
  },
  {
    ...Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>;

    /**
     * The guest configuration assignment name.
     */
    @path
    @key
    @segment("guestConfigurationAssignments")
    @pattern("^[^<>%&:\\\\?/#]*$")
    guestConfigurationAssignmentName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GuestConfigurationConnectedVMwarevSphereAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is GuestConfigurationConnectedVMwarevSphereAssignmentOps.Read<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates an association between a Connected VM Sphere machine and guest configuration
   */
  createOrUpdate is GuestConfigurationConnectedVMwarevSphereAssignmentOps.CreateOrUpdateSync<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  delete is GuestConfigurationConnectedVMwarevSphereAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  list is GuestConfigurationConnectedVMwarevSphereAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>,
    ErrorType = ErrorResponse
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsList is GuestConfigurationConnectedVMwarevSphereAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    ErrorType = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet is GuestConfigurationConnectedVMwarevSphereAssignmentOps.Read<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      @segment("reports")
      reportId: string;
    },
    ErrorType = ErrorResponse
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
