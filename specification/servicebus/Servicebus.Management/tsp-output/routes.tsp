import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ServiceBus;

interface QueueAuthorizationRulesOperations {
  @doc("Gets all authorization rules for a queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The queue name.")
      @minLength(1)
      @path
      queueName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServiceBusAuthorizationRule>
  >;

  @doc("Creates an authorization rule for a queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The queue name.")
      @minLength(1)
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: ServiceBusAuthorizationRule;
    },
    ServiceBusAuthorizationRule
  >;

  @doc("Deletes a queue authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The queue name.")
      @minLength(1)
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an authorization rule for a queue by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The queue name.")
      @minLength(1)
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ServiceBusAuthorizationRule
  >;

  @doc("Primary and secondary connection strings to the queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}/ListKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The queue name.")
      @minLength(1)
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ServiceBusAccessKeys
  >;

  @doc("Regenerates the primary or secondary connection strings to the queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The queue name.")
      @minLength(1)
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the authorization rule.")
      @body
      parameters: ServiceBusRegenerateAccessKeyContent;
    },
    ServiceBusAccessKeys
  >;
}

interface TopicAuthorizationRulesOperations {
  @doc("Gets authorization rules for a topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The topic name.")
      @minLength(1)
      @path
      topicName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServiceBusAuthorizationRule>
  >;

  @doc("Creates an authorization rule for the specified topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The topic name.")
      @minLength(1)
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: ServiceBusAuthorizationRule;
    },
    ServiceBusAuthorizationRule
  >;

  @doc("Returns the specified authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The topic name.")
      @minLength(1)
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ServiceBusAuthorizationRule
  >;

  @doc("Deletes a topic authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The topic name.")
      @minLength(1)
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets the primary and secondary connection strings for the topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}/ListKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The topic name.")
      @minLength(1)
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ServiceBusAccessKeys
  >;

  @doc("Regenerates primary or secondary connection strings for the topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The topic name.")
      @minLength(1)
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the authorization rule.")
      @body
      parameters: ServiceBusRegenerateAccessKeyContent;
    },
    ServiceBusAccessKeys
  >;
}

interface DisasterRecoveryAuthorizationRulesOperations {
  @doc("Gets the authorization rules for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @maxLength(50)
      @minLength(1)
      @path
      `alias`: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServiceBusAuthorizationRule>
  >;

  @doc("Gets an authorization rule for a namespace by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @maxLength(50)
      @minLength(1)
      @path
      `alias`: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ServiceBusAuthorizationRule
  >;

  @doc("Gets the primary and secondary connection strings for the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @maxLength(50)
      @minLength(1)
      @path
      `alias`: string;

      @doc("The authorization rule name.")
      @maxLength(50)
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ServiceBusAccessKeys
  >;
}