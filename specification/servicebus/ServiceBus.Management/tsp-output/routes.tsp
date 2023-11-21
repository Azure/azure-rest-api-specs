import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ServiceBusManagementClient;

interface NamespacesOperations {
  @doc("""
Gets all the available namespaces within the subscription, irrespective of the
resource groups.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceBus/namespaces")
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
    SBNamespaceListResult
  >;

  @doc("Gets the available namespaces within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBNamespaceListResult
  >;

  @doc("""
Creates or updates a service namespace. Once created, this namespace's resource
manifest is immutable. This operation is idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a namespace resource.")
      @body
      parameters: SBNamespace;
    },
    SBNamespace | void
  >;

  @doc("""
Deletes an existing namespace. This operation also removes all associated
resources under the namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a description for the specified namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBNamespace
  >;

  @doc("""
Updates a service namespace. Once created, this namespace's resource manifest
is immutable. This operation is idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to update a namespace resource.")
      @body
      parameters: SBNamespaceUpdateParameters;
    },
    SBNamespace | void
  >;

  @doc("Create or update NetworkRuleSet for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/networkRuleSets/default")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/networkRuleSets/default")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NetworkRuleSet
  >;

  @doc("Gets list of NetworkRuleSet for a Namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/networkRuleSets")
  @get
  ListNetworkRuleSets is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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

  @doc("Gets the authorization rules for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/AuthorizationRules")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBAuthorizationRuleListResult
  >;

  @doc("Creates or updates an authorization rule for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: SBAuthorizationRule;
    },
    SBAuthorizationRule
  >;

  @doc("Deletes a namespace authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an authorization rule for a namespace by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBAuthorizationRule
  >;

  @doc("Gets the primary and secondary connection strings for the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}/listKeys")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Regenerates the primary or secondary connection strings for the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}/regenerateKeys")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Check the give namespace name availability.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceBus/CheckNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters to check availability of the given namespace name")
      @body
      parameters: CheckNameAvailability;
    },
    CheckNameAvailabilityResult
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateEndpointConnections")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
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

  @doc("Deletes an existing Private Endpoint Connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
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

  @doc("Gets a description for the specified Private Endpoint Connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateLinkResources")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesListResult
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available ServiceBus REST API operations.")
  @route("/providers/Microsoft.ServiceBus/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface DisasterRecoveryConfigsOperations {
  @doc("Gets all Alias(Disaster Recovery configurations)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ArmDisasterRecoveryListResult
  >;

  @doc("Creates or updates a new Alias(Disaster Recovery configuration)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
    ArmDisasterRecovery | void
  >;

  @doc("Deletes an Alias(Disaster Recovery configuration)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing")
  @post
  BreakPairing is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover")
  @post
  FailOver is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
      parameters: FailoverProperties;
    },
    void
  >;

  @doc("Gets the authorization rules for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
    SBAuthorizationRuleListResult
  >;

  @doc("Gets an authorization rule for a namespace by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
    SBAuthorizationRule
  >;

  @doc("Gets the primary and secondary connection strings for the namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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

  @doc("Check the give namespace name availability.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/CheckNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters to check availability of the given namespace name")
      @body
      parameters: CheckNameAvailability;
    },
    CheckNameAvailabilityResult
  >;
}

interface MigrationConfigsOperations {
  @doc("Gets all migrationConfigurations")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/migrationConfigurations")
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
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    MigrationConfigListResult
  >;

  @doc("""
Creates Migration configuration and starts migration of entities from Standard
to Premium namespace
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/migrationConfigurations/{configName}")
  @put
  CreateAndStartMigration is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The configuration name. Should always be \"$default\".")
      @path
      configName: MigrationConfigurationName;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters required to create Migration Configuration")
      @body
      parameters: MigrationConfigProperties;
    },
    MigrationConfigProperties | void
  >;

  @doc("Deletes a MigrationConfiguration")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/migrationConfigurations/{configName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The configuration name. Should always be \"$default\".")
      @path
      configName: MigrationConfigurationName;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Retrieves Migration Config")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/migrationConfigurations/{configName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The configuration name. Should always be \"$default\".")
      @path
      configName: MigrationConfigurationName;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    MigrationConfigProperties
  >;

  @doc("""
This operation Completes Migration of entities by pointing the connection
strings to Premium namespace and any entities created after the operation will
be under Premium Namespace. CompleteMigration operation will fail when entity
migration is in-progress.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/migrationConfigurations/{configName}/upgrade")
  @post
  CompleteMigration is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The configuration name. Should always be \"$default\".")
      @path
      configName: MigrationConfigurationName;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("This operation reverts Migration")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/migrationConfigurations/{configName}/revert")
  @post
  Revert is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The configuration name. Should always be \"$default\".")
      @path
      configName: MigrationConfigurationName;

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

interface QueuesOperations {
  @doc("Gets all authorization rules for a queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBAuthorizationRuleListResult
  >;

  @doc("Creates an authorization rule for a queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: SBAuthorizationRule;
    },
    SBAuthorizationRule
  >;

  @doc("Deletes a queue authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

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

  @doc("Gets an authorization rule for a queue by rule name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

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
    SBAuthorizationRule
  >;

  @doc("Primary and secondary connection strings to the queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}/ListKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

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

  @doc("Regenerates the primary or secondary connection strings to the queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Gets the queues within a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues")
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
    SBQueueListResult
  >;

  @doc("Creates or updates a Service Bus queue. This operation is idempotent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create or update a queue resource.")
      @body
      parameters: SBQueue;
    },
    SBQueue
  >;

  @doc("Deletes a queue from the specified namespace in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns a description for the specified queue.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The queue name.")
      @path
      queueName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBQueue
  >;
}

interface TopicsOperations {
  @doc("Gets authorization rules for a topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBAuthorizationRuleListResult
  >;

  @doc("Creates an authorization rule for the specified topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: SBAuthorizationRule;
    },
    SBAuthorizationRule
  >;

  @doc("Returns the specified authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

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
    SBAuthorizationRule
  >;

  @doc("Deletes a topic authorization rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

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

  @doc("Gets the primary and secondary connection strings for the topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}/ListKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

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

  @doc("Regenerates primary or secondary connection strings for the topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the authorization rule.")
      @body
      parameters: RegenerateAccessKeyParameters;
    },
    AccessKeys
  >;

  @doc("Gets all the topics in a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics")
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
    SBTopicListResult
  >;

  @doc("Creates a topic in the specified namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a topic resource.")
      @body
      parameters: SBTopic;
    },
    SBTopic
  >;

  @doc("Deletes a topic from the specified namespace and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns a description for the specified topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBTopic
  >;
}

interface RulesOperations {
  @doc("List all the rules within given topic-subscription")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}/rules")
  @get
  ListBySubscriptions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

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
    RuleListResult
  >;

  @doc("Creates a new rule and updates an existing rule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}/rules/{ruleName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

      @doc("The rule name.")
      @path
      ruleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a rule.")
      @body
      parameters: Rule;
    },
    Rule
  >;

  @doc("Deletes an existing rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}/rules/{ruleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

      @doc("The rule name.")
      @path
      ruleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Retrieves the description for the specified rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}/rules/{ruleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

      @doc("The rule name.")
      @path
      ruleName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    Rule
  >;
}

interface SubscriptionsOperations {
  @doc("List all the subscriptions under a specified topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions")
  @get
  ListByTopic is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

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
    SBSubscriptionListResult
  >;

  @doc("Creates a topic subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a subscription resource.")
      @body
      parameters: SBSubscription;
    },
    SBSubscription
  >;

  @doc("Deletes a subscription from the specified topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns a subscription description for the specified topic.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The topic name.")
      @path
      topicName: string;

      @doc("The subscription name.")
      @path
      subscriptionName: string;

      @doc("""
Subscription credentials that uniquely identify a Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SBSubscription
  >;
}
