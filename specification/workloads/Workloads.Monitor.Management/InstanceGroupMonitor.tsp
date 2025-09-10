using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/** Instance Group Monitor resource */
model InstanceGroupMonitor is TrackedResource<InstanceGroupMonitorProperties> {
  ...ResourceNameParameter<
    Resource = InstanceGroupMonitor,
    NamePattern = ResourceNamePattern
  >;
}

/** Instance Group Monitor properties */
model InstanceGroupMonitorProperties is ResourceCommonProperties {
  /** The resource ID of the health model that represent the instance group or landscape. */
  @visibility(Lifecycle.Read)
  healthModelId?: armResourceIdentifier<[
    {
      type: "Microsoft.CloudHealth/healthModels";
    }
  ]>;

  /** The managed resource group configuration */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /** The resource ID of the user assigned identity that will assigned to health model. */
  userAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /** The discovery configurations */
  @Azure.ResourceManager.identifiers(#[])
  discoveryConfigurations: DiscoveryConfiguration[];

  /** The group configurations */
  @Azure.ResourceManager.identifiers(#["groupBy"])
  groupConfigurations?: GroupConfiguration[];
}

@armResourceOperations
interface InstanceGroupMonitors {
  /** Get the instance group monitor */
  get is ArmResourceRead<InstanceGroupMonitor>;

  /** Create or replace the instance group monitor */
  create is ArmResourceCreateOrReplaceAsync<InstanceGroupMonitor>;

  /** Update the instance group monitor */
  update is ArmTagsPatchSync<InstanceGroupMonitor>;

  /** Delete the instance group monitor */
  delete is ArmResourceDeleteWithoutOkAsync<InstanceGroupMonitor>;

  /** List instance group monitors by resource group */
  listByResourceGroup is ArmResourceListByParent<InstanceGroupMonitor>;

  /** List instance group monitors by subscription */
  listBySubscription is ArmListBySubscription<InstanceGroupMonitor>;

  /** Get the instance health status at instance group scope */
  getHealthStatus is ArmResourceActionAsync<
    InstanceGroupMonitor,
    {
      @doc("Get health status request body")
      @body
      body?: HealthStatusRequestBody;
    },
    InstanceGroupHealthStatusResponse
  >;
}
