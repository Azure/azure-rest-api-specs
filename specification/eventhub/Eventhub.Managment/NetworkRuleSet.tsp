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

@armResourceOperations
interface NetworkRuleSets {
  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_GetNetworkRuleSet")
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet, Error = ErrorResponse>;

  /**
   * Create or update NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateNetworkRuleSet")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<
    NetworkRuleSet,
    Response = ArmResourceUpdatedResponse<NetworkRuleSet>,
    Error = ErrorResponse
  >;

  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_ListNetworkRuleSet")
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
