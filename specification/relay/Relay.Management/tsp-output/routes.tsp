import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Relay;

interface HybridConnectionsOperations {
  /**
   * Authorization rules for a hybrid connection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules")
  @get
  listAuthorizationRules is Azure.Core.Foundations.Operation<
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
       * The hybrid connection name.
       */
      @minLength(1)
      @path
      hybridConnectionName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<AuthorizationRule>
  >;

  /**
   * Creates or updates an authorization rule for a hybrid connection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}")
  @put
  createOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
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
       * The hybrid connection name.
       */
      @minLength(1)
      @path
      hybridConnectionName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The authorization rule parameters.
       */
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  /**
   * Deletes a hybrid connection authorization rule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}")
  @delete
  deleteAuthorizationRule is Azure.Core.Foundations.Operation<
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
       * The hybrid connection name.
       */
      @minLength(1)
      @path
      hybridConnectionName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Hybrid connection authorization rule for a hybrid connection by name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}")
  @get
  getAuthorizationRule is Azure.Core.Foundations.Operation<
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
       * The hybrid connection name.
       */
      @minLength(1)
      @path
      hybridConnectionName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  /**
   * Primary and secondary connection strings to the hybrid connection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/listKeys")
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
       * The hybrid connection name.
       */
      @minLength(1)
      @path
      hybridConnectionName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  /**
   * Regenerates the primary or secondary connection strings to the hybrid connection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
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
       * The hybrid connection name.
       */
      @minLength(1)
      @path
      hybridConnectionName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Parameters supplied to regenerate authorization rule.
       */
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;
}

interface WCFRelaysOperations {
  /**
   * Authorization rules for a WCF relay.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules")
  @get
  listAuthorizationRules is Azure.Core.Foundations.Operation<
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
       * The relay name.
       */
      @minLength(1)
      @path
      relayName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<AuthorizationRule>
  >;

  /**
   * Creates or updates an authorization rule for a WCF relay.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}")
  @put
  createOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
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
       * The relay name.
       */
      @minLength(1)
      @path
      relayName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The authorization rule parameters.
       */
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  /**
   * Deletes a WCF relay authorization rule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}")
  @delete
  deleteAuthorizationRule is Azure.Core.Foundations.Operation<
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
       * The relay name.
       */
      @minLength(1)
      @path
      relayName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Get authorizationRule for a WCF relay by name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}")
  @get
  getAuthorizationRule is Azure.Core.Foundations.Operation<
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
       * The relay name.
       */
      @minLength(1)
      @path
      relayName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  /**
   * Primary and secondary connection strings to the WCF relay.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/listKeys")
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
       * The relay name.
       */
      @minLength(1)
      @path
      relayName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  /**
   * Regenerates the primary or secondary connection strings to the WCF relay.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
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
       * The relay name.
       */
      @minLength(1)
      @path
      relayName: string;

      /**
       * The authorization rule name.
       */
      @minLength(1)
      @path
      authorizationRuleName: string;

      /**
       * Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Parameters supplied to regenerate authorization rule.
       */
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;
}
