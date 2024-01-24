import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Easm;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Resources provisioning states.
 */
enum ResourceState {
  NotSpecified,
  Accepted,
  Creating,
  Succeeded,
  Failed,
  Canceled,
  ProvisioningResources,
  InstallingApplication,
  ConfiguringApplication,
  MigratingApplicationData,
  RunningValidations,
  CreatingArtifacts,
  DeletingArtifacts,
}

/**
 * Workspace properties.
 */
model WorkspaceResourceProperties extends ResourceBaseProperties {
  /**
   * Data plane endpoint.
   */
  @visibility("read")
  dataPlaneEndpoint?: string;
}

/**
 * Resource base properties.
 */
model ResourceBaseProperties {
  /**
   * Resource provisioning state.
   */
  @visibility("read")
  provisioningState?: ResourceState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Workspace patch properties.
 */
model WorkspacePatchResource {
  /**
   * resource tags.
   */
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Label properties.
 */
model LabelResourceProperties extends ResourceBaseProperties {
  /**
   * Label display name.
   */
  displayName?: string;

  /**
   * Label color.
   */
  color?: string;
}

/**
 * Label patch properties
 */
model LabelPatchResource extends LabelResource {}

/**
 * Task details
 */
model TaskResource extends ProxyResource {
  /**
   * Task properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: TaskResourceProperties;
}

/**
 * Task properties.
 */
model TaskResourceProperties extends ResourceBaseProperties {
  /**
   * The time the task started
   */
  startedAt?: string;

  /**
   * The time the task completed
   */
  completedAt?: string;

  /**
   * The last time the task was polled
   */
  lastPolledAt?: string;

  /**
   * the state the task is in
   */
  state?: string;

  /**
   * the phase the task is in
   */
  phase?: string;

  /**
   * The reason the task was moved into its current state, if the task wasn't completed.
   */
  reason?: string;

  /**
   * The reason the task was moved into its current state, if the task wasn't completed.
   */
  metadata?: Record<unknown>;
}
