import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace TrafficController;

interface OperationsOperations {
  @doc("List the operations for the provider")
  @route("/providers/Microsoft.ServiceNetworking/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface TrafficControllerInterfaceOperations {
  @doc("List TrafficController resources by subscription ID")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceNetworking/trafficControllers")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    TrafficControllerListResult
  >;

  @doc("List TrafficController resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    TrafficControllerListResult
  >;

  @doc("Get a TrafficController")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;
    },
    TrafficController
  >;

  @doc("Create a TrafficController")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Resource create parameters.")
      @body
      resource: TrafficController;
    },
    TrafficController
  >;

  @doc("Update a TrafficController")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: TrafficControllerUpdate;
    },
    TrafficController
  >;

  @doc("Delete a TrafficController")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;
    },
    void
  >;
}

interface AssociationsInterfaceOperations {
  @doc("List Association resources by TrafficController")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/associations")
  @get
  ListByTrafficController is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;
    },
    AssociationListResult
  >;

  @doc("Get a Association")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/associations/{associationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Name of Association")
      @path
      associationName: string;
    },
    Association
  >;

  @doc("Create a Association")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/associations/{associationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Name of Association")
      @path
      associationName: string;

      @doc("Resource create parameters.")
      @body
      resource: Association;
    },
    Association
  >;

  @doc("Update a Association")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/associations/{associationName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Name of Association")
      @path
      associationName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: AssociationUpdate;
    },
    Association
  >;

  @doc("Delete a Association")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/associations/{associationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Name of Association")
      @path
      associationName: string;
    },
    void
  >;
}

interface FrontendsInterfaceOperations {
  @doc("List Frontend resources by TrafficController")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/frontends")
  @get
  ListByTrafficController is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;
    },
    FrontendListResult
  >;

  @doc("Get a Frontend")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/frontends/{frontendName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Frontends")
      @path
      frontendName: string;
    },
    Frontend
  >;

  @doc("Create a Frontend")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/frontends/{frontendName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Frontends")
      @path
      frontendName: string;

      @doc("Resource create parameters.")
      @body
      resource: Frontend;
    },
    Frontend
  >;

  @doc("Update a Frontend")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/frontends/{frontendName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Frontends")
      @path
      frontendName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: FrontendUpdate;
    },
    Frontend
  >;

  @doc("Delete a Frontend")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceNetworking/trafficControllers/{trafficControllerName}/frontends/{frontendName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("traffic controller name for path")
      @path
      trafficControllerName: string;

      @doc("Frontends")
      @path
      frontendName: string;
    },
    void
  >;
}
