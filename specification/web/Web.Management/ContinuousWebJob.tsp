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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ContinuousWebJob,
        KeyName = "webJobName",
        SegmentName = "continuouswebjobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ContinuousWebJobs {
  /**
   * Description for Gets a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetContinuousWebJob")
  getContinuousWebJob is ContinuousWebJobOps.Read<ContinuousWebJob>;

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
  @action("start")
  @operationId("WebApps_StartContinuousWebJob")
  startContinuousWebJob is ContinuousWebJobOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("stop")
  @operationId("WebApps_StopContinuousWebJob")
  stopContinuousWebJob is ContinuousWebJobOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse
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
        Resource = ContinuousWebJob,
        KeyName = "webJobName",
        SegmentName = "continuouswebjobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ContinuousWebJobOperationGroup {
  /**
   * Description for Gets a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetContinuousWebJobSlot")
  getContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.Read<ContinuousWebJob>;

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
  @action("start")
  @operationId("WebApps_StartContinuousWebJobSlot")
  startContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("stop")
  @operationId("WebApps_StopContinuousWebJobSlot")
  stopContinuousWebJobSlot is ContinuousWebJobOperationGroupOps.ActionSync<
    ContinuousWebJob,
    void,
    OkResponse
  >;
}

@@doc(ContinuousWebJob.name, "Name of Web Job.");
@@doc(ContinuousWebJob.properties,
  "ContinuousWebJob resource specific properties"
);
