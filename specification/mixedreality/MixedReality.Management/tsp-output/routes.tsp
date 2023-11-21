import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MixedRealityClient;

interface OperationsOperations {
  @doc("Exposing Available Operations")
  @route("/providers/Microsoft.MixedReality/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationPage>;
}

@doc("Check Name Availability for local uniqueness")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.MixedReality/locations/{location}/checkNameAvailability")
@post
op CheckNameAvailabilityLocal is Azure.Core.Foundations.Operation<
  {
    @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
    @path
    subscriptionId: string;

    @doc("The location in which uniqueness will be verified.")
    @path
    location: string;

    @doc("Check Name Availability Request.")
    @body
    checkNameAvailability: CheckNameAvailabilityRequest;
  },
  CheckNameAvailabilityResponse
>;

interface SpatialAnchorsAccountsOperations {
  @doc("List Spatial Anchors Accounts by Subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MixedReality/spatialAnchorsAccounts")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;
    },
    SpatialAnchorsAccountPage
  >;

  @doc("List Resources by Resource Group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;
    },
    SpatialAnchorsAccountPage
  >;

  @doc("Delete a Spatial Anchors Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts/{accountName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    void
  >;

  @doc("Retrieve a Spatial Anchors Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts/{accountName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    SpatialAnchorsAccount
  >;

  @doc("Updating a Spatial Anchors Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts/{accountName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Spatial Anchors Account parameter.")
      @body
      spatialAnchorsAccount: SpatialAnchorsAccount;
    },
    SpatialAnchorsAccount
  >;

  @doc("Creating or Updating a Spatial Anchors Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts/{accountName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Spatial Anchors Account parameter.")
      @body
      spatialAnchorsAccount: SpatialAnchorsAccount;
    },
    SpatialAnchorsAccount
  >;

  @doc("List Both of the 2 Keys of a Spatial Anchors Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts/{accountName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    AccountKeys
  >;

  @doc("Regenerate specified Key of a Spatial Anchors Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/spatialAnchorsAccounts/{accountName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Required information for key regeneration.")
      @body
      regenerate: AccountKeyRegenerateRequest;
    },
    AccountKeys
  >;
}

interface RemoteRenderingAccountsOperations {
  @doc("List Remote Rendering Accounts by Subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MixedReality/remoteRenderingAccounts")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;
    },
    RemoteRenderingAccountPage
  >;

  @doc("List Resources by Resource Group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;
    },
    RemoteRenderingAccountPage
  >;

  @doc("Delete a Remote Rendering Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts/{accountName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    void
  >;

  @doc("Retrieve a Remote Rendering Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts/{accountName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    RemoteRenderingAccount
  >;

  @doc("Updating a Remote Rendering Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts/{accountName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Remote Rendering Account parameter.")
      @body
      remoteRenderingAccount: RemoteRenderingAccount;
    },
    RemoteRenderingAccount
  >;

  @doc("Creating or Updating a Remote Rendering Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts/{accountName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Remote Rendering Account parameter.")
      @body
      remoteRenderingAccount: RemoteRenderingAccount;
    },
    RemoteRenderingAccount
  >;

  @doc("List Both of the 2 Keys of a Remote Rendering Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts/{accountName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    AccountKeys
  >;

  @doc("Regenerate specified Key of a Remote Rendering Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/remoteRenderingAccounts/{accountName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Required information for key regeneration.")
      @body
      regenerate: AccountKeyRegenerateRequest;
    },
    AccountKeys
  >;
}

interface ObjectAnchorsAccountsOperations {
  @doc("List Object Anchors Accounts by Subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MixedReality/objectAnchorsAccounts")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;
    },
    ObjectAnchorsAccountPage
  >;

  @doc("List Resources by Resource Group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;
    },
    ObjectAnchorsAccountPage
  >;

  @doc("Delete an Object Anchors Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts/{accountName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    void
  >;

  @doc("Retrieve an Object Anchors Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts/{accountName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    ObjectAnchorsAccount
  >;

  @doc("Updating an Object Anchors Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts/{accountName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Object Anchors Account parameter.")
      @body
      objectAnchorsAccount: ObjectAnchorsAccount;
    },
    ObjectAnchorsAccount
  >;

  @doc("Creating or Updating an object anchors Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts/{accountName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Object Anchors Account parameter.")
      @body
      objectAnchorsAccount: ObjectAnchorsAccount;
    },
    ObjectAnchorsAccount
  >;

  @doc("List Both of the 2 Keys of an object anchors Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts/{accountName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;
    },
    AccountKeys
  >;

  @doc("Regenerate specified Key of an object anchors Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MixedReality/objectAnchorsAccounts/{accountName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of an Mixed Reality Account.")
      @path
      accountName: string;

      @doc("Required information for key regeneration.")
      @body
      regenerate: AccountKeyRegenerateRequest;
    },
    AccountKeys
  >;
}
