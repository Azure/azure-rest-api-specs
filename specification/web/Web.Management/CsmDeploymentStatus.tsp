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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface CsmDeploymentStatusOps
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
        /** GUID of the deployment operation. */
        @path
        @segment("deploymentStatus")
        @key
        deploymentStatusId: string,
      }
    > {}

@armResourceOperations
interface CsmDeploymentStatuses {
  /**
   * Gets the deployment status for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the deployment status for an app (or deployment slot, if specified).")
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  getProductionSiteDeploymentStatus is CsmDeploymentStatusOps.Read<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatus> | (ArmAcceptedResponse & {
      @bodyRoot
      _: CsmDeploymentStatus;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * List deployment statuses for an app (or deployment slot, if specified).
   */
  @summary("List deployment statuses for an app (or deployment slot, if specified).")
  listProductionSiteDeploymentStatuses is CsmDeploymentStatusOps.List<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatusCollection>,
    OverrideErrorType = DefaultErrorResponse
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

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get the deployment status for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** GUID of the deployment operation. */
        @path
        @segment("deploymentStatus")
        @key
        deploymentStatusId: string,
      }
    > {}

@armResourceOperations
interface CsmDeploymentStatusOperationGroup {
  /**
   * Gets the deployment status for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the deployment status for an app (or deployment slot, if specified).")
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  getSlotSiteDeploymentStatusSlot is CsmDeploymentStatusOperationGroupOps.Read<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatus> | (ArmAcceptedResponse & {
      @bodyRoot
      _: CsmDeploymentStatus;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * List deployment statuses for an app (or deployment slot, if specified).
   */
  @summary("List deployment statuses for an app (or deployment slot, if specified).")
  listSlotSiteDeploymentStatusesSlot is CsmDeploymentStatusOperationGroupOps.List<
    CsmDeploymentStatus,
    Response = ArmResponse<CsmDeploymentStatusCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(CsmDeploymentStatus.name, "GUID of the deployment operation.");
@@doc(CsmDeploymentStatus.properties,
  "CsmDeploymentStatus resource specific properties"
);
