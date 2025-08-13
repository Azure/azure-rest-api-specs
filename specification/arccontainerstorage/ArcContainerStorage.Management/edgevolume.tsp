import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.ArcContainerStorage;

/**
 * EdgeVolume is a custom resource that defines the configuration for edge volume storage.
 */
@doc("EdgeVolume is a custom resource for defining an edge volume.")
model EdgeVolume is ExtensionResource<EdgeVolumeProperties> {
  ...ResourceNameParameter<
    EdgeVolume,
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$"
  >;
}

/**
 * Defines the properties for the EdgeVolume resource (similar to 'spec' in the CRD).
 */
@doc("Defines the desired state (spec) of the EdgeVolume resource.")
model EdgeVolumeProperties {
  @doc("Size of the EdgeVolume (example: 1Gi). Must be a valid storage size and is immutable once set.")
  @pattern("^[0-9][0-9]*([.][0-9]+)?[KMGTP]i?$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  requestedSize: string;

  @doc("Weight of concurrency for ingest operations (between 1 and 256).")
  @minValue(1) // Minimum value constraint
  @maxValue(256) // Maximum value constraint
  ingestOperationConcurrency?: int32;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: EdgeVolumeStatus;
}

/**
 * Defines the observed status of the EdgeVolume resource.
 */
@doc("Defines the observed state (status) of the EdgeVolume resource.")
model EdgeVolumeStatus {
  @doc("The current state of the EdgeVolume. Defaults to 'unknown'.")
  state?: EdgeVolumeState;

  @doc("Additional details about the EdgeVolume status.")
  details?: string;

  @doc("The amount of space available (string format, e.g., '500Mi').")
  @pattern("^[0-9][0-9]*([.][0-9]+)?[KMGTP]i?$")
  spaceAvailable?: string;

  @doc("The name of the kubernetes persistent volume resource underlying this edgevolume.")
  persistentVolume?: string;
}

@doc("States of an EdgeVolume")
union EdgeVolumeState {
  @doc("edgevolume is in an unknown state")
  Unknown: "unknown",

  @doc("edgevolume is deploying")
  Deploying: "deploying",

  @doc("edgevolume is deployed and running")
  Deployed: "deployed",

  string,
}

/**
 * CRUD operations for the EdgeVolume resource.
 */
@armResourceOperations
interface EdgeVolumes {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeVolume>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeVolume>;
  get is ArmResourceRead<EdgeVolume>;
  list is ArmResourceListByParent<EdgeVolume>;
  update is ArmResourcePatchAsync<EdgeVolume, EdgeVolumeProperties>;
}
