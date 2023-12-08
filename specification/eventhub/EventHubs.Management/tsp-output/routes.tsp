import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.EventHubs;

interface DisasterRecoveryConfigsOperations {
  @doc("Gets a list of authorization rules for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
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
    AuthorizationRuleListResult
  >;

  @doc("Gets an AuthorizationRule for a Namespace by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
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
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    EventHubsAuthorizationRule
  >;

  @doc("Gets the primary and secondary connection strings for the Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
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
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    EventHubsAccessKeys
  >;
}

interface EventHubsOperations {
  @doc("Gets the authorization rules for an Event Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AuthorizationRuleListResult
  >;

  @doc("Creates or updates an AuthorizationRule for the specified Event Hub. Creation/update of the AuthorizationRule will take a few seconds to take effect.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The shared access AuthorizationRule.")
      @body
      parameters: EventHubsAuthorizationRule;
    },
    EventHubsAuthorizationRule
  >;

  @doc("Gets an AuthorizationRule for an Event Hub by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    EventHubsAuthorizationRule
  >;

  @doc("Deletes an Event Hub AuthorizationRule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets the ACS and SAS connection strings for the Event Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    EventHubsAccessKeys
  >;

  @doc("Regenerates the ACS and SAS connection strings for the Event Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @maxLength(256)
      @minLength(1)
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the AuthorizationRule Keys (PrimaryKey/SecondaryKey).")
      @body
      parameters: EventHubsRegenerateAccessKeyContent;
    },
    EventHubsAccessKeys
  >;
}
