import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
model RecoveryPointResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  eTag?: string;
}

@armResourceOperations
interface RecoveryPointResources {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecoveryPointsCrr_Get")
  get is ArmResourceRead<RecoveryPointResource>;

  /**
   * Lists the backup copies for the backed up item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecoveryPointsCrr_List")
  list is ArmResourceListByParent<
    RecoveryPointResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RecoveryPointResourceList>
  >;

  /**
   * Returns the Access token for communication between BMS and Protection service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecoveryPoints_GetAccessToken")
  @action("accessToken")
  getAccessToken is ArmResourceActionSync<
    RecoveryPointResource,
    AADPropertiesResource,
    ArmResponse<CrrAccessTokenResource>
  >;
}

@@doc(
  RecoveryPointResource.name,
  "RecoveryPointID represents the backed up data to be fetched."
);
@@doc(RecoveryPointResource.properties, "RecoveryPointResource properties");
@@doc(
  RecoveryPointResources.getAccessToken::parameters.body,
  "Get Access Token request"
);
