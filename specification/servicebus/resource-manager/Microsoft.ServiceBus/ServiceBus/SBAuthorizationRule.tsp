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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SBNamespace)
model SBAuthorizationRule
  is Azure.ResourceManager.ProxyResource<SBAuthorizationRuleProperties> {
  ...ResourceNameParameter<
    Resource = SBAuthorizationRule,
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SBAuthorizationRuleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The namespace name
         */
        @path
        @segment("namespaces")
        @minLength(6)
        @maxLength(50)
        namespaceName: string,
      },
      {
        /**
         * The authorization rule name.
         */
        @path
        @segment("AuthorizationRules")
        @minLength(1)
        @maxLength(50)
        authorizationRuleName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SBAuthorizationRules {
  /**
   * Gets an authorization rule for a namespace by rule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639392.aspx")
  getAuthorizationRule is SBAuthorizationRuleOps.Read<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an authorization rule for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639410.aspx")
  createOrUpdateAuthorizationRule is SBAuthorizationRuleOps.CreateOrUpdateSync<
    SBAuthorizationRule,
    Response = ArmResourceUpdatedResponse<SBAuthorizationRule>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes a namespace authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639417.aspx")
  deleteAuthorizationRule is SBAuthorizationRuleOps.DeleteSync<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the authorization rules for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639376.aspx")
  listAuthorizationRules is SBAuthorizationRuleOps.List<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the primary and secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639398.aspx")
  listKeys is SBAuthorizationRuleOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Regenerates the primary or secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt718977.aspx")
  regenerateKeys is SBAuthorizationRuleOps.ActionSync<
    SBAuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
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

        /**
         * The namespace name
         */
        @path
        @segment("namespaces")
        @minLength(6)
        @maxLength(50)
        namespaceName: string,

        /**
         * The Disaster Recovery configuration name
         */
        @path
        @segment("disasterRecoveryConfigs")
        @minLength(1)
        @maxLength(50)
        `alias`: string,
      },
      {
        /**
         * The authorization rule name.
         */
        @path
        @segment("authorizationRules")
        @minLength(1)
        @maxLength(50)
        authorizationRuleName: string,
      }
    > {}

@armResourceOperations
interface DisasterRecoveryConfigs {
  /**
   * Gets an authorization rule for a namespace by rule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639392.aspx")
  getAuthorizationRule is DisasterRecoveryConfigOps.Read<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the authorization rules for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639376.aspx")
  listAuthorizationRules is DisasterRecoveryConfigOps.List<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the primary and secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639398.aspx")
  listKeys is DisasterRecoveryConfigOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
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

        /**
         * The namespace name
         */
        @path
        @segment("namespaces")
        @minLength(6)
        @maxLength(50)
        namespaceName: string,

        /**
         * The queue name.
         */
        @path
        @segment("queues")
        @minLength(1)
        queueName: string,
      },
      {
        /**
         * The authorization rule name.
         */
        @path
        @segment("authorizationRules")
        @minLength(1)
        @maxLength(50)
        authorizationRuleName: string,
      }
    > {}

@armResourceOperations
interface Queues {
  /**
   * Gets an authorization rule for a queue by rule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt705611.aspx")
  getAuthorizationRule is QueueOps.Read<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates an authorization rule for a queue.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateAuthorizationRule is QueueOps.CreateOrUpdateSync<
    SBAuthorizationRule,
    Response = ArmResourceUpdatedResponse<SBAuthorizationRule>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes a queue authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt705609.aspx")
  deleteAuthorizationRule is QueueOps.DeleteSync<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets all authorization rules for a queue.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt705607.aspx")
  listAuthorizationRules is QueueOps.List<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Primary and secondary connection strings to the queue.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("ListKeys")
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt705608.aspx")
  listKeys is QueueOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Regenerates the primary or secondary connection strings to the queue.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt705606.aspx")
  regenerateKeys is QueueOps.ActionSync<
    SBAuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
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

        /**
         * The namespace name
         */
        @path
        @segment("namespaces")
        @minLength(6)
        @maxLength(50)
        namespaceName: string,

        /**
         * The topic name.
         */
        @path
        @segment("topics")
        @minLength(1)
        topicName: string,
      },
      {
        /**
         * The authorization rule name.
         */
        @path
        @segment("authorizationRules")
        @minLength(1)
        @maxLength(50)
        authorizationRuleName: string,
      }
    > {}

@armResourceOperations
interface Topics {
  /**
   * Returns the specified authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt720676.aspx")
  getAuthorizationRule is TopicOps.Read<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates an authorization rule for the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt720678.aspx")
  createOrUpdateAuthorizationRule is TopicOps.CreateOrUpdateSync<
    SBAuthorizationRule,
    Response = ArmResourceUpdatedResponse<SBAuthorizationRule>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes a topic authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt720681.aspx")
  deleteAuthorizationRule is TopicOps.DeleteSync<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets authorization rules for a topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt720681.aspx")
  listAuthorizationRules is TopicOps.List<
    SBAuthorizationRule,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets the primary and secondary connection strings for the topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("ListKeys")
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt720677.aspx")
  listKeys is TopicOps.ActionSync<
    SBAuthorizationRule,
    void,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Regenerates primary or secondary connection strings for the topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt720679.aspx")
  regenerateKeys is TopicOps.ActionSync<
    SBAuthorizationRule,
    RegenerateAccessKeyParameters,
    ArmResponse<AccessKeys>,
    OverrideErrorType = ErrorResponse
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
