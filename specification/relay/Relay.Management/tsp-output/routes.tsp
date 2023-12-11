import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.Relay;

interface HybridConnectionsOperations {
  @doc("Authorization rules for a hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
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

      @doc("The hybrid connection name.")
      @minLength(1)
      @path
      hybridConnectionName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AuthorizationRuleListResult
  >;

  @doc("Creates or updates an authorization rule for a hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
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

      @doc("The hybrid connection name.")
      @minLength(1)
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The authorization rule parameters.")
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  @doc("Deletes a hybrid connection authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
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

      @doc("The hybrid connection name.")
      @minLength(1)
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Hybrid connection authorization rule for a hybrid connection by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
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

      @doc("The hybrid connection name.")
      @minLength(1)
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  @doc("Primary and secondary connection strings to the hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/listKeys")
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

      @doc("The hybrid connection name.")
      @minLength(1)
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Regenerates the primary or secondary connection strings to the hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
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

      @doc("The hybrid connection name.")
      @minLength(1)
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;
}

interface WCFRelaysOperations {
  @doc("Authorization rules for a WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
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

      @doc("The relay name.")
      @minLength(1)
      @path
      relayName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AuthorizationRuleListResult
  >;

  @doc("Creates or updates an authorization rule for a WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
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

      @doc("The relay name.")
      @minLength(1)
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The authorization rule parameters.")
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  @doc("Deletes a WCF relay authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
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

      @doc("The relay name.")
      @minLength(1)
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Get authorizationRule for a WCF relay by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
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

      @doc("The relay name.")
      @minLength(1)
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  @doc("Primary and secondary connection strings to the WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/listKeys")
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

      @doc("The relay name.")
      @minLength(1)
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Regenerates the primary or secondary connection strings to the WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
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

      @doc("The relay name.")
      @minLength(1)
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @minLength(1)
      @path
      authorizationRuleName: string;

      @doc("Subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;
}
