import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureAnalysisServices;

interface ServersOperations {
  @doc("Gets details about the specified Analysis Services server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}")
  @get
  GetDetails is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be a minimum of 3 characters,
and a maximum of 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AnalysisServicesServer
  >;

  @doc("""
Provisions the specified Analysis Services server based on the configuration
specified in the request.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be a minimum of 3 characters,
and a maximum of 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Contains the information used to provision the Analysis Services server.")
      @body
      serverParameters: AnalysisServicesServer;
    },
    AnalysisServicesServer
  >;

  @doc("Deletes the specified Analysis Services server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be at least 3 characters in
length, and no more than 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Updates the current state of the specified Analysis Services server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be at least 3 characters in
length, and no more than 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Request object that contains the updated information for the server.")
      @body
      serverUpdateParameters: AnalysisServicesServerUpdateParameters;
    },
    AnalysisServicesServer
  >;

  @doc("Suspends operation of the specified Analysis Services server instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/suspend")
  @post
  Suspend is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be at least 3 characters in
length, and no more than 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Resumes operation of the specified Analysis Services server instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/resume")
  @post
  Resume is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be at least 3 characters in
length, and no more than 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all the Analysis Services servers for the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AnalysisServicesServers
  >;

  @doc("Lists all the Analysis Services servers for the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/servers")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AnalysisServicesServers
  >;

  @doc("Lists eligible SKUs for Analysis Services resource provider.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/skus")
  @get
  ListSkusForNew is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SkuEnumerationForNewResourceResult
  >;

  @doc("Lists eligible SKUs for an Analysis Services resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/skus")
  @get
  ListSkusForExisting is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be at least 3 characters in
length, and no more than 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SkuEnumerationForExistingResourceResult
  >;

  @doc("Return the gateway status of the specified Analysis Services server instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/listGatewayStatus")
  @post
  ListGatewayStatus is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the Analysis Services server.")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    GatewayListStatusLive
  >;

  @doc("Dissociates a Unified Gateway associated with the server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/dissociateGateway")
  @post
  DissociateGateway is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given Analysis Services server
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Analysis Services server. It must be at least 3 characters in
length, and no more than 63.
""")
      @path
      serverName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Check the name availability in the target location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The region name which the operation will lookup into.")
      @path
      location: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Contains the information used to provision the Analysis Services server.")
      @body
      serverParameters: CheckServerNameAvailabilityParameters;
    },
    CheckServerNameAvailabilityResult
  >;

  @doc("List the result of the specified operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/operationresults/{operationId}")
  @get
  ListOperationResults is Azure.Core.Foundations.Operation<
    {
      @doc("The region name which the operation will lookup into.")
      @path
      location: string;

      @doc("The target operation Id.")
      @path
      operationId: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("List the status of operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/operationstatuses/{operationId}")
  @get
  ListOperationStatuses is Azure.Core.Foundations.Operation<
    {
      @doc("The region name which the operation will lookup into.")
      @path
      location: string;

      @doc("The target operation Id.")
      @path
      operationId: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available consumption REST API operations.")
  @route("/providers/Microsoft.AnalysisServices/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
