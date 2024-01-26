import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ServiceBus;

interface QueueAuthorizationRulesOperations {
  /**
   * Gets all authorization rules for a queue.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The queue name.
       */
      @minLength(1)
      @path
      queueName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServiceBusAuthorizationRule>
  >;

  /**
   * Creates an authorization rule for a queue.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The queue name.
       */
      @minLength(1)
      @path
      queueName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The shared access authorization rule.
       */
      @body
      parameters: ServiceBusAuthorizationRule;
    },
    ServiceBusAuthorizationRule
  >;

  /**
   * Deletes a queue authorization rule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The queue name.
       */
      @minLength(1)
      @path
      queueName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Gets an authorization rule for a queue by rule name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The queue name.
       */
      @minLength(1)
      @path
      queueName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ServiceBusAuthorizationRule
  >;

  /**
   * Primary and secondary connection strings to the queue.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}/ListKeys")
  @post
  listKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The queue name.
       */
      @minLength(1)
      @path
      queueName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ServiceBusAccessKeys
  >;

  /**
   * Regenerates the primary or secondary connection strings to the queue.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  regenerateKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The queue name.
       */
      @minLength(1)
      @path
      queueName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Parameters supplied to regenerate the authorization rule.
       */
      @body
      parameters: ServiceBusRegenerateAccessKeyContent;
    },
    ServiceBusAccessKeys
  >;
}

interface TopicAuthorizationRulesOperations {
  /**
   * Gets authorization rules for a topic.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The topic name.
       */
      @minLength(1)
      @path
      topicName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServiceBusAuthorizationRule>
  >;

  /**
   * Creates an authorization rule for the specified topic.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The topic name.
       */
      @minLength(1)
      @path
      topicName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The shared access authorization rule.
       */
      @body
      parameters: ServiceBusAuthorizationRule;
    },
    ServiceBusAuthorizationRule
  >;

  /**
   * Returns the specified authorization rule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The topic name.
       */
      @minLength(1)
      @path
      topicName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ServiceBusAuthorizationRule
  >;

  /**
   * Deletes a topic authorization rule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The topic name.
       */
      @minLength(1)
      @path
      topicName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Gets the primary and secondary connection strings for the topic.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}/ListKeys")
  @post
  listKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The topic name.
       */
      @minLength(1)
      @path
      topicName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ServiceBusAccessKeys
  >;

  /**
   * Regenerates primary or secondary connection strings for the topic.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  regenerateKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The topic name.
       */
      @minLength(1)
      @path
      topicName: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Parameters supplied to regenerate the authorization rule.
       */
      @body
      parameters: ServiceBusRegenerateAccessKeyContent;
    },
    ServiceBusAccessKeys
  >;
}

interface DisasterRecoveryAuthorizationRulesOperations {
  /**
   * Gets the authorization rules for a namespace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Disaster Recovery configuration name
       */
      @maxLength(50)
      @minLength(1)
      @path
      `alias`: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServiceBusAuthorizationRule>
  >;

  /**
   * Gets an authorization rule for a namespace by rule name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Disaster Recovery configuration name
       */
      @maxLength(50)
      @minLength(1)
      @path
      `alias`: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ServiceBusAuthorizationRule
  >;

  /**
   * Gets the primary and secondary connection strings for the namespace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  listKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Disaster Recovery configuration name
       */
      @maxLength(50)
      @minLength(1)
      @path
      `alias`: string;

      /**
       * The authorization rule name.
       */
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ServiceBusAccessKeys
  >;
}
