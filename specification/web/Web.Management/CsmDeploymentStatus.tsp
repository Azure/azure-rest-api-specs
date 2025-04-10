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
 * Deployment status response payload.
 */
@parentResource(Site)
model CsmDeploymentStatus
  is Azure.ResourceManager.ProxyResource<CsmDeploymentStatusProperties> {
  ...ResourceNameParameter<
    Resource = CsmDeploymentStatus,
    KeyName = "deploymentStatusId",
    SegmentName = "deploymentStatus",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CsmDeploymentStatusOps
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
        Resource = CsmDeploymentStatus,
        KeyName = "deploymentStatusId",
        SegmentName = "deploymentStatus",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface CsmDeploymentStatuses {
  /**
   * Gets the deployment status for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetProductionSiteDeploymentStatus")
  getProductionSiteDeploymentStatus is CsmDeploymentStatusOps.Read<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatus> | (AcceptedResponse & {
      @bodyRoot
      _: CsmDeploymentStatus;
    })
  >;

  /**
   * List deployment statuses for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListProductionSiteDeploymentStatuses")
  listProductionSiteDeploymentStatuses is CsmDeploymentStatusOps.List<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatusCollection>
  >;
}
@armResourceOperations
interface CsmDeploymentStatusOperationGroupOps
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
        Resource = CsmDeploymentStatus,
        KeyName = "deploymentStatusId",
        SegmentName = "deploymentStatus",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface CsmDeploymentStatusOperationGroup {
  /**
   * Gets the deployment status for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSlotSiteDeploymentStatusSlot")
  getSlotSiteDeploymentStatusSlot is CsmDeploymentStatusOperationGroupOps.Read<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatus> | (AcceptedResponse & {
      @bodyRoot
      _: CsmDeploymentStatus;
    })
  >;

  /**
   * List deployment statuses for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSlotSiteDeploymentStatusesSlot")
  listSlotSiteDeploymentStatusesSlot is CsmDeploymentStatusOperationGroupOps.List<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatusCollection>
  >;
}

@@doc(CsmDeploymentStatus.name, "GUID of the deployment operation.");
@@doc(CsmDeploymentStatus.properties,
  "CsmDeploymentStatus resource specific properties"
);
