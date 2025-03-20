import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.EventHub;

interface DisasterRecoveryConfigsOperations {
  /**
   * Gets a list of authorization rules for a Namespace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules")
  @get
  listAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
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
    ResourceListResult<EventHubsAuthorizationRule>
  >;

  /**
   * Gets an AuthorizationRule for a Namespace by rule name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}")
  @get
  getAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
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
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    EventHubsAuthorizationRule
  >;

  /**
   * Gets the primary and secondary connection strings for the Namespace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  listKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
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
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    EventHubsAccessKeys
  >;
}

interface EventHubsOperations {
  /**
   * Gets the authorization rules for an Event Hub.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules")
  @get
  listAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Event Hub name
       */
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<EventHubsAuthorizationRule>
  >;

  /**
   * Creates or updates an AuthorizationRule for the specified Event Hub. Creation/update of the AuthorizationRule will take a few seconds to take effect.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @put
  createOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Event Hub name
       */
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The shared access AuthorizationRule.
       */
      @body
      parameters: EventHubsAuthorizationRule;
    },
    EventHubsAuthorizationRule
  >;

  /**
   * Gets an AuthorizationRule for an Event Hub by rule name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @get
  getAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Event Hub name
       */
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    EventHubsAuthorizationRule
  >;

  /**
   * Deletes an Event Hub AuthorizationRule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @delete
  deleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Event Hub name
       */
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      /**
       * The authorization rule name.
       */
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
   * Gets the ACS and SAS connection strings for the Event Hub.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  listKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Event Hub name
       */
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    EventHubsAccessKeys
  >;

  /**
   * Regenerates the ACS and SAS connection strings for the Event Hub.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  regenerateKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * The Event Hub name
       */
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Parameters supplied to regenerate the AuthorizationRule Keys (PrimaryKey/SecondaryKey).
       */
      @body
      parameters: EventHubsRegenerateAccessKeyContent;
    },
    EventHubsAccessKeys
  >;
}
