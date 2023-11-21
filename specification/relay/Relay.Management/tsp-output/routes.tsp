import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace RelayAPI;

interface NamespacesOperations {
  @doc("Authorization rules for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRuleListResult
  >;

  @doc("Creates or updates an authorization rule for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The authorization rule parameters.")
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  @doc("Deletes a namespace authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Authorization rule for a namespace by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  @doc("Primary and secondary connection strings to the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Regenerates the primary or secondary connection strings to the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Check the specified namespace name availability.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Relay/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters to check availability of the specified namespace name.")
      @body
      parameters: CheckNameAvailability;
    },
    CheckNameAvailabilityResult
  >;

  @doc("""
Lists all the available namespaces within the subscription regardless of the
resourceGroups.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Relay/namespaces")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelayNamespaceListResult
  >;

  @doc("Lists all the available namespaces within the ResourceGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelayNamespaceListResult
  >;

  @doc("Create Azure Relay namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a namespace resource.")
      @body
      parameters: RelayNamespace;
    },
    RelayNamespace
  >;

  @doc("""
Deletes an existing namespace. This operation also removes all associated
resources under the namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns the description for the specified namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelayNamespace
  >;

  @doc("""
Creates or updates a namespace. Once created, this namespace's resource
manifest is immutable. This operation is idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters for updating a namespace resource.")
      @body
      parameters: RelayUpdateParameters;
    },
    RelayNamespace
  >;

  @doc("Create or update NetworkRuleSet for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/networkRuleSets/default")
  @put
  CreateOrUpdateNetworkRuleSet is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The Namespace IpFilterRule.")
      @body
      parameters: NetworkRuleSet;
    },
    NetworkRuleSet
  >;

  @doc("Gets NetworkRuleSet for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/networkRuleSets/default")
  @get
  GetNetworkRuleSet is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NetworkRuleSet
  >;
}

interface HybridConnectionsOperations {
  @doc("Authorization rules for a hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("""
Regenerates the primary or secondary connection strings to the hybrid
connection.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Lists the hybrid connection within the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections")
  @get
  ListByNamespace is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    HybridConnectionListResult
  >;

  @doc("Creates or updates a service hybrid connection. This operation is idempotent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a hybrid connection.")
      @body
      parameters: HybridConnection;
    },
    HybridConnection
  >;

  @doc("Deletes a hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns the description for the specified hybrid connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The hybrid connection name.")
      @path
      hybridConnectionName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;
}

interface WCFRelaysOperations {
  @doc("Authorization rules for a WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Lists the WCF relays within the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays")
  @get
  ListByNamespace is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    WcfRelaysListResult
  >;

  @doc("Creates or updates a WCF relay. This operation is idempotent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a WCF relay.")
      @body
      parameters: WcfRelay;
    },
    WcfRelay
  >;

  @doc("Deletes a WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns the description for the specified WCF relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The relay name.")
      @path
      relayName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    WcfRelay | void
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The PrivateEndpointConnection name")
      @path
      privateEndpointConnectionName: string;

      @doc("""
Parameters supplied to update Status of PrivateEndPoint Connection to namespace
resource.
""")
      @body
      parameters: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Deletes an existing namespace. This operation also removes all associated
resources under the namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The PrivateEndpointConnection name")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("Gets a description for the specified Private Endpoint Connection name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The PrivateEndpointConnection name")
      @path
      privateEndpointConnectionName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnection
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Gets a description for the specified Private Endpoint Connection name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateLinkResources/{privateLinkResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The PrivateLinkResource name")
      @path
      privateLinkResourceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateLinkResource
  >;

  @doc("Gets lists of resources that supports Privatelinks.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesListResult
  >;
}

interface OperationsOperations {
  @doc("Lists all available Relay REST API operations.")
  @route("/providers/Microsoft.Relay/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
