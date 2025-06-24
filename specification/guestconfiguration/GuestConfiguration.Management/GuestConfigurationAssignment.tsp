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
interface GuestConfigurationAssignmentOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** virtualMachines */
        @path
        vmName: string,
      },
      {
        /**
         * The name of the GuestConfigurationAssignment
         */
        @path
        guestConfigurationAssignmentName: string,
      }
    > {}

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  get is GuestConfigurationAssignmentOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a VM and guest configuration
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  createOrUpdate is GuestConfigurationAssignmentOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  delete is GuestConfigurationAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse
  >;

  /**
   * List all guest configuration assignments for a virtual machine.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  list is GuestConfigurationAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all guest configuration assignments for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("guestConfigurationAssignments")
  SubscriptionList is GuestConfigurationAssignmentOpsList.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList> | NoContentResponse
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
  @operationId("GuestConfigurationAssignmentReports_List")
  guestConfigurationAssignmentReportsList is GuestConfigurationAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
  @operationId("GuestConfigurationAssignmentReports_Get")
  guestConfigurationAssignmentReportsGet is GuestConfigurationAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      reportId: string;
    }
  >;
}
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationHCRPAssignmentOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** machines */
        @path
        machineName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "guestConfigurationAssignmentName",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationHCRPAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  get is GuestConfigurationHCRPAssignmentOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a ARC machine and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  createOrUpdate is GuestConfigurationHCRPAssignmentOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  delete is GuestConfigurationHCRPAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationHCRPAssignments_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  list is GuestConfigurationHCRPAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  @operationId("GuestConfigurationHCRPAssignmentReports_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
  guestConfigurationHCRPAssignmentReportsList is GuestConfigurationHCRPAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("GuestConfigurationHCRPAssignmentReports_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
  guestConfigurationHCRPAssignmentReportsGet is GuestConfigurationHCRPAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      reportId: string;
    }
  >;
}
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignmentsVMSSOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** virtualMachineScaleSets */
        @path
        vmssName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "name",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationAssignmentsVMSS {
  /**
   * Get information about a guest configuration assignment for VMSS
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  get is GuestConfigurationAssignmentsVMSSOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a VMSS and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  createOrUpdate is GuestConfigurationAssignmentsVMSSOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment for VMSS
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}")
  delete is GuestConfigurationAssignmentsVMSSOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * List all guest configuration assignments for VMSS.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GuestConfigurationAssignmentsVMSS_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  list is GuestConfigurationAssignmentsVMSSOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the VMSS guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}/reports")
  @operationId("GuestConfigurationAssignmentReportsVMSS_List")
  guestConfigurationAssignmentReportsVMSSList is GuestConfigurationAssignmentsVMSSOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the VMSS guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("GuestConfigurationAssignmentReportsVMSS_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{name}/reports/{id}")
  guestConfigurationAssignmentReportsVMSSGet is GuestConfigurationAssignmentsVMSSOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      @segment("reports")
      id: string;
    }
  >;
}
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationConnectedVMwarevSphereAssignmentOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** virtualmachines */
        @path
        vmName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "guestConfigurationAssignmentName",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = "^[^<>%&:\\\\?/#]*$"
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GuestConfigurationConnectedVMwarevSphereAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConnectedVMwarevSphere/virtualmachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  get is GuestConfigurationConnectedVMwarevSphereAssignmentOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a Connected VM Sphere machine and guest configuration
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConnectedVMwarevSphere/virtualmachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  createOrUpdate is GuestConfigurationConnectedVMwarevSphereAssignmentOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConnectedVMwarevSphere/virtualmachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}")
  delete is GuestConfigurationConnectedVMwarevSphereAssignmentOps.DeleteSync<GuestConfigurationAssignment>;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConnectedVMwarevSphere/virtualmachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments")
  list is GuestConfigurationConnectedVMwarevSphereAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  @operationId("GuestConfigurationConnectedVMwarevSphereAssignmentsReports_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConnectedVMwarevSphere/virtualmachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports")
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsList is GuestConfigurationConnectedVMwarevSphereAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("GuestConfigurationConnectedVMwarevSphereAssignmentsReports_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConnectedVMwarevSphere/virtualmachines/{vmName}/providers/Microsoft.GuestConfiguration/guestConfigurationAssignments/{guestConfigurationAssignmentName}/reports/{reportId}")
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet is GuestConfigurationConnectedVMwarevSphereAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      reportId: string;
    }
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
