import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** A SandboxGroup resource, representing a group of sandboxes that share configuration defaults and quotas. */
@added(Versions.v2026_07_01)
model SandboxGroup is TrackedResource<SandboxGroupProperties> {
  ...ResourceNameParameter<
    Resource = SandboxGroup,
    KeyName = "sandboxGroupName",
    SegmentName = "sandboxGroups",
    NamePattern = "^(?![.-])[A-Za-z0-9-]{1,32}$"
  >;
}

/** SandboxGroup resource specific properties. */
@added(Versions.v2026_07_01)
model SandboxGroupProperties {
  /** The resource ID of the Azure Container Apps environment to link to the sandbox group. A sandbox group can be linked after creation, but the link cannot then be changed or removed. For subsequent create-or-update (PUT) requests, specify the same environment ID; omitting or changing it returns 409 Conflict. Omitting it from an update (PATCH) request leaves the existing link unchanged. */
  environmentId?: armResourceIdentifier<[
    {
      type: "Microsoft.App/managedEnvironments";
    }
  ]>;

  /** The default domain of the linked Azure Container Apps environment. Sandbox endpoints use subdomains of this domain. This read-only property is populated by the service and is omitted when no environment is linked. */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Description is on the referenced type to avoid emitting a sibling of $ref."
  @visibility(Lifecycle.Read)
  provisioningState?: SandboxGroupProvisioningState;
}

/** Provisioning state of the SandboxGroup. */
@added(Versions.v2026_07_01)
@lroStatus
union SandboxGroupProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  InProgress: "InProgress",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

@added(Versions.v2026_07_01)
@armResourceOperations
interface SandboxGroups {
  /** Get the properties of a SandboxGroup. */
  get is ArmResourceRead<SandboxGroup>;

  /** Create or update a SandboxGroup. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SandboxGroup>;

  /** Patches a SandboxGroup. */
  update is ArmCustomPatchAsync<
    SandboxGroup,
    SandboxGroupPatch,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /** Delete a SandboxGroup. */
  delete is ArmResourceDeleteWithoutOkAsync<
    SandboxGroup,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /** Get all SandboxGroups in a resource group. */
  listByResourceGroup is ArmResourceListByParent<SandboxGroup>;

  /** Get all SandboxGroups for a subscription. */
  listBySubscription is ArmListBySubscription<SandboxGroup>;
}

/** A SandboxGroup resource for use in patch requests. */
@added(Versions.v2026_07_01)
model SandboxGroupPatch {
  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Resource tags are defined as an open key/value map per ARM contract."
  tags?: Record<string>;

  /** SandboxGroup properties that can be updated. */
  properties?: SandboxGroupPatchProperties;
}

/** SandboxGroup resource specific properties for patch requests. */
@added(Versions.v2026_07_01)
model SandboxGroupPatchProperties {
  ...PickProperties<SandboxGroupProperties, "environmentId">;
}
