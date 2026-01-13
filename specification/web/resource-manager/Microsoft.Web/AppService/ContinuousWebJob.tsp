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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Gets a continuous web job by its ID for an app, or a deployment slot.")
  getContinuousWebJob is ContinuousWebJobOps.Read<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJob> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a continuous web job by its ID for an app, or a deployment slot.
   */
  @summary("Delete a continuous web job by its ID for an app, or a deployment slot.")
  deleteContinuousWebJob is ContinuousWebJobOps.DeleteSync<
    ContinuousWebJob,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List continuous web jobs for an app, or a deployment slot.
   */
  @summary("List continuous web jobs for an app, or a deployment slot.")
  listContinuousWebJobs is ContinuousWebJobOps.List<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJobCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Start a continuous web job for an app, or a deployment slot.")
  @action("start")
  startContinuousWebJob is ContinuousWebJobOps.ActionSync<
    ContinuousWebJob,
    void,
    {
      @body body: void;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Stop a continuous web job for an app, or a deployment slot.")
  @action("stop")
  stopContinuousWebJob is ContinuousWebJobOps.ActionSync<
    ContinuousWebJob,
    void,
    {
      @body body: void;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Gets a continuous web job by its ID for an app, or a deployment slot.")
  getContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.Read<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJob> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a continuous web job by its ID for an app, or a deployment slot.
   */
  @summary("Delete a continuous web job by its ID for an app, or a deployment slot.")
  deleteContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.DeleteSync<
    ContinuousWebJob,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List continuous web jobs for an app, or a deployment slot.
   */
  @summary("List continuous web jobs for an app, or a deployment slot.")
  listContinuousWebJobsSlot is ContinuousWebJobOperationGroupOps.List<
    ContinuousWebJob,
    Response = ArmResponse<ContinuousWebJobCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Start a continuous web job for an app, or a deployment slot.")
  @action("start")
  startContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.ActionSync<
    ContinuousWebJob,
    void,
    {
      @body body: void;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Stop a continuous web job for an app, or a deployment slot.")
  @action("stop")
  stopContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.ActionSync<
    ContinuousWebJob,
    void,
    {
      @body body: void;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ContinuousWebJob.name, "Name of Web Job.");
@@doc(ContinuousWebJob.properties,
  "ContinuousWebJob resource specific properties"
);
