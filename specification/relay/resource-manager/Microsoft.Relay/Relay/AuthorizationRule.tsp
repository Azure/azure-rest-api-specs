import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Single item in a List or Get AuthorizationRule operation
 */
@parentResource(RelayNamespace)
model AuthorizationRule
  is Azure.ResourceManager.ProxyResource<AuthorizationRuleProperties> {
  ...AuthorizationRuleNameParameter;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@@minLength(AuthorizationRuleNameParameter.name, 1);
@@doc(AuthorizationRuleNameParameter.name, "The authorization rule name.");
model AuthorizationRuleNameParameter
  is ResourceNameParameter<
    Resource = AuthorizationRule,
    KeyName = "authorizationRuleName",
    SegmentName = "authorizationRules",
    NamePattern = ""
  >;

@armResourceOperations
interface AuthorizationRuleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<RelayNamespaceNameParameter>,
      },
      KeysOf<AuthorizationRuleNameParameter>
    > {}

@armResourceOperations
interface AuthorizationRules {
  /**
   * Authorization rule for a namespace by name.
   */
  getAuthorizationRule is AuthorizationRuleOps.Read<AuthorizationRule>;

  /**
   * Creates or updates an authorization rule for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateAuthorizationRule is AuthorizationRuleOps.CreateOrUpdateSync<
    AuthorizationRule,
    Response = ArmResourceUpdatedResponse<AuthorizationRule>
  >;

  /**
   * Deletes a namespace authorization rule.
   */
  deleteAuthorizationRule is AuthorizationRuleOps.DeleteSync<AuthorizationRule>;

  /**
   * Authorization rules for a namespace.
   */
  listAuthorizationRules is AuthorizationRuleOps.List<AuthorizationRule>;

  /**
   * Primary and secondary connection strings to the namespace.
   */
  listKeys is AuthorizationRuleOps.ActionSync<
    AuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;

  /**
   * Regenerates the primary or secondary connection strings to the namespace.
   */
  regenerateKeys is AuthorizationRuleOps.ActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>
  >;
}
@armResourceOperations
interface HybridConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<RelayNamespaceNameParameter>,
        ...KeysOf<HybridConnectionNameParameter>,
      },
      KeysOf<AuthorizationRuleNameParameter>
    > {}

@armResourceOperations
interface HybridConnections {
  /**
   * Hybrid connection authorization rule for a hybrid connection by name.
   */
  getAuthorizationRule is HybridConnectionOps.Read<AuthorizationRule>;

  /**
   * Creates or updates an authorization rule for a hybrid connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateAuthorizationRule is HybridConnectionOps.CreateOrUpdateSync<
    AuthorizationRule,
    Response = ArmResourceUpdatedResponse<AuthorizationRule>
  >;

  /**
   * Deletes a hybrid connection authorization rule.
   */
  deleteAuthorizationRule is HybridConnectionOps.DeleteSync<AuthorizationRule>;

  /**
   * Authorization rules for a hybrid connection.
   */
  listAuthorizationRules is HybridConnectionOps.List<AuthorizationRule>;

  /**
   * Primary and secondary connection strings to the hybrid connection.
   */
  listKeys is HybridConnectionOps.ActionSync<
    AuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;

  /**
   * Regenerates the primary or secondary connection strings to the hybrid connection.
   */
  regenerateKeys is HybridConnectionOps.ActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface WCFRelayOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<RelayNamespaceNameParameter>,
        ...KeysOf<WcfRelayNameParameter>,
      },
      KeysOf<AuthorizationRuleNameParameter>
    > {}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface WCFRelays {
  /**
   * Get authorizationRule for a WCF relay by name.
   */
  getAuthorizationRule is WCFRelayOps.Read<AuthorizationRule>;

  /**
   * Creates or updates an authorization rule for a WCF relay.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateAuthorizationRule is WCFRelayOps.CreateOrUpdateSync<
    AuthorizationRule,
    Response = ArmResourceUpdatedResponse<AuthorizationRule>
  >;

  /**
   * Deletes a WCF relay authorization rule.
   */
  deleteAuthorizationRule is WCFRelayOps.DeleteSync<AuthorizationRule>;

  /**
   * Authorization rules for a WCF relay.
   */
  listAuthorizationRules is WCFRelayOps.List<AuthorizationRule>;

  /**
   * Primary and secondary connection strings to the WCF relay.
   */
  listKeys is WCFRelayOps.ActionSync<
    AuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;

  /**
   * Regenerates the primary or secondary connection strings to the WCF relay.
   */
  regenerateKeys is WCFRelayOps.ActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>
  >;
}

@@doc(AuthorizationRule.properties,
  "Properties supplied to create or update AuthorizationRule"
);
@@doc(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "The authorization rule parameters."
);
@@doc(AuthorizationRules.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate authorization rule."
);
@@doc(HybridConnections.createOrUpdateAuthorizationRule::parameters.resource,
  "The authorization rule parameters."
);
@@doc(HybridConnections.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate authorization rule."
);
@@doc(WCFRelays.createOrUpdateAuthorizationRule::parameters.resource,
  "The authorization rule parameters."
);
@@doc(WCFRelays.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate authorization rule."
);
