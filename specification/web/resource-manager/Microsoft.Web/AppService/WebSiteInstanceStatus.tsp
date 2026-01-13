import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;

@parentResource(Site)
model WebSiteInstanceStatus
  is Azure.ResourceManager.ProxyResource<WebSiteInstanceStatusProperties> {
  ...ResourceNameParameter<
    Resource = WebSiteInstanceStatus,
    KeyName = "instanceId",
    SegmentName = "instances",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface WebSiteInstanceStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("instances")
        @key
        instanceId: string,
      }
    > {}

@armResourceOperations
interface WebSiteInstanceStatuses {
  /**
   * Description for Gets all scale-out instances of an app.
   */
  @summary("Gets all scale-out instances of an app.")
  getInstanceInfo is WebSiteInstanceStatusOps.Read<
    WebSiteInstanceStatus,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets all scale-out instances of an app.
   */
  @summary("Gets all scale-out instances of an app.")
  listInstanceIdentifiers is WebSiteInstanceStatusOps.List<
    WebSiteInstanceStatus,
    Response = ArmResponse<WebAppInstanceStatusCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface WebSiteInstanceStatusOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API gets the production slot instances. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("instances")
        @key
        instanceId: string,
      }
    > {}

@armResourceOperations
interface WebSiteInstanceStatusOperationGroup {
  /**
   * Description for Gets all scale-out instances of an app.
   */
  @summary("Gets all scale-out instances of an app.")
  getInstanceInfoSlot is WebSiteInstanceStatusOperationGroupOps.Read<
    WebSiteInstanceStatus,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets all scale-out instances of an app.
   */
  @summary("Gets all scale-out instances of an app.")
  listInstanceIdentifiersSlot is WebSiteInstanceStatusOperationGroupOps.List<
    WebSiteInstanceStatus,
    Response = ArmResponse<WebAppInstanceStatusCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(WebSiteInstanceStatus.name, "");
@@doc(WebSiteInstanceStatus.properties,
  "WebSiteInstanceStatus resource specific properties"
);
