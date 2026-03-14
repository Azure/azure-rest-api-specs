import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Data sensitivity settings for sensitive data discovery
 */
@singleton("current")
@tenantResource
model GetSensitivitySettingsResponse
  is Azure.ResourceManager.ProxyResource<GetSensitivitySettingsResponseProperties> {
  ...ResourceNameParameter<
    Resource = GetSensitivitySettingsResponse,
    KeyName = "sensitivitySetting",
    SegmentName = "sensitivitySettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GetSensitivitySettingsResponses {
  /**
   * Gets data sensitivity settings for sensitive data discovery
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SensitivitySettings_Get")
  get is ArmResourceRead<
    GetSensitivitySettingsResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create or update data sensitivity settings for sensitive data discovery
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SensitivitySettings_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    GetSensitivitySettingsResponse,
    Request = UpdateSensitivitySettingsRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<GetSensitivitySettingsResponse>
  >;

  /**
   * Gets a list with a single sensitivity settings resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SensitivitySettings_List")
  list is ArmResourceListByParent<
    GetSensitivitySettingsResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<GetSensitivitySettingsListResponse>
  >;
}

@@doc(GetSensitivitySettingsResponse.name, "");
@@doc(GetSensitivitySettingsResponse.properties,
  "The sensitivity settings properties"
);
@@doc(GetSensitivitySettingsResponses.createOrUpdate::parameters.resource,
  "The data sensitivity settings to update"
);
