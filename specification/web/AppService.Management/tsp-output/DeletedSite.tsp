import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("A deleted app.")
@subscriptionResource
model DeletedSite is ProxyResource<DeletedSiteProperties> {
  @doc("The numeric ID of the deleted app, e.g. 12345")
  @key("deletedSiteId")
  @segment("deletedSites")
  name: string;
}

@armResourceOperations
@projectedName("client", "Global")
interface DeletedSites_Global {
  @doc("Description for Get deleted app for a subscription.")
  getDeletedWebApp is ArmResourceRead<DeletedSite>;

  @summary("Get all deleted apps for a subscription.")
  @doc("Description for Get all deleted apps for a subscription.")
  // FIXME: Global_GetDeletedWebAppSnapshots could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/deletedSites/{deletedSiteId}/snapshots")
  @get
  GetDeletedWebAppSnapshots is Azure.Core.Foundations.Operation<
    {
      @doc("The numeric ID of the deleted app, e.g. 12345")
      @path
      deletedSiteId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;
}

@armResourceOperations
@projectedName("client", "DeletedWebApps")
interface DeletedSites_DeletedWebApps {
  @doc("Description for Get all deleted apps for a subscription.")
  list is ArmResourceListByParent<DeletedSite>;

  @doc("Description for Get all deleted apps for a subscription at location")
  listByLocation is ArmResourceListAtScope<
    DeletedSite,
    LocationScope<DeletedSite>,
    {
      ...BaseParameters<DeletedSite>;

      @path
      location: string;
    }
  >;
}
