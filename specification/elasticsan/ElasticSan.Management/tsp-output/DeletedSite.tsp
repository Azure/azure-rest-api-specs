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

namespace Microsoft.CertificateRegistration;
@doc("A deleted app.")
@subscriptionResource
model DeletedSite is ProxyResource<DeletedSiteProperties> {
  @doc("The numeric ID of the deleted app, e.g. 12345")
  @path
  @key("deletedSiteId")
  @segment("deletedSites")
  name: string;
}

@armResourceOperations
interface DeletedSites {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get deleted app for a subscription.")
  @operationId("Global_GetDeletedWebApp")
  getDeletedWebApp is ArmResourceRead<DeletedSite>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get all deleted apps for a subscription.")
  @operationId("DeletedWebApps_List")
  list is ArmResourceListByParent<DeletedSite>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get all deleted apps for a subscription at location")
  @operationId("DeletedWebApps_ListByLocation")
  listByLocation is ArmResourceListAtScope<
    DeletedSite,
    LocationScope<DeletedSite>,
    {
      ...BaseParameters<DeletedSite>;

      @path
      location: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Global_GetDeletedWebAppSnapshots")
  @summary("Get all deleted apps for a subscription.")
  @doc("Description for Get all deleted apps for a subscription.")
  // FIXME: Global_GetDeletedWebAppSnapshots could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/deletedSites/{deletedSiteId}/snapshots")
  @get
  getDeletedWebAppSnapshots is Azure.Core.Foundations.Operation<
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
