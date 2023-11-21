import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace CustomerInsightsManagementClient;

interface OperationsOperations {
  @doc("Lists all of the available Customer Insights REST API operations.")
  @route("/providers/Microsoft.CustomerInsights/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface HubsOperations {
  @doc("Creates a hub, or updates an existing hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate Hub operation.")
      @body
      parameters: Hub;
    },
    Hub
  >;

  @doc("Updates a Hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update Hub operation.")
      @body
      parameters: Hub;
    },
    Hub
  >;

  @doc("Deletes the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets information about the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    Hub
  >;

  @doc("Gets all the hubs in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    HubListResult
  >;

  @doc("Gets all hubs in the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CustomerInsights/hubs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    HubListResult
  >;
}

interface ProfilesOperations {
  @doc("Creates a profile within a Hub, or updates an existing profile.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles/{profileName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the profile.")
      @path
      profileName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create/delete Profile type operation")
      @body
      parameters: ProfileResourceFormat;
    },
    ProfileResourceFormat | void
  >;

  @doc("Gets information about the specified profile.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles/{profileName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the profile.")
      @path
      profileName: string;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query
      `locale-code`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ProfileResourceFormat
  >;

  @doc("Deletes a profile within a hub")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles/{profileName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the profile.")
      @path
      profileName: string;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query
      `locale-code`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all profile in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query
      `locale-code`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ProfileListResult
  >;

  @doc("""
Gets the KPIs that enrich the profile Type identified by the supplied name.
Enrichment happens through participants of the Interaction on an Interaction
KPI and through Relationships for Profile KPIs.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles/{profileName}/getEnrichingKpis")
  @post
  GetEnrichingKpis is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the profile.")
      @path
      profileName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface InteractionsOperations {
  @doc("Creates an interaction or updates an existing interaction within a hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/interactions/{interactionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the interaction.")
      @path
      interactionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate Interaction operation.")
      @body
      parameters: InteractionResourceFormat;
    },
    InteractionResourceFormat | void
  >;

  @doc("Gets information about the specified interaction.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/interactions/{interactionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the interaction.")
      @path
      interactionName: string;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query
      `locale-code`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    InteractionResourceFormat
  >;

  @doc("Gets all interactions in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/interactions")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query
      `locale-code`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    InteractionListResult
  >;

  @doc("Suggests relationships to create relationship links.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/interactions/{interactionName}/suggestRelationshipLinks")
  @post
  SuggestRelationshipLinks is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the interaction.")
      @path
      interactionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SuggestRelationshipLinksResponse
  >;
}

interface RelationshipsOperations {
  @doc("Creates a relationship or updates an existing relationship within a hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationships/{relationshipName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Relationship.")
      @path
      relationshipName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate Relationship operation.")
      @body
      parameters: RelationshipResourceFormat;
    },
    RelationshipResourceFormat | void
  >;

  @doc("Gets information about the specified relationship.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationships/{relationshipName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the relationship.")
      @path
      relationshipName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelationshipResourceFormat
  >;

  @doc("Deletes a relationship within a hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationships/{relationshipName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the relationship.")
      @path
      relationshipName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all relationships in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationships")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelationshipListResult
  >;
}

interface RelationshipLinksOperations {
  @doc("""
Creates a relationship link or updates an existing relationship link within a
hub.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationshipLinks/{relationshipLinkName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the relationship link.")
      @path
      relationshipLinkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate relationship link operation.")
      @body
      parameters: RelationshipLinkResourceFormat;
    },
    RelationshipLinkResourceFormat | void
  >;

  @doc("Gets information about the specified relationship Link.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationshipLinks/{relationshipLinkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the relationship link.")
      @path
      relationshipLinkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelationshipLinkResourceFormat
  >;

  @doc("Deletes a relationship link within a hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationshipLinks/{relationshipLinkName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the relationship.")
      @path
      relationshipLinkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all relationship links in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationshipLinks")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RelationshipLinkListResult
  >;
}

interface AuthorizationPoliciesOperations {
  @doc("Creates an authorization policy or updates an existing authorization policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/authorizationPolicies/{authorizationPolicyName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the policy.")
      @path
      authorizationPolicyName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate authorization policy operation.")
      @body
      parameters: AuthorizationPolicyResourceFormat;
    },
    AuthorizationPolicyResourceFormat
  >;

  @doc("Gets an authorization policy in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/authorizationPolicies/{authorizationPolicyName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the policy.")
      @path
      authorizationPolicyName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationPolicyResourceFormat
  >;

  @doc("Gets all the authorization policies in a specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/authorizationPolicies")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationPolicyListResult
  >;

  @doc("Regenerates the primary policy key of the specified authorization policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/authorizationPolicies/{authorizationPolicyName}/regeneratePrimaryKey")
  @post
  RegeneratePrimaryKey is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the policy.")
      @path
      authorizationPolicyName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationPolicy
  >;

  @doc("Regenerates the secondary policy key of the specified authorization policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/authorizationPolicies/{authorizationPolicyName}/regenerateSecondaryKey")
  @post
  RegenerateSecondaryKey is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the policy.")
      @path
      authorizationPolicyName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AuthorizationPolicy
  >;
}

interface ConnectorsOperations {
  @doc("Creates a connector or updates an existing connector in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate Connector operation.")
      @body
      parameters: ConnectorResourceFormat;
    },
    ConnectorResourceFormat | void
  >;

  @doc("Gets a connector in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ConnectorResourceFormat
  >;

  @doc("Deletes a connector in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all the connectors in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ConnectorListResult
  >;
}

interface ConnectorMappingsOperations {
  @doc("""
Creates a connector mapping or updates an existing connector mapping in the
connector.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}/mappings/{mappingName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("The name of the connector mapping.")
      @path
      mappingName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate Connector Mapping operation.")
      @body
      parameters: ConnectorMappingResourceFormat;
    },
    ConnectorMappingResourceFormat
  >;

  @doc("Gets a connector mapping in the connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}/mappings/{mappingName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("The name of the connector mapping.")
      @path
      mappingName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ConnectorMappingResourceFormat
  >;

  @doc("Deletes a connector mapping in the connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}/mappings/{mappingName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("The name of the connector mapping.")
      @path
      mappingName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all the connector mappings in the specified connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}/mappings")
  @get
  ListByConnector is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the connector.")
      @path
      connectorName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ConnectorMappingListResult
  >;
}

interface KpiOperations {
  @doc("Creates a KPI or updates an existing KPI in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/kpi/{kpiName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the KPI.")
      @path
      kpiName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create/update KPI operation.")
      @body
      parameters: KpiResourceFormat;
    },
    KpiResourceFormat | void
  >;

  @doc("Gets a KPI in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/kpi/{kpiName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the KPI.")
      @path
      kpiName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    KpiResourceFormat
  >;

  @doc("Deletes a KPI in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/kpi/{kpiName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the KPI.")
      @path
      kpiName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Reprocesses the Kpi values of the specified KPI.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/kpi/{kpiName}/reprocess")
  @post
  Reprocess is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the KPI.")
      @path
      kpiName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all the KPIs in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/kpi")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    KpiListResult
  >;
}

interface WidgetTypesOperations {
  @doc("Gets all available widget types in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/widgetTypes")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    WidgetTypeListResult
  >;

  @doc("Gets a widget type in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/widgetTypes/{widgetTypeName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the widget type.")
      @path
      widgetTypeName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    WidgetTypeResourceFormat
  >;
}

interface ViewsOperations {
  @doc("Gets all available views for given user in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/views")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The user ID. Use * to retrieve hub level views.")
      @query
      userId: string;
    },
    ViewListResult
  >;

  @doc("Creates a view or updates an existing view in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/views/{viewName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the view.")
      @path
      viewName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate View operation.")
      @body
      parameters: ViewResourceFormat;
    },
    ViewResourceFormat
  >;

  @doc("Gets a view in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/views/{viewName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the view.")
      @path
      viewName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The user ID. Use * to retrieve hub level view.")
      @query
      userId: string;
    },
    ViewResourceFormat
  >;

  @doc("Deletes a view in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/views/{viewName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the view.")
      @path
      viewName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The user ID. Use * to retrieve hub level view.")
      @query
      userId: string;
    },
    void
  >;
}

interface LinksOperations {
  @doc("Creates a link or updates an existing link in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/links/{linkName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the link.")
      @path
      linkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate Link operation.")
      @body
      parameters: LinkResourceFormat;
    },
    LinkResourceFormat | void
  >;

  @doc("Gets a link in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/links/{linkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the link.")
      @path
      linkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    LinkResourceFormat
  >;

  @doc("Deletes a link in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/links/{linkName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the link.")
      @path
      linkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all the links in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/links")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    LinkListResult
  >;
}

interface RolesOperations {
  @doc("Gets all the roles for the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roles")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RoleListResult
  >;
}

interface RoleAssignmentsOperations {
  @doc("Gets all the role assignments for the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roleAssignments")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RoleAssignmentListResult
  >;

  @doc("Creates or updates a role assignment in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roleAssignments/{assignmentName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The assignment name")
      @path
      assignmentName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate RoleAssignment operation.")
      @body
      parameters: RoleAssignmentResourceFormat;
    },
    RoleAssignmentResourceFormat | void
  >;

  @doc("Gets the role assignment in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roleAssignments/{assignmentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the role assignment.")
      @path
      assignmentName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RoleAssignmentResourceFormat
  >;

  @doc("Deletes the role assignment in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roleAssignments/{assignmentName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the role assignment.")
      @path
      assignmentName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ImagesOperations {
  @doc("Gets entity type (profile or interaction) image upload URL.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/images/getEntityTypeImageUploadUrl")
  @post
  GetUploadUrlForEntityType is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the GetUploadUrlForEntityType operation.")
      @body
      parameters: GetImageUploadUrlInput;
    },
    ImageDefinition
  >;

  @doc("Gets data image upload URL.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/images/getDataImageUploadUrl")
  @post
  GetUploadUrlForData is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the GetUploadUrlForData operation.")
      @body
      parameters: GetImageUploadUrlInput;
    },
    ImageDefinition
  >;
}

interface PredictionsOperations {
  @doc("Creates a Prediction or updates an existing Prediction in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Prediction.")
      @path
      predictionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create/update Prediction operation.")
      @body
      parameters: PredictionResourceFormat;
    },
    PredictionResourceFormat | void
  >;

  @doc("Gets a Prediction in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Prediction.")
      @path
      predictionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PredictionResourceFormat
  >;

  @doc("Deletes a Prediction in the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Prediction.")
      @path
      predictionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets training results.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}/getTrainingResults")
  @post
  GetTrainingResults is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Prediction.")
      @path
      predictionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PredictionTrainingResults
  >;

  @doc("Gets model status of the prediction.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}/getModelStatus")
  @post
  GetModelStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Prediction.")
      @path
      predictionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PredictionModelStatus
  >;

  @doc("Creates or updates the model status of prediction.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}/modelStatus")
  @post
  ModelStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("The name of the Prediction.")
      @path
      predictionName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create/update prediction model status operation.")
      @body
      parameters: PredictionModelStatus;
    },
    void
  >;

  @doc("Gets all the predictions in the specified hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PredictionListResult
  >;
}
