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

namespace Microsoft.CertificateRegistration;
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
      },
      KeysOf<ResourceNameParameter<
        Resource = TriggeredWebJob,
        KeyName = "webJobName",
        SegmentName = "triggeredwebjobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface TriggeredWebJobs {
  /**
   * Description for Gets a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetTriggeredWebJobSlot")
  getTriggeredWebJobSlot is TriggeredWebJobOps.Read<TriggeredWebJob>;

  /**
   * Description for Delete a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteTriggeredWebJobSlot")
  deleteTriggeredWebJobSlot is TriggeredWebJobOps.DeleteSync<TriggeredWebJob>;

  /**
   * Description for List triggered web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListTriggeredWebJobsSlot")
  listTriggeredWebJobsSlot is TriggeredWebJobOps.List<
    TriggeredWebJob,
    Response = ArmResponse<TriggeredWebJobCollection>
  >;

  /**
   * Description for Run a triggered web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("run")
  @operationId("WebApps_RunTriggeredWebJobSlot")
  runTriggeredWebJobSlot is TriggeredWebJobOps.ActionSync<
    TriggeredWebJob,
    void,
    OkResponse
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = TriggeredWebJob,
        KeyName = "webJobName",
        SegmentName = "triggeredwebjobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface TriggeredWebJobOperationGroup {
  /**
   * Description for Gets a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetTriggeredWebJob")
  getTriggeredWebJob is TriggeredWebJobOperationGroupOps.Read<TriggeredWebJob>;

  /**
   * Description for Delete a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteTriggeredWebJob")
  deleteTriggeredWebJob is TriggeredWebJobOperationGroupOps.DeleteSync<TriggeredWebJob>;

  /**
   * Description for List triggered web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListTriggeredWebJobs")
  listTriggeredWebJobs is TriggeredWebJobOperationGroupOps.List<
    TriggeredWebJob,
    Response = ArmResponse<TriggeredWebJobCollection>
  >;

  /**
   * Description for Run a triggered web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("run")
  @operationId("WebApps_RunTriggeredWebJob")
  runTriggeredWebJob is TriggeredWebJobOperationGroupOps.ActionSync<
    TriggeredWebJob,
    void,
    OkResponse
  >;
}

@@doc(TriggeredWebJob.name, "Name of Web Job.");
@@doc(TriggeredWebJob.properties,
  "TriggeredWebJob resource specific properties"
);
