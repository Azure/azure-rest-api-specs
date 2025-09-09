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
 * Triggered Web Job Information.
 */
@parentResource(Site)
model TriggeredWebJob
  is Azure.ResourceManager.ProxyResource<TriggeredWebJobProperties> {
  ...ResourceNameParameter<
    Resource = TriggeredWebJob,
    KeyName = "webJobName",
    SegmentName = "triggeredwebjobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TriggeredWebJobOps
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

        /** Name of the deployment slot. If a slot is not specified, the API uses the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of Web Job. */
        @path
        @segment("triggeredwebjobs")
        @key
        webJobName: string,
      }
    > {}

@armResourceOperations
interface TriggeredWebJobs {
  /**
   * Description for Gets a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetTriggeredWebJobSlot")
  getTriggeredWebJobSlot is TriggeredWebJobOps.Read<
    TriggeredWebJob,
    Response = ArmResponse<TriggeredWebJob> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteTriggeredWebJobSlot")
  deleteTriggeredWebJobSlot is TriggeredWebJobOps.DeleteSync<
    TriggeredWebJob,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List triggered web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListTriggeredWebJobsSlot")
  listTriggeredWebJobsSlot is TriggeredWebJobOps.List<
    TriggeredWebJob,
    Response = ArmResponse<TriggeredWebJobCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Run a triggered web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_RunTriggeredWebJobSlot")
  @action("run")
  runTriggeredWebJobSlot is TriggeredWebJobOps.ActionSync<
    TriggeredWebJob,
    void,
    OkResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface TriggeredWebJobOperationGroupOps
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
        @segment("triggeredwebjobs")
        @key
        webJobName: string,
      }
    > {}

@armResourceOperations
interface TriggeredWebJobOperationGroup {
  /**
   * Description for Gets a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetTriggeredWebJob")
  getTriggeredWebJob is TriggeredWebJobOperationGroupOps.Read<
    TriggeredWebJob,
    Response = ArmResponse<TriggeredWebJob> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteTriggeredWebJob")
  deleteTriggeredWebJob is TriggeredWebJobOperationGroupOps.DeleteSync<
    TriggeredWebJob,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List triggered web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListTriggeredWebJobs")
  listTriggeredWebJobs is TriggeredWebJobOperationGroupOps.List<
    TriggeredWebJob,
    Response = ArmResponse<TriggeredWebJobCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Run a triggered web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_RunTriggeredWebJob")
  @action("run")
  runTriggeredWebJob is TriggeredWebJobOperationGroupOps.ActionSync<
    TriggeredWebJob,
    void,
    OkResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(TriggeredWebJob.name, "Name of Web Job.");
@@doc(TriggeredWebJob.properties,
  "TriggeredWebJob resource specific properties"
);
