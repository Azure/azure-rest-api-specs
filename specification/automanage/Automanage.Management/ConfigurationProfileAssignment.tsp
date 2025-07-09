import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
/**
 * Configuration profile assignment is an association between a VM and automanage profile configuration.
 */
model ConfigurationProfileAssignment
  is Azure.ResourceManager.ProxyResource<ConfigurationProfileAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = ConfigurationProfileAssignment,
    KeyName = "configurationProfileAssignmentName",
    SegmentName = "configurationProfileAssignments",
    NamePattern = ""
  >;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;
}

@armResourceOperations
interface ConfigurationProfileAssignmentByVMOps
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
        Resource = ConfigurationProfileAssignment,
        KeyName = "configurationProfileAssignmentName",
        SegmentName = "configurationProfileAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ConfigurationProfileAssignmentBySubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationProfileAssignment,
        KeyName = "configurationProfileAssignmentName",
        SegmentName = "configurationProfileAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ConfigurationProfileAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is ConfigurationProfileAssignmentByVMOps.Read<ConfigurationProfileAssignment>;

  /**
   * Creates an association between a VM and Automanage configuration profile
   */
  createOrUpdate is ConfigurationProfileAssignmentByVMOps.CreateOrUpdateSync<ConfigurationProfileAssignment>;

  /**
   * Delete a configuration profile assignment
   */
  delete is ConfigurationProfileAssignmentByVMOps.DeleteSync<ConfigurationProfileAssignment>;

  /**
   * Get list of configuration profile assignments
   */
  listByVirtualMachines is ConfigurationProfileAssignmentByVMOps.List<
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;

  /**
   * Get list of configuration profile assignments under a given subscription
   */
  listBySubscription is ConfigurationProfileAssignmentBySubscriptionOps.List<
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;
}
@armResourceOperations
interface ConfigurationProfileHCRPAssignmentOps
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
        Resource = ConfigurationProfileAssignment,
        KeyName = "configurationProfileAssignmentName",
        SegmentName = "configurationProfileAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ConfigurationProfileHCRPAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileHCRPAssignments_Get")
  get is ConfigurationProfileHCRPAssignmentOps.Read<ConfigurationProfileAssignment>;

  /**
   * Creates an association between a ARC machine and Automanage configuration profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileHCRPAssignments_CreateOrUpdate")
  createOrUpdate is ConfigurationProfileHCRPAssignmentOps.CreateOrUpdateSync<ConfigurationProfileAssignment>;

  /**
   * Delete a configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileHCRPAssignments_Delete")
  delete is ConfigurationProfileHCRPAssignmentOps.DeleteSync<ConfigurationProfileAssignment>;

  /**
   * Get list of configuration profile assignments
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileAssignments_ListByMachineName")
  listByMachineName is ConfigurationProfileHCRPAssignmentOps.List<
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;
}
@armResourceOperations
interface ConfigurationProfileHCIAssignmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** clusters */
        @path @segment("clusters") clusterName: string,

      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationProfileAssignment,
        KeyName = "configurationProfileAssignmentName",
        SegmentName = "configurationProfileAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ConfigurationProfileHCIAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileHCIAssignments_Get")
  get is ConfigurationProfileHCIAssignmentOps.Read<ConfigurationProfileAssignment>;

  /**
   * Creates an association between a AzureStackHCI cluster and Automanage configuration profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileHCIAssignments_CreateOrUpdate")
  createOrUpdate is ConfigurationProfileHCIAssignmentOps.CreateOrUpdateSync<ConfigurationProfileAssignment>;

  /**
   * Delete a configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileHCIAssignments_Delete")
  delete is ConfigurationProfileHCIAssignmentOps.DeleteSync<ConfigurationProfileAssignment>;

  /**
   * Get list of configuration profile assignments
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileAssignments_ListByClusterName")
  listByClusterName is ConfigurationProfileHCIAssignmentOps.List<
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;
}

@@doc(ConfigurationProfileAssignment.name,
  "The configuration profile assignment name."
);
@@doc(ConfigurationProfileAssignment.properties,
  "Properties of the configuration profile assignment."
);
@@doc(ConfigurationProfileAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration profile assignment."
);
@@doc(ConfigurationProfileHCRPAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration profile assignment."
);
@@doc(ConfigurationProfileHCIAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration profile assignment."
);
