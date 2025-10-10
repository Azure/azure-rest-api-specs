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

alias ConfigurationProfileAssignmentBySubscriptionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
  },
  {
    ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>;
  },
  {
    ...Extension.ExtensionProviderNamespace<ConfigurationProfileAssignment>;

    /** The configuration profile assignment name. */
    @path
    @segment("configurationProfileAssignments")
    @key
    configurationProfileAssignmentName: string;
  }
>;

alias ConfigurationProfileAssignmentExternalResource = Extension.ExternalResource<
  "Microsoft.Compute",
  "virtualMachines",
  "vmName",
  NamePattern = "",
  Description = "The name of the virtual machine."
>;

@armResourceOperations
interface ConfigurationProfileAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is Extension.Read<
    ConfigurationProfileAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Creates an association between a VM and Automanage configuration profile
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    ConfigurationProfileAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Delete a configuration profile assignment
   */
  delete is Extension.DeleteSync<
    ConfigurationProfileAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Get list of configuration profile assignments
   */
  list is Extension.ListByTarget<
    Extension.ResourceGroup,
    ConfigurationProfileAssignment,
    Response = ConfigurationProfileAssignmentList
  >;

  /**
   * Get list of configuration profile assignments
   */
  listByVirtualMachines is Extension.ListByTarget<
    ConfigurationProfileAssignmentExternalResource,
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;

  /**
   * Get list of configuration profile assignments under a given subscription
   */
  listBySubscription is Extension.ListByTarget<
    Extension.Subscription,
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;
}

alias ConfigurationProfileHCRPAssignmentExternalResource = Extension.ExternalResource<
  "Microsoft.HybridCompute",
  "machines",
  "machineName",
  NamePattern = "",
  Description = "The name of the Arc machine."
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ConfigurationProfileHCRPAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is Extension.Read<
    ConfigurationProfileHCRPAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Creates an association between a ARC machine and Automanage configuration profile
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    ConfigurationProfileHCRPAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Delete a configuration profile assignment
   */
  delete is Extension.DeleteSync<
    ConfigurationProfileHCRPAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Get list of configuration profile assignments
   */
  listByMachineName is Extension.ListByTarget<
    ConfigurationProfileHCRPAssignmentExternalResource,
    ConfigurationProfileAssignment,
    Response = ArmResponse<ConfigurationProfileAssignmentList>
  >;
}

alias ConfigurationProfileHCIAssignmentExternalResource = Extension.ExternalResource<
  "Microsoft.AzureStackHci",
  "clusters",
  "clusterName",
  NamePattern = "",
  Description = "The name of the Arc machine."
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ConfigurationProfileHCIAssignments {
  /**
   * Get information about a configuration profile assignment
   */
  get is Extension.Read<
    ConfigurationProfileHCIAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Creates an association between a AzureStackHCI cluster and Automanage configuration profile
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    ConfigurationProfileHCIAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Delete a configuration profile assignment
   */
  delete is Extension.DeleteSync<
    ConfigurationProfileHCIAssignmentExternalResource,
    ConfigurationProfileAssignment
  >;

  /**
   * Get list of configuration profile assignments
   */
  listByClusterName is Extension.ListByTarget<
    ConfigurationProfileHCIAssignmentExternalResource,
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
