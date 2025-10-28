import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services RaiPolicy.
 */
@parentResource(Account)
model RaiPolicy is Azure.ResourceManager.ProxyResource<RaiPolicyProperties> {
  ...ResourceNameParameter<
    Resource = RaiPolicy,
    KeyName = "raiPolicyName",
    SegmentName = "raiPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface RaiPolicyOps
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
        /** The name of the RaiPolicy associated with the Cognitive Services Account */
        @path
        @segment("raiPolicies")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        raiPolicyName: string,
      }
    > {}

@armResourceOperations
interface RaiPolicies {
  /**
   * Gets the specified Content Filters associated with the Azure OpenAI account.
   */
  get is RaiPolicyOps.Read<RaiPolicy>;

  /**
   * Update the state of specified Content Filters associated with the Azure OpenAI account.
   */
  createOrUpdate is RaiPolicyOps.CreateOrUpdateSync<RaiPolicy>;

  /**
   * Deletes the specified Content Filters associated with the Azure OpenAI account.
   */
  delete is RaiPolicyOps.DeleteWithoutOkAsync<RaiPolicy>;

  /**
   * Gets the content filters associated with the Azure OpenAI account.
   */
  list is RaiPolicyOps.List<RaiPolicy, Response = RaiPolicyListResult>;
}
@armResourceOperations
interface SubscriptionRaiPolicyOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CognitiveServices",
      },
      {},
      {
        /** The name of the RaiPolicy associated with the Cognitive Services Account */
        @path
        @segment("raiPolicy")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        raiPolicyName: string,
      }
    > {}

@armResourceOperations
interface SubscriptionRaiPolicy {
  /**
   * Gets the specified Content Filters associated with the Subscription.
   */
  get is SubscriptionRaiPolicyOps.Read<RaiPolicy>;

  /**
   * Update the state of specified Content Filters associated with the subscription.
   */
  createOrUpdate is SubscriptionRaiPolicyOps.CreateOrUpdateSync<RaiPolicy>;

  /**
   * Deletes the specified Content Filters associated with the subscription.
   */
  delete is SubscriptionRaiPolicyOps.DeleteWithoutOkAsync<RaiPolicy>;
}

@@doc(RaiPolicy.name,
  "The name of the RaiPolicy associated with the Cognitive Services Account"
);
@@encodedName(RaiPolicy.etag, "application/json", "etag");
@@doc(RaiPolicy.properties, "Properties of Cognitive Services RaiPolicy.");
@@doc(RaiPolicies.createOrUpdate::parameters.resource,
  "Properties describing the Content Filters."
);
@@doc(SubscriptionRaiPolicy.createOrUpdate::parameters.resource,
  "Properties describing the Content Filters."
);
