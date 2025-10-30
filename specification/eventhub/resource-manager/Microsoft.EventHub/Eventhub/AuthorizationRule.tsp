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
 * Single item in a List or Get AuthorizationRule operation
 */
@parentResource(EHNamespace)
model AuthorizationRule
  is Azure.ResourceManager.ProxyResource<AuthorizationRuleProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizationRule,
    KeyName = "authorizationRuleName",
    SegmentName = "authorizationRules",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

alias AuthorizationRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("authorizationRules")
    @key
    @minLength(1)
    authorizationRuleName: string;
  }
>;

@armResourceOperations
interface AuthorizationRules {
  /**
   * Gets an AuthorizationRule for a Namespace by rule name.
   */
  getAuthorizationRule is AuthorizationRuleOps.Read<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an AuthorizationRule for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateAuthorizationRule is AuthorizationRuleOps.CreateOrUpdateSync<
    AuthorizationRule,
    Response = ArmResourceUpdatedResponse<AuthorizationRule>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes an AuthorizationRule for a Namespace.
   */
  deleteAuthorizationRule is AuthorizationRuleOps.DeleteSync<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a list of authorization rules for a Namespace.
   */
  listAuthorizationRules is AuthorizationRuleOps.List<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the primary and secondary connection strings for the Namespace.
   */
  listKeys is AuthorizationRuleOps.ActionSync<
    AuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Regenerates the primary or secondary connection strings for the specified Namespace.
   */
  regenerateKeys is AuthorizationRuleOps.ActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;
}
alias DisasterRecoveryConfigOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The Disaster Recovery configuration name */
    @path
    @segment("disasterRecoveryConfigs")
    @key
    @minLength(1)
    @maxLength(50)
    `alias`: string;
  },
  {
    /** The authorization rule name. */
    @path
    @segment("authorizationRules")
    @key
    @minLength(1)
    authorizationRuleName: string;
  }
>;

@armResourceOperations
interface DisasterRecoveryConfigs {
  /**
   * Gets an AuthorizationRule for a Namespace by rule name.
   */
  getAuthorizationRule is DisasterRecoveryConfigOps.Read<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a list of authorization rules for a Namespace.
   */
  listAuthorizationRules is DisasterRecoveryConfigOps.List<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the primary and secondary connection strings for the Namespace.
   */
  listKeys is DisasterRecoveryConfigOps.ActionSync<
    AuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;
}
alias EventHubOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The Event Hub name */
    @path
    @segment("eventhubs")
    @key
    @minLength(1)
    @maxLength(256)
    eventHubName: string;
  },
  {
    /** The authorization rule name. */
    @path
    @segment("authorizationRules")
    @key
    @minLength(1)
    authorizationRuleName: string;
  }
>;

@armResourceOperations
interface EventHubs {
  /**
   * Gets an AuthorizationRule for an Event Hub by rule name.
   */
  getAuthorizationRule is EventHubOps.Read<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an AuthorizationRule for the specified Event Hub. Creation/update of the AuthorizationRule will take a few seconds to take effect.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateAuthorizationRule is EventHubOps.CreateOrUpdateSync<
    AuthorizationRule,
    Response = ArmResourceUpdatedResponse<AuthorizationRule>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes an Event Hub AuthorizationRule.
   */
  deleteAuthorizationRule is EventHubOps.DeleteSync<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the authorization rules for an Event Hub.
   */
  listAuthorizationRules is EventHubOps.List<
    AuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the ACS and SAS connection strings for the Event Hub.
   */
  listKeys is EventHubOps.ActionSync<
    AuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Regenerates the ACS and SAS connection strings for the Event Hub.
   */
  regenerateKeys is EventHubOps.ActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;
}

@@minLength(AuthorizationRule.name, 1);
@@doc(AuthorizationRule.name, "The authorization rule name.");
@@doc(AuthorizationRule.properties,
  "Properties supplied to create or update AuthorizationRule"
);
@@doc(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access AuthorizationRule."
);
@@doc(AuthorizationRules.regenerateKeys::parameters.body,
  "Parameters required to regenerate the connection string."
);
@@doc(EventHubs.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access AuthorizationRule."
);
@@doc(EventHubs.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate the AuthorizationRule Keys (PrimaryKey/SecondaryKey)."
);
