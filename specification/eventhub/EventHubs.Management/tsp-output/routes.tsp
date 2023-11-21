import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace EventHubManagementClient;

interface ClustersOperations {
  @doc("""
List the quantity of available pre-provisioned Event Hubs Clusters, indexed by
Azure region.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.EventHub/availableClusterRegions")
  @get
  ListAvailableClusterRegion is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AvailableClustersList
  >;

  @doc("Lists the available Event Hubs Clusters within an ARM resource group")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.EventHub/clusters")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ClusterListResult
  >;

  @doc("Lists the available Event Hubs Clusters within an ARM resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;
    },
    ClusterListResult
  >;

  @doc("Gets the resource description of the specified Event Hubs Cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;
    },
    Cluster
  >;

  @doc("Creates or updates an instance of an Event Hubs Cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;

      @doc("Parameters for creating a eventhub cluster resource.")
      @body
      parameters: Cluster;
    },
    Cluster | void
  >;

  @doc("""
Modifies mutable properties on the Event Hubs Cluster. This operation is
idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;

      @doc("The properties of the Event Hubs Cluster which should be updated.")
      @body
      parameters: Cluster;
    },
    Cluster | void
  >;

  @doc("Deletes an existing Event Hubs Cluster. This operation is idempotent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;
    },
    void
  >;

  @doc("List all Event Hubs Namespace IDs in an Event Hubs Dedicated Cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/namespaces")
  @get
  ListNamespaces is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;
    },
    EHNamespaceIdListResult
  >;
}

interface NamespacesOperations {
  @doc("""
Lists all the available Namespaces within a subscription, irrespective of the
resource groups.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.EventHub/namespaces")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    EHNamespaceListResult
  >;

  @doc("Lists the available Namespaces within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    EHNamespaceListResult
  >;

  @doc("""
Creates or updates a namespace. Once created, this namespace's resource
manifest is immutable. This operation is idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters for creating a namespace resource.")
      @body
      parameters: EHNamespace;
    },
    EHNamespace | void
  >;

  @doc("""
Deletes an existing namespace. This operation also removes all associated
resources under the namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets the description of the specified namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    EHNamespace
  >;

  @doc("""
Creates or updates a namespace. Once created, this namespace's resource
manifest is immutable. This operation is idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters for updating a namespace resource.")
      @body
      parameters: EHNamespace;
    },
    EHNamespace | void
  >;

  @doc("Create or update NetworkRuleSet for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default")
  @put
  CreateOrUpdateNetworkRuleSet is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default")
  @get
  GetNetworkRuleSet is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NetworkRuleSet
  >;

  @doc("Gets NetworkRuleSet for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets")
  @get
  ListNetworkRuleSet is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NetworkRuleSetListResult
  >;

  @doc("Gets a list of authorization rules for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRuleListResult
  >;

  @doc("Creates or updates an AuthorizationRule for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access AuthorizationRule.")
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  @doc("Deletes an AuthorizationRule for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an AuthorizationRule for a Namespace by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  @doc("Gets the primary and secondary connection strings for the Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("""
Regenerates the primary or secondary connection strings for the specified
Namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters required to regenerate the connection string.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Check the give Namespace name availability.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.EventHub/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters to check availability of the given Namespace name")
      @body
      parameters: CheckNameAvailabilityParameter;
    },
    CheckNameAvailabilityResult
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The PrivateEndpointConnection name")
      @path
      privateEndpointConnectionName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnection
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Gets lists of resources that supports Privatelinks.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesListResult
  >;
}

interface NetworkSecurityPerimeterConfigurationOperations {
  @doc("Gets list of current NetworkSecurityPerimeterConfiguration for Namespace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NetworkSecurityPerimeterConfigurationList
  >;
}

interface NetworkSecurityPerimeterConfigurationsOperations {
  @doc("Refreshes any information about the association.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile")
  @post
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The ResourceAssociation Name")
      @path
      resourceAssociationName: string;
    },
    void
  >;
}

interface ConfigurationOperations {
  @doc("""
Replace all specified Event Hubs Cluster settings with those contained in the
request body. Leaves the settings not specified in the request body unmodified.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;

      @doc("Parameters for creating an Event Hubs Cluster resource.")
      @body
      parameters: ClusterQuotaConfigurationProperties;
    },
    ClusterQuotaConfigurationProperties | void
  >;

  @doc("""
Get all Event Hubs Cluster settings - a collection of key/value pairs which
represent the quotas and settings imposed on the cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @path
      clusterName: string;
    },
    ClusterQuotaConfigurationProperties
  >;
}

interface DisasterRecoveryConfigsOperations {
  @doc("Gets a list of authorization rules for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  @doc("Gets the primary and secondary connection strings for the Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Check the give Namespace name availability.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("Parameters to check availability of the given Alias name")
      @body
      parameters: CheckNameAvailabilityParameter;
    },
    CheckNameAvailabilityResult
  >;

  @doc("Gets all Alias(Disaster Recovery configurations)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ArmDisasterRecoveryListResult
  >;

  @doc("Creates or updates a new Alias(Disaster Recovery configuration)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters required to create an Alias(Disaster Recovery configuration)")
      @body
      parameters: ArmDisasterRecovery;
    },
    ArmDisasterRecovery
  >;

  @doc("Deletes an Alias(Disaster Recovery configuration)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Retrieves Alias(Disaster Recovery configuration) for primary or secondary
namespace
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ArmDisasterRecovery
  >;

  @doc("""
This operation disables the Disaster Recovery and stops replicating changes
from primary to secondary namespaces
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing")
  @post
  BreakPairing is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Invokes GEO DR failover and reconfigure the alias to point to the secondary
namespace
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover")
  @post
  FailOver is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Disaster Recovery configuration name")
      @path
      `alias`: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface EventHubsOperations {
  @doc("Gets the authorization rules for an Event Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRuleListResult
  >;

  @doc("""
Creates or updates an AuthorizationRule for the specified Event Hub.
Creation/update of the AuthorizationRule will take a few seconds to take
effect.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access AuthorizationRule.")
      @body
      parameters: AuthorizationRule;
    },
    AuthorizationRule
  >;

  @doc("Gets an AuthorizationRule for an Event Hub by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationRule
  >;

  @doc("Deletes an Event Hub AuthorizationRule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
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
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Regenerates the ACS and SAS connection strings for the Event Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied to regenerate the AuthorizationRule Keys
(PrimaryKey/SecondaryKey).
""")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Gets all the Event Hubs in a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs")
  @get
  ListByNamespace is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
Skip is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skip parameter that specifies a starting point to use
for subsequent calls.
""")
      @query
      $skip: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query
      $top: int32;
    },
    EventHubListResult
  >;

  @doc("Creates or updates a new Event Hub as a nested resource within a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create an Event Hub resource.")
      @body
      parameters: Eventhub;
    },
    Eventhub
  >;

  @doc("Deletes an Event Hub from the specified Namespace and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an Event Hubs description for the specified Event Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    Eventhub
  >;
}

interface ConsumerGroupsOperations {
  @doc("""
Creates or updates an Event Hubs consumer group as a nested resource within a
Namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The consumer group name")
      @path
      consumerGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create or update a consumer group resource.")
      @body
      parameters: ConsumerGroup;
    },
    ConsumerGroup
  >;

  @doc("Deletes a consumer group from the specified Event Hub and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The consumer group name")
      @path
      consumerGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a description for the specified consumer group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("The consumer group name")
      @path
      consumerGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ConsumerGroup
  >;

  @doc("""
Gets all the consumer groups in a Namespace. An empty feed is returned if no
consumer group exists in the Namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups")
  @get
  ListByEventHub is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Event Hub name")
      @path
      eventHubName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
Skip is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skip parameter that specifies a starting point to use
for subsequent calls.
""")
      @query
      $skip: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query
      $top: int32;
    },
    ConsumerGroupListResult
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available Event Hub REST API operations.")
  @route("/providers/Microsoft.EventHub/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface SchemaRegistryOperations {
  @doc("Gets all the Schema Groups in a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/schemagroups")
  @get
  ListByNamespace is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
Skip is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skip parameter that specifies a starting point to use
for subsequent calls.
""")
      @query
      $skip: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query
      $top: int32;
    },
    SchemaGroupListResult
  >;

  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Schema Group name ")
      @path
      schemaGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create an Event Hub resource.")
      @body
      parameters: SchemaGroup;
    },
    SchemaGroup
  >;

  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Schema Group name ")
      @path
      schemaGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Schema Group name ")
      @path
      schemaGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SchemaGroup
  >;
}

interface ApplicationGroupOperations {
  @doc("Gets a list of application groups for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/applicationGroups")
  @get
  ListByNamespace is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ApplicationGroupListResult
  >;

  @doc("Creates or updates an ApplicationGroup for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}")
  @put
  CreateOrUpdateApplicationGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Application Group name ")
      @path
      applicationGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The ApplicationGroup.")
      @body
      parameters: ApplicationGroup;
    },
    ApplicationGroup
  >;

  @doc("Deletes an ApplicationGroup for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Application Group name ")
      @path
      applicationGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an ApplicationGroup for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @path
      namespaceName: string;

      @doc("The Application Group name ")
      @path
      applicationGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ApplicationGroup
  >;
}
