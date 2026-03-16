import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.GuestConfiguration;

// ============================================================================
// User Resource
// ============================================================================

/** User resource managed by Guest Configuration. */
model User is ProxyResource<UserProperties> {
  ...ResourceNameParameter<User>;
}

/** Properties of a User resource. */
model UserProperties {
  /** The display name of the user. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** The description of the user. */
  @visibility(Lifecycle.Read)
  description?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Operations for User resources. */
@armResourceOperations
interface Users {
  /** Get a User resource. */
  get is ArmResourceRead<User>;

  /** List User resources by resource group. */
  listByResourceGroup is ArmResourceListByParent<User>;
}

// ============================================================================
// Group Resource
// ============================================================================

/** Group resource managed by Guest Configuration. */
model Group is ProxyResource<GroupProperties> {
  ...ResourceNameParameter<Group>;
}

/** Properties of a Group resource. */
model GroupProperties {
  /** The display name of the group. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** The description of the group. */
  @visibility(Lifecycle.Read)
  description?: string;

  /** The members of the group. */
  @visibility(Lifecycle.Read)
  members?: string[];

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Operations for Group resources. */
@armResourceOperations
interface Groups {
  /** Get a Group resource. */
  get is ArmResourceRead<Group>;

  /** List Group resources by resource group. */
  listByResourceGroup is ArmResourceListByParent<Group>;
}

// ============================================================================
// Application Resource
// ============================================================================

/** Application resource managed by Guest Configuration. */
model Application is ProxyResource<ApplicationProperties> {
  ...ResourceNameParameter<Application>;
}

/** Properties of an Application resource. */
model ApplicationProperties {
  /** The display name of the application. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** The description of the application. */
  @visibility(Lifecycle.Read)
  description?: string;

  /** The version of the application. */
  @visibility(Lifecycle.Read)
  version?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Operations for Application resources. */
@armResourceOperations
interface Applications {
  /** Get an Application resource. */
  get is ArmResourceRead<Application>;

  /** List Application resources by resource group. */
  listByResourceGroup is ArmResourceListByParent<Application>;
}

// ============================================================================
// Common Types
// ============================================================================

/** The resource provisioning state. */
union ProvisioningState {
  ResourceProvisioningState,

  string,
}
