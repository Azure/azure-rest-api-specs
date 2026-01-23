import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * A deleted app.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DeletedSite
  is Azure.ResourceManager.ProxyResource<DeletedSiteProperties> {
  ...ResourceNameParameter<
    Resource = DeletedSite,
    KeyName = "deletedSiteId",
    SegmentName = "deletedSites",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface DeletedSiteOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.Web",

        ...LocationParameter,
      },
      {},
      {
        /** The numeric ID of the deleted app, e.g. 12345 */
        @path
        @segment("deletedSites")
        @key
        deletedSiteId: string,
      }
    > {}

@armResourceOperations
interface DeletedSites {
  /**
   * Description for Get deleted app for a subscription at location.
   */
  @summary("Get deleted app for a subscription at location.")
  getDeletedWebAppByLocation is DeletedSiteOps.Read<
    DeletedSite,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all deleted apps for a subscription at location
   */
  @summary("Get all deleted apps for a subscription at location")
  listByLocation is DeletedSiteOps.List<
    DeletedSite,
    Response = ArmResponse<DeletedWebAppCollection>,
    ErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface GlobalOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.Web",
      },
      {},
      {
        /** The numeric ID of the deleted app, e.g. 12345 */
        @path
        @segment("deletedSites")
        @key
        deletedSiteId: string,
      }
    > {}

@armResourceOperations
interface Global {
  /**
   * Description for Get deleted app for a subscription.
   */
  @summary("Get deleted app for a subscription.")
  getDeletedWebApp is GlobalOps.Read<
    DeletedSite,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all deleted apps for a subscription.
   */
  @summary("Get all deleted apps for a subscription.")
  list is GlobalOps.List<
    DeletedSite,
    Response = ArmResponse<DeletedWebAppCollection>,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all deleted apps for a subscription.
   */
  @get
  @action("snapshots")
  @summary("Get all deleted apps for a subscription.")
  getDeletedWebAppSnapshots is GlobalOps.ActionSync<
    DeletedSite,
    void,
    ArmResponse<Snapshot[]>,
    ErrorType = DefaultErrorResponse
  >;
}

@@doc(DeletedSite.name, "The numeric ID of the deleted app, e.g. 12345");
@@doc(DeletedSite.properties, "DeletedSite resource specific properties");
