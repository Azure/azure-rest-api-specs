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
/**
 * Web Job Information.
 */
@parentResource(Site)
model WebJob is Azure.ResourceManager.ProxyResource<WebJobProperties> {
  ...ResourceNameParameter<
    Resource = WebJob,
    KeyName = "webJobName",
    SegmentName = "webjobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WebJobOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of the web job. */
        @path
        @segment("webjobs")
        @key
        webJobName: string,
      }
    > {}

@armResourceOperations
interface WebJobs {
  /**
   * Description for Get webjob information for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetWebJobSlot")
  getWebJobSlot is WebJobOps.Read<
    WebJob,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List webjobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListWebJobsSlot")
  listWebJobsSlot is WebJobOps.List<
    WebJob,
    Response = ArmResponse<WebJobCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface WebJobOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the web job. */
        @path
        @segment("webjobs")
        @key
        webJobName: string,
      }
    > {}

@armResourceOperations
interface WebJobOperationGroup {
  /**
   * Description for Get webjob information for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetWebJob")
  getWebJob is WebJobOperationGroupOps.Read<
    WebJob,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List webjobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListWebJobs")
  listWebJobs is WebJobOperationGroupOps.List<
    WebJob,
    Response = ArmResponse<WebJobCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(WebJob.name, "Name of the web job.");
@@doc(WebJob.properties, "WebJob resource specific properties");
