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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  managedBy?: string;
}

@armResourceOperations
interface ConfigurationProfileAssignmentBySubscriptionOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      }
    > {}

@armResourceOperations
interface ConfigurationProfileAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.Compute",

        /** The name of the virtual machine. */
        @path
        @segment("virtualMachines")
        @key
        vmName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      }
    > {}

@armResourceOperations
interface ConfigurationProfileAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is ConfigurationProfileAssignmentOps.Read<ConfigurationProfileAssignment>;

  /**
   * Creates an association between a VM and Automanage configuration profile
   */
  createOrUpdate is ConfigurationProfileAssignmentOps.CreateOrUpdateSync<ConfigurationProfileAssignment>;

  /**
   * Delete a configuration profile assignment
   */
  delete is ConfigurationProfileAssignmentOps.DeleteSync<ConfigurationProfileAssignment>;

  /**
   * Get list of configuration profile assignments under a given virtual machine
   */
  listByVirtualMachines is ConfigurationProfileAssignmentOps.List<
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ConfigurationProfileHCRPAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.HybridCompute",

        /** The name of the Arc machine. */
        @path
        @segment("machines")
        @key
        machineName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ConfigurationProfileHCRPAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is ConfigurationProfileHCRPAssignmentOps.Read<ConfigurationProfileAssignment>;

  /**
   * Creates an association between a ARC machine and Automanage configuration profile
   */
  createOrUpdate is ConfigurationProfileHCRPAssignmentOps.CreateOrUpdateSync<ConfigurationProfileAssignment>;

  /**
   * Delete a configuration profile assignment
   */
  delete is ConfigurationProfileHCRPAssignmentOps.DeleteSync<ConfigurationProfileAssignment>;

  /**
   * Get list of configuration profile assignments
   */
  listByMachineName is ConfigurationProfileHCRPAssignmentOps.List<
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ConfigurationProfileHCIAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.AzureStackHci",

        /** The name of the Arc machine. */
        @path
        @segment("clusters")
        @key
        clusterName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ConfigurationProfileHCIAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is ConfigurationProfileHCIAssignmentOps.Read<ConfigurationProfileAssignment>;

  /**
   * Creates an association between a AzureStackHCI cluster and Automanage configuration profile
   */
  createOrUpdate is ConfigurationProfileHCIAssignmentOps.CreateOrUpdateSync<ConfigurationProfileAssignment>;

  /**
   * Delete a configuration profile assignment
   */
  delete is ConfigurationProfileHCIAssignmentOps.DeleteSync<ConfigurationProfileAssignment>;

  /**
   * Get list of configuration profile assignments
   */
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
