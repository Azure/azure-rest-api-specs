using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/** Instance Monitor resource */
model InstanceMonitor is TrackedResource<InstanceMonitorProperties> {
  ...ResourceNameParameter<InstanceMonitor>;
}

/** Instance Monitor properties */
model InstanceMonitorProperties is ResourceCommonProperties {
  /** The workload instance ID */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workloadInstanceId?: string;

  /** The resource ID of the health model that represent the virtual instance health */
  @visibility(Lifecycle.Read)
  healthModelId?: armResourceIdentifier<[
    {
      type: "Microsoft.CloudHealth/healthModels";
    }
  ]>;

  /** The managed resource group configuration */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /** The health definition resource details used for creating health model */
  healthDefinition?: HealthDefinitionDetails;

  /** The resource ID of the user assigned identity that will assigned to health model. */
  userAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /** The health model state. */
  healthModelState?: HealthModelState;

  /** The health evaluation interval.
   * Allowed values:  PT1M, PT5M, PT10M, PT30M, PT1H, PT2H.
   * Default value: PT5M */
  refreshInterval?: string;
}

@armResourceOperations
interface InstanceMonitors {
  /** Get the instance monitor */
  get is ArmResourceRead<InstanceMonitor>;

  /** Create or replace the instance monitor */
  create is ArmResourceCreateOrReplaceAsync<InstanceMonitor>;

  /** Update the instance monitor */
  update is ArmResourcePatchAsync<InstanceMonitor, InstanceMonitorProperties>;

  /** Delete the instance monitor */
  delete is ArmResourceDeleteWithoutOkAsync<InstanceMonitor>;

  /** List instance monitors by resource group */
  @list
  listByResourceGroup is ArmResourceListByParent<InstanceMonitor>;

  /** List instance group monitors by subscription */
  @list
  listBySubscription is ArmListBySubscription<InstanceMonitor>;

  /** Get the health status of the instance */
  getHealthStatus is ArmResourceActionAsync<
    InstanceMonitor,
    {
      @doc("Get health status request body")
      @body
      body?: HealthStatusRequestBody;
    },
    InstanceHealthStatusResponse
  >;
}
