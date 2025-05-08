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
model GuestConfigurationAssignment
  is Azure.ResourceManager.ProxyResource<GuestConfigurationAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = GuestConfigurationAssignment,
    KeyName = "guestConfigurationAssignmentName",
    SegmentName = "guestConfigurationAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GuestConfigurationAssignmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** virtualMachines */
        @path @segment("virtualMachines") vmName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "guestConfigurationAssignmentName",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface GuestConfigurationAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is GuestConfigurationAssignmentOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a VM and guest configuration
   */
  createOrUpdate is GuestConfigurationAssignmentOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is GuestConfigurationAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse
  >;

  /**
   * List all guest configuration assignments for a virtual machine.
   */
  list is GuestConfigurationAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("reports")
  @operationId("GuestConfigurationAssignmentReports_List")
  guestConfigurationAssignmentReportsList is GuestConfigurationAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{reportId}")
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
@armResourceOperations
interface GuestConfigurationHCRPAssignmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** machines */
        @path @segment("machines") machineName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "guestConfigurationAssignmentName",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface GuestConfigurationHCRPAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationHCRPAssignments_Get")
  get is GuestConfigurationHCRPAssignmentOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a ARC machine and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationHCRPAssignments_CreateOrUpdate")
  createOrUpdate is GuestConfigurationHCRPAssignmentOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("GuestConfigurationHCRPAssignments_Delete")
  delete is GuestConfigurationHCRPAssignmentOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmDeletedResponse
  >;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationHCRPAssignments_List")
  list is GuestConfigurationHCRPAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("reports")
  @operationId("GuestConfigurationHCRPAssignmentReports_List")
  guestConfigurationHCRPAssignmentReportsList is GuestConfigurationHCRPAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{reportId}")
  @operationId("GuestConfigurationHCRPAssignmentReports_Get")
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
@armResourceOperations
interface GuestConfigurationAssignmentsVMSSOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** virtualMachineScaleSets */
        @path @segment("virtualMachineScaleSets") vmssName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "name",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface GuestConfigurationAssignmentsVMSS {
  /**
   * Get information about a guest configuration assignment for VMSS
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationAssignmentsVMSS_Get")
  get is GuestConfigurationAssignmentsVMSSOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a VMSS and guest configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationAssignmentsVMSS_CreateOrUpdate")
  createOrUpdate is GuestConfigurationAssignmentsVMSSOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment for VMSS
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationAssignmentsVMSS_Delete")
  delete is GuestConfigurationAssignmentsVMSSOps.DeleteSync<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * List all guest configuration assignments for VMSS.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GuestConfigurationAssignmentsVMSS_List")
  list is GuestConfigurationAssignmentsVMSSOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the VMSS guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("reports")
  @operationId("GuestConfigurationAssignmentReportsVMSS_List")
  guestConfigurationAssignmentReportsVMSSList is GuestConfigurationAssignmentsVMSSOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the VMSS guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{id}")
  @operationId("GuestConfigurationAssignmentReportsVMSS_Get")
  guestConfigurationAssignmentReportsVMSSGet is GuestConfigurationAssignmentsVMSSOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReport>,
    Parameters = {
      /**
       * The GUID for the guest configuration assignment report.
       */
      @path
      id: string;
    }
  >;
}
@armResourceOperations
interface GuestConfigurationConnectedVMwarevSphereAssignmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** virtualmachines */
        @path @segment("virtualmachines") vmName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GuestConfigurationAssignment,
        KeyName = "guestConfigurationAssignmentName",
        SegmentName = "guestConfigurationAssignments",
        NamePattern = "^[^<>%&:\\\\?/#]*$"
      >>
    > {}

@armResourceOperations
interface GuestConfigurationConnectedVMwarevSphereAssignments {
  /**
   * Get information about a guest configuration assignment
   */
  get is GuestConfigurationConnectedVMwarevSphereAssignmentOps.Read<GuestConfigurationAssignment>;

  /**
   * Creates an association between a Connected VM Sphere machine and guest configuration
   */
  createOrUpdate is GuestConfigurationConnectedVMwarevSphereAssignmentOps.CreateOrUpdateSync<GuestConfigurationAssignment>;

  /**
   * Delete a guest configuration assignment
   */
  delete is GuestConfigurationConnectedVMwarevSphereAssignmentOps.DeleteSync<GuestConfigurationAssignment>;

  /**
   * List all guest configuration assignments for an ARC machine.
   */
  list is GuestConfigurationConnectedVMwarevSphereAssignmentOps.List<
    GuestConfigurationAssignment,
    Response = ArmResponse<GuestConfigurationAssignmentList>
  >;

  /**
   * List all reports for the guest configuration assignment, latest report first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("reports")
  @operationId("GuestConfigurationConnectedVMwarevSphereAssignmentsReports_List")
  guestConfigurationConnectedVMwarevSphereAssignmentsReportsList is GuestConfigurationConnectedVMwarevSphereAssignmentOps.ActionSync<
    GuestConfigurationAssignment,
    void,
    ArmResponse<GuestConfigurationAssignmentReportList>
  >;

  /**
   * Get a report for the guest configuration assignment, by reportId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{reportId}")
  @operationId("GuestConfigurationConnectedVMwarevSphereAssignmentsReports_Get")
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
