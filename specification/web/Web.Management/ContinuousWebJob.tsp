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
 * Continuous Web Job Information.
 */
@parentResource(Site)
model ContinuousWebJob
  is Azure.ResourceManager.ProxyResource<ContinuousWebJobProperties> {
  ...ResourceNameParameter<
    Resource = ContinuousWebJob,
    KeyName = "webJobName",
    SegmentName = "continuouswebjobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContinuousWebJobOps
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
        /** Name of Web Job. */
        @path
        @segment("continuouswebjobs")
        @key
        webJobName: string,
      }
    > {}

@armResourceOperations
interface ContinuousWebJobs {
  /**
   * Description for Gets a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetContinuousWebJob")
  getContinuousWebJob is ContinuousWebJobOps.Read<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJob> | ArmNotFoundResponse
  >;

  /**
   * Description for Delete a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteContinuousWebJob")
  deleteContinuousWebJob is ContinuousWebJobOps.DeleteSync<ContinuousWebJob>;

  /**
   * Description for List continuous web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListContinuousWebJobs")
  listContinuousWebJobs is ContinuousWebJobOps.List<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJobCollection>
  >;

  /**
   * Description for Start a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_StartContinuousWebJob")
  @action("start")
  startContinuousWebJob is ContinuousWebJobOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse | ArmNotFoundResponse
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_StopContinuousWebJob")
  @action("stop")
  stopContinuousWebJob is ContinuousWebJobOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse | ArmNotFoundResponse
  >;
}
@armResourceOperations
interface ContinuousWebJobOperationGroupOps
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

        /** Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of Web Job. */
        @path
        @segment("continuouswebjobs")
        @key
        webJobName: string,
      }
    > {}

@armResourceOperations
interface ContinuousWebJobOperationGroup {
  /**
   * Description for Gets a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetContinuousWebJobSlot")
  getContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.Read<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJob> | ArmNotFoundResponse
  >;

  /**
   * Description for Delete a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteContinuousWebJobSlot")
  deleteContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.DeleteSync<ContinuousWebJob>;

  /**
   * Description for List continuous web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListContinuousWebJobsSlot")
  listContinuousWebJobsSlot is ContinuousWebJobOperationGroupOps.List<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJobCollection>
  >;

  /**
   * Description for Start a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_StartContinuousWebJobSlot")
  @action("start")
  startContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse | ArmNotFoundResponse
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_StopContinuousWebJobSlot")
  @action("stop")
  stopContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse | ArmNotFoundResponse
  >;
}

@@doc(ContinuousWebJob.name, "Name of Web Job.");
@@doc(ContinuousWebJob.properties,
  "ContinuousWebJob resource specific properties"
);
