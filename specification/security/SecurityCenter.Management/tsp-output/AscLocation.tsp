import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("The ASC location of the subscription is in the \"name\" field")
@locationResource
model AscLocation is ProxyResource<AnyObject> {
  @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
  @path
  @key("ascLocation")
  @segment("locations")
  name: string;
}

@armResourceOperations
interface Locations {
  @doc("Details of a specific location")
  get is ArmResourceRead<AscLocation>;
  @doc("The location of the responsible ASC of the specific subscription (home region). For each subscription there is only one responsible location. The location in the response should be used to read or write other resources in ASC according to their ID.")
  list is ArmResourceListByParent<AscLocation>;
}

@armResourceOperations
interface AllowedConnections {
  @doc("Gets the list of all possible traffic between resources for the subscription and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/allowedConnections")
  @get
  ListByHomeRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    AllowedConnectionsList
  >;
}

@armResourceOperations
interface Topology {
  @doc("Gets a list that allows to build a topology view of a subscription and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/topologies")
  @get
  ListByHomeRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    TopologyList
  >;
}

@armResourceOperations
interface JitNetworkAccessPolicies {
  @doc("Policies for protecting resources using Just-in-Time access control for the subscription, location")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies")
  @get
  ListByRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    JitNetworkAccessPoliciesList
  >;
}

@armResourceOperations
interface DiscoveredSecuritySolutions {
  @doc("Gets a list of discovered Security Solutions for the subscription and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions")
  @get
  ListByHomeRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    DiscoveredSecuritySolutionList
  >;
}

@armResourceOperations
interface SecuritySolutionsReferenceData {
  @doc("Gets list of all supported Security Solutions for subscription and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData")
  @get
  ListByHomeRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    SecuritySolutionsReferenceDataList
  >;
}

@armResourceOperations
interface ExternalSecuritySolutions {
  @doc("Gets a list of external Security Solutions for the subscription and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/ExternalSecuritySolutions")
  @get
  ListByHomeRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    ExternalSecuritySolutionList
  >;
}
