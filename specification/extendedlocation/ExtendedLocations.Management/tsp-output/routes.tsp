import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace customLocations;

interface CustomLocationsOperations {
  @doc("Lists all available Custom Locations operations.")
  @route("/providers/Microsoft.ExtendedLocation/operations")
  @get
  ListOperations is Azure.Core.Foundations.Operation<
    {},
    CustomLocationOperationsList
  >;

  @summary("Gets a list of Custom Locations in a subscription.")
  @doc("""
Gets a list of Custom Locations in the specified subscription. The operation
returns properties of each Custom Location
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ExtendedLocation/customLocations")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    CustomLocationListResult
  >;

  @summary("""
Gets a list of Custom Locations in the specified subscription and resource
group.
""")
  @doc("""
Gets a list of Custom Locations in the specified subscription and resource
group. The operation returns properties of each Custom Location.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations")
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
    CustomLocationListResult
  >;

  @summary("Gets a Custom Location.")
  @doc("Gets the details of the customLocation with a specified resource group and name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Custom Locations name.")
      @path
      resourceName: string;
    },
    CustomLocation
  >;

  @summary("Creates or updates a Custom Location.")
  @doc("""
Creates or updates a Custom Location in the specified Subscription and Resource
Group
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Custom Locations name.")
      @path
      resourceName: string;

      @doc("Parameters supplied to create or update a Custom Location.")
      @body
      parameters: CustomLocation;
    },
    CustomLocation
  >;

  @summary("Deletes a Custom Location.")
  @doc("""
Deletes the Custom Location with the specified Resource Name, Resource Group,
and Subscription Id.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Custom Locations name.")
      @path
      resourceName: string;
    },
    void
  >;

  @summary("Updates a Custom Location.")
  @doc("""
Updates a Custom Location with the specified Resource Name in the specified
Resource Group and Subscription.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Custom Locations name.")
      @path
      resourceName: string;

      @doc("The updatable fields of an existing Custom Location.")
      @body
      parameters: PatchableCustomLocations;
    },
    CustomLocation
  >;

  @summary("Gets the list of Enabled Resource Types.")
  @doc("Gets the list of the Enabled Resource Types.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations/{resourceName}/enabledResourceTypes")
  @get
  ListEnabledResourceTypes is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Custom Locations name.")
      @path
      resourceName: string;
    },
    EnabledResourceTypesListResult
  >;
}
