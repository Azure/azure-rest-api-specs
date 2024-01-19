import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
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
interface AscLocations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Details of a specific location")
  @operationId("Locations_Get")
  get is ArmResourceRead<AscLocation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The location of the responsible ASC of the specific subscription (home region). For each subscription there is only one responsible location. The location in the response should be used to read or write other resources in ASC according to their ID.")
  @operationId("Locations_List")
  list is ArmResourceListByParent<AscLocation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AllowedConnections_ListByHomeRegion")
  @doc("Gets the list of all possible traffic between resources for the subscription and location.")
  // FIXME: AllowedConnections_ListByHomeRegion could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/allowedConnections")
  @get
  listByHomeRegion is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Topology_ListByHomeRegion")
  @doc("Gets a list that allows to build a topology view of a subscription and location.")
  // FIXME: Topology_ListByHomeRegion could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/topologies")
  @get
  listByHomeRegion is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JitNetworkAccessPolicies_ListByRegion")
  @doc("Policies for protecting resources using Just-in-Time access control for the subscription, location")
  // FIXME: JitNetworkAccessPolicies_ListByRegion could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies")
  @get
  listByRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;
    },
    ResourceListResult<JitNetworkAccessPolicy>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiscoveredSecuritySolutions_ListByHomeRegion")
  @doc("Gets a list of discovered Security Solutions for the subscription and location.")
  // FIXME: DiscoveredSecuritySolutions_ListByHomeRegion could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions")
  @get
  listByHomeRegion is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SecuritySolutionsReferenceData_ListByHomeRegion")
  @doc("Gets list of all supported Security Solutions for subscription and location.")
  // FIXME: SecuritySolutionsReferenceData_ListByHomeRegion could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData")
  @get
  listByHomeRegion is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExternalSecuritySolutions_ListByHomeRegion")
  @doc("Gets a list of external Security Solutions for the subscription and location.")
  // FIXME: ExternalSecuritySolutions_ListByHomeRegion could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/ExternalSecuritySolutions")
  @get
  listByHomeRegion is Azure.Core.Foundations.Operation<
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
