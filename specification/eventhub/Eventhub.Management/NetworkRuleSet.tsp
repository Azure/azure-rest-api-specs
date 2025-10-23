import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Description of topic resource.
 */
@singleton("default")
@parentResource(EHNamespace)
model NetworkRuleSet
  is Azure.ResourceManager.ProxyResource<NetworkRuleSetProperties> {
  ...ResourceNameParameter<
    Resource = NetworkRuleSet,
    KeyName = "networkRuleSet",
    SegmentName = "networkRuleSets",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

alias NetworkRuleSetsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The Namespace name */
    @path
    @segment("namespaces")
    @key
    @minLength(6)
    @maxLength(50)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$")
    namespaceName: string;
  },
  {
    /** The authorization rule name. */
    @path
    @segment("networkRuleSets")
    @key
    @minLength(1)
    networkRuleSet: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface NetworkRuleSets {
  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet, Error = ErrorResponse>;

  /**
   * Create or update NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<
    NetworkRuleSet,
    Response = ArmResourceUpdatedResponse<NetworkRuleSet>,
    Error = ErrorResponse
  >;

  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  listNetworkRuleSet is NetworkRuleSetsOps.ListSinglePage<
    NetworkRuleSet,
    Response = NetworkRuleSetListResult,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(NetworkRuleSet.name, "");
@@doc(NetworkRuleSet.properties, "NetworkRuleSet properties");
@@doc(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);
