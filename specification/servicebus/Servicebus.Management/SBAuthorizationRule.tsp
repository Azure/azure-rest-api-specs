import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of a namespace authorization rule.
 */
@parentResource(SBNamespace)
model SBAuthorizationRule
  is Azure.ResourceManager.ProxyResource<SBAuthorizationRuleProperties> {
  ...ResourceNameParameter<
    Resource = SBAuthorizationRule,
    KeyName = "authorizationRuleName",
    SegmentName = "AuthorizationRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SBAuthorizationRuleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SBNamespace,
          KeyName = "namespaceName",
          SegmentName = "namespaces",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SBAuthorizationRule,
        KeyName = "authorizationRuleName",
        SegmentName = "AuthorizationRules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SBAuthorizationRules {
  /**
   * Gets an authorization rule for a namespace by rule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_GetAuthorizationRule")
  getAuthorizationRule is SBAuthorizationRuleOps.Read<SBAuthorizationRule>;

  /**
   * Creates or updates an authorization rule for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is SBAuthorizationRuleOps.CreateOrUpdateSync<
    SBAuthorizationRule,
    Response = ArmResourceUpdatedResponse<SBAuthorizationRule>
  >;

  /**
   * Deletes a namespace authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_DeleteAuthorizationRule")
  deleteAuthorizationRule is SBAuthorizationRuleOps.DeleteSync<SBAuthorizationRule>;

  /**
   * Gets the authorization rules for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_ListAuthorizationRules")
  listAuthorizationRules is SBAuthorizationRuleOps.List<SBAuthorizationRule>;

  /**
   * Gets the primary and secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_ListKeys")
  listKeys is SBAuthorizationRuleOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;

  /**
   * Regenerates the primary or secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_RegenerateKeys")
  regenerateKeys is SBAuthorizationRuleOps.ActionSync<
    SBAuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>
  >;
}
@armResourceOperations
interface DisasterRecoveryConfigOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SBNamespace,
          KeyName = "namespaceName",
          SegmentName = "namespaces",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ArmDisasterRecovery,
          KeyName = "alias",
          SegmentName = "disasterRecoveryConfigs",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SBAuthorizationRule,
        KeyName = "authorizationRuleName",
        SegmentName = "authorizationRules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DisasterRecoveryConfigs {
  /**
   * Gets an authorization rule for a namespace by rule name.
   */
  getAuthorizationRule is DisasterRecoveryConfigOps.Read<SBAuthorizationRule>;

  /**
   * Gets the authorization rules for a namespace.
   */
  listAuthorizationRules is DisasterRecoveryConfigOps.List<SBAuthorizationRule>;

  /**
   * Gets the primary and secondary connection strings for the namespace.
   */
  listKeys is DisasterRecoveryConfigOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;
}
@armResourceOperations
interface QueueOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SBNamespace,
          KeyName = "namespaceName",
          SegmentName = "namespaces",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = SBQueue,
          KeyName = "queueName",
          SegmentName = "queues",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SBAuthorizationRule,
        KeyName = "authorizationRuleName",
        SegmentName = "authorizationRules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Queues {
  /**
   * Gets an authorization rule for a queue by rule name.
   */
  getAuthorizationRule is QueueOps.Read<SBAuthorizationRule>;

  /**
   * Creates an authorization rule for a queue.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdateAuthorizationRule is QueueOps.CreateOrUpdateSync<
    SBAuthorizationRule,
    Response = ArmResourceUpdatedResponse<SBAuthorizationRule>
  >;

  /**
   * Deletes a queue authorization rule.
   */
  deleteAuthorizationRule is QueueOps.DeleteSync<SBAuthorizationRule>;

  /**
   * Gets all authorization rules for a queue.
   */
  listAuthorizationRules is QueueOps.List<SBAuthorizationRule>;

  /**
   * Primary and secondary connection strings to the queue.
   */
  @action("ListKeys")
  listKeys is QueueOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;

  /**
   * Regenerates the primary or secondary connection strings to the queue.
   */
  regenerateKeys is QueueOps.ActionSync<
    SBAuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>
  >;
}
@armResourceOperations
interface TopicOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SBNamespace,
          KeyName = "namespaceName",
          SegmentName = "namespaces",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = SBTopic,
          KeyName = "topicName",
          SegmentName = "topics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SBAuthorizationRule,
        KeyName = "authorizationRuleName",
        SegmentName = "authorizationRules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Topics {
  /**
   * Returns the specified authorization rule.
   */
  getAuthorizationRule is TopicOps.Read<SBAuthorizationRule>;

  /**
   * Creates an authorization rule for the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdateAuthorizationRule is TopicOps.CreateOrUpdateSync<
    SBAuthorizationRule,
    Response = ArmResourceUpdatedResponse<SBAuthorizationRule>
  >;

  /**
   * Deletes a topic authorization rule.
   */
  deleteAuthorizationRule is TopicOps.DeleteSync<SBAuthorizationRule>;

  /**
   * Gets authorization rules for a topic.
   */
  listAuthorizationRules is TopicOps.List<SBAuthorizationRule>;

  /**
   * Gets the primary and secondary connection strings for the topic.
   */
  @action("ListKeys")
  listKeys is TopicOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>
  >;

  /**
   * Regenerates primary or secondary connection strings for the topic.
   */
  regenerateKeys is TopicOps.ActionSync<
    SBAuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>
  >;
}

@@maxLength(SBAuthorizationRule.name, 50);
@@minLength(SBAuthorizationRule.name, 1);
@@doc(SBAuthorizationRule.name, "The authorization rule name.");
@@doc(SBAuthorizationRule.properties, "AuthorizationRule properties.");
@@doc(SBAuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access authorization rule."
);
@@doc(SBAuthorizationRules.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate the authorization rule."
);
@@doc(Queues.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access authorization rule."
);
@@doc(Queues.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate the authorization rule."
);
@@doc(Topics.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access authorization rule."
);
@@doc(Topics.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate the authorization rule."
);
