import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TriggeredWebJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Triggered Web Job History. List of Triggered Web Job Run Information elements.
 */
@parentResource(TriggeredWebJob)
model TriggeredJobHistory
  is Azure.ResourceManager.ProxyResource<TriggeredJobHistoryProperties> {
  ...ResourceNameParameter<
    Resource = TriggeredJobHistory,
    KeyName = "id",
    SegmentName = "history",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface TriggeredJobHistoryOps
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

        /** Name of Web Job. */
        @path
        @segment("triggeredwebjobs")
        @key
        webJobName: string,
      },
      {
        /** History ID. */
        @path
        @segment("history")
        @key
        id: string,
      }
    > {}

@armResourceOperations
interface TriggeredJobHistories {
  /**
   * Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
   */
  @summary("Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  getTriggeredWebJobHistorySlot is TriggeredJobHistoryOps.Read<
    TriggeredJobHistory,
    Response = ArmResponse<TriggeredJobHistory> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List a triggered web job's history for an app, or a deployment slot.
   */
  @summary("List a triggered web job's history for an app, or a deployment slot.")
  listTriggeredWebJobHistorySlot is TriggeredJobHistoryOps.List<
    TriggeredJobHistory,
    Response = ArmResponse<TriggeredJobHistoryCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface TriggeredJobHistoryOperationGroupOps
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

        /** Name of Web Job. */
        @path
        @segment("triggeredwebjobs")
        @key
        webJobName: string,
      },
      {
        /** History ID. */
        @path
        @segment("history")
        @key
        id: string,
      }
    > {}

@armResourceOperations
interface TriggeredJobHistoryOperationGroup {
  /**
   * Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
   */
  @summary("Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  getTriggeredWebJobHistory is TriggeredJobHistoryOperationGroupOps.Read<
    TriggeredJobHistory,
    Response = ArmResponse<TriggeredJobHistory> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List a triggered web job's history for an app, or a deployment slot.
   */
  @summary("List a triggered web job's history for an app, or a deployment slot.")
  listTriggeredWebJobHistory is TriggeredJobHistoryOperationGroupOps.List<
    TriggeredJobHistory,
    Response = ArmResponse<TriggeredJobHistoryCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(TriggeredJobHistory.name, "History ID.");
@@doc(TriggeredJobHistory.properties,
  "TriggeredJobHistory resource specific properties"
);
