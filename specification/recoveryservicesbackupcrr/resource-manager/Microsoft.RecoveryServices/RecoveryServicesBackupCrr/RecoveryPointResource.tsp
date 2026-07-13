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
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "Backward compatibility with existing 2023-01-15 CRR API path structure."
@parentResource(ProtectedItemVirtualResource)
model RecoveryPointResource is ProxyResource<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Optional location"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: Azure.Core.azureLocation;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  eTag?: string;
}

@armResourceOperations
@tag("RecoveryPoints_Crr")
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
  @extension("x-ms-odata", "#/definitions/BMSRPQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
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
}

@armResourceOperations
@tag("RecoveryPoints_GetAccessToken")
interface RecoveryPointGetAccessToken {
  /**
   * Returns the Access token for communication between BMS and Protection service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecoveryPoints_GetAccessToken")
  @action("accessToken")
  getAccessToken is ArmResourceActionSync<
    RecoveryPointResource,
    AADPropertiesResource,

      | ArmResponse<CrrAccessTokenResource>
      | {
          @doc("BadRequest")
          @statusCode
          statusCode: 400;
        }
  >;
}

@@doc(RecoveryPointResource.name, "Recovery Point Id");
@@doc(RecoveryPointResource.properties, "RecoveryPointResource properties");
@@doc(
  RecoveryPointGetAccessToken.getAccessToken::parameters.body,
  "Get Access Token request"
);
