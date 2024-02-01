import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.GraphServices;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state.
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model AccountResourceSystemData {
  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: CreatedByType;

  /**
   * The timestamp of resource last modification (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * Property bag from billing account
 */
model AccountResourceProperties {
  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Customer owned application ID
   */
  @visibility("read", "create")
  @pattern("(^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}?)$")
  appId: string;

  /**
   * Billing Plan Id
   */
  @visibility("read")
  @pattern("(^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}?)$")
  billingPlanId?: string;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * Azure resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Location of the resource.
   */
  location?: string;

  /**
   * resource tags.
   */
  tags?: Record<string>;
}

/**
 * Account patch properties
 */
model AccountPatchResource extends TagUpdate {}

/**
 * Request payload used to update an existing resource's tags.
 */
model TagUpdate {
  /**
   * List of key value pairs that describe the resource. This will overwrite the existing tags.
   */
  tags?: Record<string>;
}
