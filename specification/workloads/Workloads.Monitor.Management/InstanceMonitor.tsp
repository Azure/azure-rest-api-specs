using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/**
 * Virtual Instance resource reference.
 * This is a virtual resource used as the parent for InstanceMonitor.
 */
@armVirtualResource
model VirtualInstance {
  /** The name of the Virtual Instance resource */
  @path
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-_]{3,64}$")
  @segment("virtualInstances")
  @key("virtualInstanceName")
  name: string;
}

/**
 * Instance Monitor resource.
 * This is a singleton child proxy resource under VirtualInstance that enables/disables Observability for a given WVI.
 */
@singleton("default")
@parentResource(VirtualInstance)
model InstanceMonitor
  is Azure.ResourceManager.ProxyResource<InstanceMonitorProperties> {
  ...ResourceNameParameter<
    Resource = InstanceMonitor,
    SegmentName = "instanceMonitors"
  >;
}

/** Instance Monitor properties */
model InstanceMonitorProperties is ResourceCommonProperties {
  /** The resource ID of the health model that represent the virtual instance health */
  @visibility(Lifecycle.Read)
  healthModelId?: armResourceIdentifier<[
    {
      type: "Microsoft.CloudHealth/healthModels";
    }
  ]>;

  /**
   * Location to create the AHM.
   * Defaults to the WVI's location.
   */
  healthModelLocation?: string;
}

@armResourceOperations
interface InstanceMonitors {
  /** Get the instance monitor */
  get is ArmResourceRead<InstanceMonitor>;

  /** Create or replace the instance monitor. Enables the Observability capability for the WVI. */
  create is ArmResourceCreateOrReplaceAsync<InstanceMonitor>;

  /** Update the instance monitor. Allows the PATCH operation for InstanceMonitor. */
  update is ArmResourcePatchAsync<InstanceMonitor, InstanceMonitorProperties>;

  /** Delete the instance monitor. Disables the Observability capability for the WVI. */
  delete is ArmResourceDeleteWithoutOkAsync<InstanceMonitor>;

  /** List instance monitors by parent (Virtual Instance) */
  @list
  listByParent is ArmResourceListByParent<InstanceMonitor>;
}

@@doc(InstanceMonitor.name,
  "The name of the instance monitor resource. This is a singleton resource with the name 'default'."
);
@@doc(InstanceMonitor.properties, "Instance monitor properties");
@@doc(InstanceMonitors.create::parameters.resource,
  "Request body representing an instance monitor resource"
);
