import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Quantum.ProviderAccount;
/**
 * The resource proxy definition object for Quantum ProviderAccount.
 */
@added(Versions.v2025_02_15_preview)
model QuantumProviderAccount
  is Azure.ResourceManager.TrackedResource<ProviderAccountProperties> {
  ...ResourceNameParameter<
    Resource = QuantumProviderAccount,
    KeyName = "ProviderAccountName",
    SegmentName = "providerAccounts",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Properties of a ProviderAccount
 */
@added(Versions.v2025_02_15_preview)
model ProviderAccountProperties {
  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: AccountProvisioningState;

  /** The ProviderId which will be referenced by and that can be added to Azure Quantum Workspaces. */
  @minLength(2)
  @maxLength(14)
  @pattern("^([a-z0-9]+(-[a-z0-9]+)*)$")
  providerId: string;

  /** Display name of this ProviderAccount. */
  @minLength(2)
  @maxLength(50)
  displayName: string;

  /** Description of this ProviderAccount. */
  @maxLength(240)
  description?: string = "";

  /** The name of the company that is providing this ProviderAccount. */
  @minLength(2)
  @maxLength(50)
  companyName: string;

  /** List of Azure Subscriptions that are allowed to view/access resources from this ProviderAccount. */
  allowedSubscriptions?: SubscriptionId[];

  /** List of Targets available in this ProviderAccount. */
  targets?: ProviderAccountTarget[];

  /** Managed On Behalf Of configuration. */
  @visibility("read")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  // /** Azure ARC configuration. */
  // machineEntity: ...;

  // /** Quota Dimension definitions for this ProviderAccount. */
  // @visibility("read", "create", "update")
  // quotaDimensions?: QuotaDimension[];

  // /** List of subscriptions-level Quotas for this ProviderAccount. */
  // @visibility("read", "create", "update")
  // subscriptionQuotaLimits?: SubscriptionQuotaLimit[];
}

/** The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000). */
@minLength(36)
@maxLength(36)
@pattern("^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$")
scalar SubscriptionId extends string;

/** A Target of a ProviderAccount, in which Workspace Jobs can be targeted at for execution. */
@added(Versions.v2025_02_15_preview)
model ProviderAccountTarget {
  /**
   * The globally-unique ID of the Target.
   *
   * Must be prefixed by the `providerId` using the format `{providerId}.{target}`.
   * The `{target}` itself may include suffixes separated by `.` or `-`.
   * Valid examples:
   * - "my-provider.my-target"
   * - "my-provider.my-target-01"
   * - "my-provider.my-target.variant-01"
   *  */
  @minLength(2)
  @maxLength(50)
  @pattern("^([a-z0-9]+(-[a-z0-9]+)*)(\\.([a-z0-9]+(-[a-z0-9]+)*))+$")
  id: string;

  /** The display name of the Target. */
  @minLength(2)
  @maxLength(50)
  name: string;

  /** Description of the Target. */
  @maxLength(240)
  description?: string = "";
}

/** The provisioning state of a resource. */
@lroStatus
@added(Versions.v2025_02_15_preview)
union AccountProvisioningState {
  ResourceProvisioningState,

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",
}

@armResourceOperations
@added(Versions.v2025_02_15_preview)
interface ProviderAccounts {
  /**
   * Returns the ProviderAccount resource associated with the given name.
   */
  @added(Versions.v2025_02_15_preview)
  get is ArmResourceRead<QuantumProviderAccount>;

  /**
   * Creates or updates a ProviderAccount resource.
   */
  @added(Versions.v2025_02_15_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<QuantumProviderAccount>;

  /**
   * Updates an existing ProviderAccount's tags.
   */
  @added(Versions.v2025_02_15_preview)
  update is ArmResourcePatchSync<
    QuantumProviderAccount,
    ProviderAccountProperties
  >;

  /**
   * Deletes a ProviderAccount resource.
   */
  @added(Versions.v2025_02_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<QuantumProviderAccount>;

  /**
   * Gets the list of ProviderAccounts within a resource group.
   */
  @added(Versions.v2025_02_15_preview)
  listByResourceGroup is ArmResourceListByParent<QuantumProviderAccount>;

  /**
   * Gets the list of ProviderAccount within a Subscription.
   */
  @added(Versions.v2025_02_15_preview)
  listBySubscription is ArmListBySubscription<QuantumProviderAccount>;
}

@@doc(QuantumProviderAccount.name,
  "The name of the Quantum ProviderAccount resource."
);
@@doc(QuantumProviderAccount.properties,
  "Gets or sets the properties. Define Quantum provider account's specific properties."
);
@@doc(ProviderAccounts.createOrUpdate::parameters.resource,
  "ProviderAccount details."
);
@@doc(ProviderAccounts.update::parameters.properties,
  "ProviderAccount details."
);
