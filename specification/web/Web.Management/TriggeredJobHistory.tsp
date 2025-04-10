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

namespace Microsoft.CertificateRegistration;
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
}

@armResourceOperations
interface TriggeredJobHistoryOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = TriggeredWebJob,
          KeyName = "webJobName",
          SegmentName = "triggeredwebjobs",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = TriggeredJobHistory,
        KeyName = "id",
        SegmentName = "history",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface TriggeredJobHistories {
  /**
   * Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetTriggeredWebJobHistorySlot")
  getTriggeredWebJobHistorySlot is TriggeredJobHistoryOps.Read<TriggeredJobHistory>;

  /**
   * Description for List a triggered web job's history for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListTriggeredWebJobHistorySlot")
  listTriggeredWebJobHistorySlot is TriggeredJobHistoryOps.List<
    TriggeredJobHistory,
    Response = ArmResponse<TriggeredJobHistoryCollection>
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = TriggeredWebJob,
          KeyName = "webJobName",
          SegmentName = "triggeredwebjobs",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = TriggeredJobHistory,
        KeyName = "id",
        SegmentName = "history",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface TriggeredJobHistoryOperationGroup {
  /**
   * Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetTriggeredWebJobHistory")
  getTriggeredWebJobHistory is TriggeredJobHistoryOperationGroupOps.Read<TriggeredJobHistory>;

  /**
   * Description for List a triggered web job's history for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListTriggeredWebJobHistory")
  listTriggeredWebJobHistory is TriggeredJobHistoryOperationGroupOps.List<
    TriggeredJobHistory,
    Response = ArmResponse<TriggeredJobHistoryCollection>
  >;
}

@@doc(TriggeredJobHistory.name, "History ID.");
@@doc(TriggeredJobHistory.properties,
  "TriggeredJobHistory resource specific properties"
);
