import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Network Policy resource for controlling sandbox traffic at the account level.
 * Account-level policies are shared across all projects, aligning with
 * RAI policies and networking which are also account-scoped.
 */
@added(Versions.v2026_05_15_preview)
@parentResource(Account)
model NetworkPolicyResource
  is Azure.ResourceManager.ProxyResource<NetworkPolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkPolicyResource,
    KeyName = "networkPolicyName",
    SegmentName = "networkPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,62}$"
  >;
}

// --- Account-level operations ---

@added(Versions.v2026_05_15_preview)
@armResourceOperations
interface AccountNetworkPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      {
        /** The name of the network policy. */
        @path
        @segment("networkPolicies")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,62}$")
        networkPolicyName: string,
      },
      ResourceName = "CognitiveServicesAccountNetworkPolicy"
    > {}

@added(Versions.v2026_05_15_preview)
@armResourceOperations(#{ omitTags: true })
interface AccountNetworkPolicies {
  /**
   * Gets the specified network policy associated with the Cognitive Services account.
   */
  @tag("AccountNetworkPolicyResource")
  get is AccountNetworkPolicyOps.Read<NetworkPolicyResource>;

  /**
   * Creates or updates a network policy under the specified Cognitive Services account.
   */
  @tag("AccountNetworkPolicyResource")
  createOrUpdate is AccountNetworkPolicyOps.CreateOrUpdateSync<NetworkPolicyResource>;

  /**
   * Deletes the specified network policy from the Cognitive Services account.
   */
  @tag("AccountNetworkPolicyResource")
  delete is AccountNetworkPolicyOps.DeleteSync<NetworkPolicyResource>;

  /**
   * Lists all network policies under the specified Cognitive Services account.
   */
  @tag("AccountNetworkPolicyResource")
  list is AccountNetworkPolicyOps.List<
    NetworkPolicyResource,
    Response = NetworkPolicyListResult
  >;
}

// --- Documentation annotations ---

@@doc(NetworkPolicyResource.name, "The name of the network policy.");
@@doc(
  NetworkPolicyResource.properties,
  "Properties of the network policy resource."
);
@@doc(
  AccountNetworkPolicies.createOrUpdate::parameters.resource,
  "The network policy resource to create or update."
);
@@summary(
  AccountNetworkPolicies.list,
  "Lists all network policies under the specified Cognitive Services account."
);
@@summary(
  AccountNetworkPolicies.get,
  "Gets the specified network policy associated with the Cognitive Services account."
);
@@summary(
  AccountNetworkPolicies.createOrUpdate,
  "Creates or updates a network policy under the specified Cognitive Services account."
);
@@summary(
  AccountNetworkPolicies.delete,
  "Deletes the specified network policy from the Cognitive Services account."
);
