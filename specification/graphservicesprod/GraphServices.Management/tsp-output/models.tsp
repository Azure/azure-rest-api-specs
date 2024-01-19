import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.GraphServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model AccountResourceSystemData {
  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("Property bag from billing account")
model AccountResourceProperties {
  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Customer owned application ID")
  @visibility("read", "create")
  @pattern("(^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}?)$")
  appId: string;

  @doc("Billing Plan Id")
  @visibility("read")
  @pattern("(^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}?)$")
  billingPlanId?: string;
}

@doc("An Azure resource.")
model Resource {
  @doc("Azure resource ID.")
  @visibility("read")
  id?: string;

  @doc("Azure resource name.")
  @visibility("read")
  name?: string;

  @doc("Azure resource type.")
  @visibility("read")
  type?: string;

  @doc("Location of the resource.")
  location?: string;

  @doc("resource tags.")
  tags?: Record<string>;
}

@doc("Account patch properties")
model AccountPatchResource extends TagUpdate {}

@doc("Request payload used to update an existing resource's tags.")
model TagUpdate {
  @doc("List of key value pairs that describe the resource. This will overwrite the existing tags.")
  tags?: Record<string>;
}
