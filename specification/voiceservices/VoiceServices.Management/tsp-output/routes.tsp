import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.VoiceServices;

interface OperationsOperations {
  @doc("List the operations for the provider")
  @route("/providers/Microsoft.VoiceServices/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface CommunicationsGatewaysOperations {
  @doc("List CommunicationsGateway resources by subscription ID")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.VoiceServices/communicationsGateways")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    CommunicationsGatewayListResult
  >;

  @doc("List CommunicationsGateway resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways")
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
    CommunicationsGatewayListResult
  >;

  @doc("Get a CommunicationsGateway")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;
    },
    CommunicationsGateway
  >;

  @doc("Create a CommunicationsGateway")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;

      @doc("Resource create parameters.")
      @body
      resource: CommunicationsGateway;
    },
    CommunicationsGateway
  >;

  @doc("Delete a CommunicationsGateway")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;
    },
    void
  >;

  @doc("Update a CommunicationsGateway")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: CommunicationsGatewayUpdate;
    },
    CommunicationsGateway
  >;
}

interface NameAvailabilityOperations {
  @doc("Check whether the resource name is available in the given region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.VoiceServices/locations/{location}/checkNameAvailability")
  @post
  CheckLocal is Azure.Core.Foundations.Operation<
    {
      @doc("The location in which uniqueness will be verified.")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The check availability request body.")
      @body
      body: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface TestLinesOperations {
  @doc("List TestLine resources by CommunicationsGateway")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}/testLines")
  @get
  ListByCommunicationsGateway is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;
    },
    TestLineListResult
  >;

  @doc("Get a TestLine")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}/testLines/{testLineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;

      @doc("Unique identifier for this test line")
      @path
      testLineName: string;
    },
    TestLine
  >;

  @doc("Create a TestLine")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}/testLines/{testLineName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;

      @doc("Unique identifier for this test line")
      @path
      testLineName: string;

      @doc("Resource create parameters.")
      @body
      resource: TestLine;
    },
    TestLine
  >;

  @doc("Delete a TestLine")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}/testLines/{testLineName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;

      @doc("Unique identifier for this test line")
      @path
      testLineName: string;
    },
    void
  >;

  @doc("Update a TestLine")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.VoiceServices/communicationsGateways/{communicationsGatewayName}/testLines/{testLineName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Unique identifier for this deployment")
      @path
      communicationsGatewayName: string;

      @doc("Unique identifier for this test line")
      @path
      testLineName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: TestLineUpdate;
    },
    TestLine
  >;
}
