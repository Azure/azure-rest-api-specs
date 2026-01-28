import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ComputeLimit;

/** Compute limits shared by the subscription. */
@parentResource(SubscriptionLocationResource)
model SharedLimit is ProxyResource<SharedLimitProperties> {
  ...ResourceNameParameter<
    Resource = SharedLimit,
    KeyName = "name",
    SegmentName = "sharedLimits"
  >;
}

/** Properties of the compute shared limit. */
model SharedLimitProperties {
  /** The limit name properties. */
  @visibility(Lifecycle.Read)
  resourceName?: LimitName;

  /** The maximum permitted usage of the resource. */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /** The quota units, such as Count. */
  @visibility(Lifecycle.Read)
  unit?: string = "Count";

  ...DefaultProvisioningStateProperty;
}

/** Properties of the limit name. */
model LimitName {
  /** The limit name. */
  value: string;

  /** The localized limit name. */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/** Extension-scoped operations for shared compute limits. */
@armResourceOperations
interface SharedLimits {
  /**
   * Gets the properties of a compute limit shared by the host subscription with its guest subscriptions.
   */
  get is ArmResourceRead<SharedLimit>;

  /**
   * Enables sharing of a compute limit by the host subscription with its guest subscriptions.
   */
  create is ArmResourceCreateOrReplaceSync<SharedLimit>;

  /**
   * Disables sharing of a compute limit by the host subscription with its guest subscriptions.
   */
  delete is ArmResourceDeleteSync<SharedLimit>;

  /**
   * Lists all compute limits shared by the host subscription with its guest subscriptions.
   */
  list is ArmResourceListAtScope<SharedLimit>;
}
