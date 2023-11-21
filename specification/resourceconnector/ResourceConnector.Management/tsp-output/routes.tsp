import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace appliances;

interface AppliancesOperations {
  @doc("Lists all available Appliances operations.")
  @route("/providers/Microsoft.ResourceConnector/operations")
  @get
  ListOperations is Azure.Core.Foundations.Operation<
    {},
    ApplianceOperationsList
  >;

  @summary("Gets a list of Appliances in a subscription.")
  @doc("""
Gets a list of Appliances in the specified subscription. The operation returns
properties of each Appliance
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ResourceConnector/appliances")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ApplianceListResult
  >;

  @summary("Gets the telemetry config.")
  @doc("Gets the telemetry config.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ResourceConnector/telemetryconfig")
  @get
  GetTelemetryConfig is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ApplianceGetTelemetryConfigResult
  >;

  @summary("Gets a list of Appliances in the specified subscription and resource group.")
  @doc("""
Gets a list of Appliances in the specified subscription and resource group. The
operation returns properties of each Appliance.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances")
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
    ApplianceListResult
  >;

  @summary("Gets an Appliance.")
  @doc("Gets the details of an Appliance with a specified resource group and name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;
    },
    Appliance
  >;

  @summary("Creates or updates an Appliance.")
  @doc("""
Creates or updates an Appliance in the specified Subscription and Resource
Group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;

      @doc("Parameters supplied to create or update an Appliance.")
      @body
      parameters: Appliance;
    },
    Appliance
  >;

  @summary("Deletes an Appliance.")
  @doc("""
Deletes an Appliance with the specified Resource Name, Resource Group, and
Subscription Id.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;
    },
    void
  >;

  @summary("Updates an Appliance.")
  @doc("""
Updates an Appliance with the specified Resource Name in the specified Resource
Group and Subscription.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;

      @doc("The updatable fields of an existing Appliance.")
      @body
      parameters: PatchableAppliance;
    },
    Appliance
  >;

  @summary("Returns the cluster user credential.")
  @doc("Returns the cluster user credentials for the dedicated appliance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}/listClusterUserCredential")
  @post
  ListClusterUserCredential is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;
    },
    ApplianceListCredentialResults
  >;

  @summary("Gets the management config.")
  @doc("Returns the cluster customer credentials for the dedicated appliance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}/listkeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;

      @doc("""
This sets the type of artifact being returned, when empty no artifact endpoint
is returned.
""")
      @query
      artifactType: string;
    },
    ApplianceListKeysResults
  >;

  @summary("Gets an Appliance upgrade graph.")
  @doc("""
Gets the upgrade graph of an Appliance with a specified resource group and name
and specific release train.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs/{upgradeGraph}")
  @get
  GetUpgradeGraph is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Appliances name.")
      @path
      resourceName: string;

      @doc("Upgrade graph version, ex - stable")
      @path
      upgradeGraph: string;
    },
    UpgradeGraph
  >;
}
