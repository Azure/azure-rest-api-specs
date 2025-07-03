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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignmentOpsList
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {},
      ErrorType = Microsoft.GuestConfiguration.ErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface GuestConfigurationAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      VirtualMachineParameters,
      {
        ...Extension.ExtensionProviderNamespace<VirtualMachine>,
        ...KeysOf<VirtualMachine>,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The guest configuration assignment name.
         */
        @segment("guestConfigurationAssignments")
        @path
        guestConfigurationAssignmentName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  SubscriptionList is GuestConfigurationAssignmentOpsList.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList> | NoContentResponse
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  guestConfigurationAssignmentReportsList is GuestConfigurationAssignmentOps.Read<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    ErrorType = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationHCRPAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      MachinesParameters,
      {
        ...Extension.ExtensionProviderNamespace<Machines>,
        ...KeysOf<Machines>,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The guest configuration assignment name.
         */
        @segment("guestConfigurationAssignments")
        @path
        guestConfigurationAssignmentName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationHCRPAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is GuestConfigurationHCRPAssignmentOps.Read<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates an association between a ARC machine and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is GuestConfigurationHCRPAssignmentOps.CreateOrUpdateSync<
    GuestConfigurationAssignment,
    ErrorType = ErrorResponse
  >;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is GuestConfigurationHCRPAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse,
    ErrorType = ErrorResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is Extension.ListByTarget<
    Machines,
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
  guestConfigurationHCRPAssignmentReportsList is GuestConfigurationHCRPAssignmentOps.Read<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    ErrorType = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignmentsVMSS {
  /**
   * Get information about a guest configuration assignment for VMSS
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is Extension.Read<
    VirtualMachineScaleSets,
    GuestConfigurationAssignment,
    Error = ErrorResponse
  >;

  /**
   * Creates an association between a VMSS and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationConnectedVMwarevSphereAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      ConnectedVMwarevSphereParameters,
      {
        ...Extension.ExtensionProviderNamespace<ConnectedVMwarevSphere>,
        ...KeysOf<ConnectedVMwarevSphere>,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The guest configuration assignment name.
         */
        @segment("guestConfigurationAssignments")
        @path
        @pattern("^[^<>%&:\\\\?/#]*$")
        guestConfigurationAssignmentName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsList is GuestConfigurationConnectedVMwarevSphereAssignmentOps.Read<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentReportList>,
    ErrorType = ErrorResponse
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
