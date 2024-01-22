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
/**
 * A deleted app.
 */
@subscriptionResource
model DeletedSite is ProxyResource<DeletedSiteProperties> {
  /**
   * The numeric ID of the deleted app, e.g. 12345
   */
  @path
  @key("deletedSiteId")
  @segment("deletedSites")
  name: string;
}

@armResourceOperations
interface DeletedSites {
  /**
   * Description for Get deleted app for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Global_GetDeletedWebApp")
  getDeletedWebApp is ArmResourceRead<DeletedSite>;

  /**
   * Description for Get all deleted apps for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeletedWebApps_List")
  list is ArmResourceListByParent<DeletedSite>;

  /**
   * Description for Get all deleted apps for a subscription at location
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Description for Get all deleted apps for a subscription.
   */
  // FIXME: Global_GetDeletedWebAppSnapshots could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Global_GetDeletedWebAppSnapshots")
  @summary("Get all deleted apps for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/deletedSites/{deletedSiteId}/snapshots")
  @get
  getDeletedWebAppSnapshots is Azure.Core.Foundations.Operation<
    {
      /**
       * The numeric ID of the deleted app, e.g. 12345
       */
      @path
      deletedSiteId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}
