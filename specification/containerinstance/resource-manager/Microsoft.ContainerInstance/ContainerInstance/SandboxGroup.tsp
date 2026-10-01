import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ContainerInstance;

/**
 * The provisioning state of a SandboxGroup resource.
 */
@removed(Versions.v2026_08_01_preview)
union SandboxGroupProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource provisioning request was accepted but not yet started.
   */
  Accepted: "Accepted",
}

/**
 * A reference to a subnet resource.
 */
model SubnetReference {
  /**
   * The ARM resource ID of the subnet. The caller must have `Microsoft.Network/virtualNetworks/subnets/join/action` permission on this subnet (enforced via a linked access check at create/update time).
   */
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/**
 * The network profile for a SandboxGroup.
 */
@removed(Versions.v2026_08_01_preview)
model SandboxGroupNetworkProfile {
  /**
   * The list of subnets associated with the SandboxGroup.
   */
  subnets?: SubnetReference[];
}

/**
 * Properties of a SandboxGroup.
 */
@removed(Versions.v2026_08_01_preview)
model SandboxGroupProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: SandboxGroupProvisioningState;

  /**
   * The network profile of the SandboxGroup.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkProfile?: SandboxGroupNetworkProfile;

  /**
   * The ARM resource ID of the management resource group associated with this SandboxGroup.
   */
  @visibility(Lifecycle.Read)
  managementResourceGroupId?: armResourceIdentifier;
}

/**
 * A SandboxGroup tracked resource.
 */
@removed(Versions.v2026_08_01_preview)
model SandboxGroup
  is Azure.ResourceManager.TrackedResource<SandboxGroupProperties> {
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The name of the SandboxGroup.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @key("sandboxGroupName")
  @segment("sandboxGroups")
  @path
  name: string;
}

/**
 * The type used for updating a SandboxGroup resource.
 */
@removed(Versions.v2026_08_01_preview)
model SandboxGroupTagsUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is an acceptable use of Record for PATCH update envelopes."
  tags?: Record<string>;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * The result of getting an access token for a SandboxGroup.
 */
@removed(Versions.v2026_08_01_preview)
model SandboxGroupAccessToken {
  /**
   * The endpoint URL to use with the access token.
   */
  endpoint: url;

  /**
   * The access token used to authenticate against the endpoint.
   */
  @secret
  accessToken: string;

  /**
   * The UTC date and time at which the access token expires.
   */
  notAfter: utcDateTime;
}

@armResourceOperations
@added(Versions.v2026_06_01_preview)
@removed(Versions.v2026_08_01_preview)
interface SandboxGroups {
  /**
   * List SandboxGroup resources by subscription ID
   */
  @summary("List SandboxGroup resources by subscription ID")
  listBySubscription is ArmListBySubscription<SandboxGroup, Error = CloudError>;

  /**
   * List SandboxGroup resources by resource group
   */
  @summary("List SandboxGroup resources by resource group")
  listByResourceGroup is ArmResourceListByParent<
    SandboxGroup,
    Error = CloudError
  >;

  /**
   * Get a SandboxGroup
   */
  @summary("Get a SandboxGroup")
  get is ArmResourceRead<SandboxGroup, Error = CloudError>;

  /**
   * Create a SandboxGroup
   */
  @summary("Create a SandboxGroup")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SandboxGroup,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SandboxGroup> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Update a SandboxGroup
   */
  @summary("Update a SandboxGroup")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SandboxGroup,
    SandboxGroupTagsUpdate,
    Error = CloudError
  >;

  /**
   * Delete a SandboxGroup
   */
  @summary("Delete a SandboxGroup")
  delete is ArmResourceDeleteWithoutOkAsync<SandboxGroup, Error = CloudError>;

  /**
   * Get an access token and endpoint for connecting to the SandboxGroup.
   */
  @summary("Get an access token and endpoint for connecting to the SandboxGroup.")
  @post
  connect is ArmResourceActionSync<
    SandboxGroup,
    void,
    ArmResponse<SandboxGroupAccessToken>,
    Error = CloudError
  >;
}

@@doc(SandboxGroup.name, "The name of the SandboxGroup.");
@@doc(
  SandboxGroups.createOrUpdate::parameters.resource,
  "Resource create parameters."
);
@@doc(
  SandboxGroups.update::parameters.properties,
  "The resource properties to be updated."
);

// --------------------------------------------------------------------------
// AiAgentsGroups: renamed from SandboxGroups starting in 2026-08-01-preview.
// The URL segment changes from `sandboxGroups` to `AiAgentsGroups`, so the
// resource is modeled as a fresh set of types added in the new preview
// version rather than a symbol-only rename.
// --------------------------------------------------------------------------

/**
 * The provisioning state of an AiAgentsGroup resource.
 */
@added(Versions.v2026_08_01_preview)
union AiAgentsGroupProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource provisioning request was accepted but not yet started.
   */
  Accepted: "Accepted",
}

/**
 * The network profile for an AiAgentsGroup.
 */
@added(Versions.v2026_08_01_preview)
model AiAgentsGroupNetworkProfile {
  /**
   * The list of subnets associated with the AiAgentsGroup.
   */
  subnets?: SubnetReference[];
}

/**
 * Properties of an AiAgentsGroup.
 */
@added(Versions.v2026_08_01_preview)
model AiAgentsGroupProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AiAgentsGroupProvisioningState;

  /**
   * The network profile of the AiAgentsGroup.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkProfile?: AiAgentsGroupNetworkProfile;

  /**
   * The ARM resource ID of the management resource group associated with this AiAgentsGroup.
   */
  @visibility(Lifecycle.Read)
  managementResourceGroupId?: armResourceIdentifier;
}

/**
 * An AiAgentsGroup tracked resource.
 */
@added(Versions.v2026_08_01_preview)
model AiAgentsGroup
  is Azure.ResourceManager.TrackedResource<AiAgentsGroupProperties> {
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The name of the AiAgentsGroup.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @key("aiAgentsGroupName")
  @segment("aiAgentsGroups")
  @path
  name: string;
}

/**
 * The type used for updating an AiAgentsGroup resource.
 */
@added(Versions.v2026_08_01_preview)
model AiAgentsGroupTagsUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is an acceptable use of Record for PATCH update envelopes."
  tags?: Record<string>;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * The result of getting an access token for an AiAgentsGroup.
 */
@added(Versions.v2026_08_01_preview)
model AiAgentsGroupAccessToken {
  /**
   * The endpoint URL to use with the access token.
   */
  endpoint: url;

  /**
   * The access token used to authenticate against the endpoint.
   */
  @secret
  accessToken: string;

  /**
   * The UTC date and time at which the access token expires.
   */
  notAfter: utcDateTime;
}

@armResourceOperations
@added(Versions.v2026_08_01_preview)
interface AiAgentsGroups {
  /**
   * List AiAgentsGroup resources by subscription ID
   */
  @summary("List AiAgentsGroup resources by subscription ID")
  listBySubscription is ArmListBySubscription<
    AiAgentsGroup,
    Error = CloudError
  >;

  /**
   * List AiAgentsGroup resources by resource group
   */
  @summary("List AiAgentsGroup resources by resource group")
  listByResourceGroup is ArmResourceListByParent<
    AiAgentsGroup,
    Error = CloudError
  >;

  /**
   * Get an AiAgentsGroup
   */
  @summary("Get an AiAgentsGroup")
  get is ArmResourceRead<AiAgentsGroup, Error = CloudError>;

  /**
   * Create an AiAgentsGroup
   */
  @summary("Create an AiAgentsGroup")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiAgentsGroup,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AiAgentsGroup> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Update an AiAgentsGroup
   */
  @summary("Update an AiAgentsGroup")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiAgentsGroup,
    AiAgentsGroupTagsUpdate,
    Error = CloudError
  >;

  /**
   * Delete an AiAgentsGroup
   */
  @summary("Delete an AiAgentsGroup")
  delete is ArmResourceDeleteWithoutOkAsync<AiAgentsGroup, Error = CloudError>;

  /**
   * Get an access token and endpoint for connecting to the AiAgentsGroup.
   */
  @summary("Get an access token and endpoint for connecting to the AiAgentsGroup.")
  @post
  connect is ArmResourceActionSync<
    AiAgentsGroup,
    void,
    ArmResponse<AiAgentsGroupAccessToken>,
    Error = CloudError
  >;
}

@@doc(AiAgentsGroup.name, "The name of the AiAgentsGroup.");
@@doc(
  AiAgentsGroups.createOrUpdate::parameters.resource,
  "Resource create parameters."
);
@@doc(
  AiAgentsGroups.update::parameters.properties,
  "The resource properties to be updated."
);
