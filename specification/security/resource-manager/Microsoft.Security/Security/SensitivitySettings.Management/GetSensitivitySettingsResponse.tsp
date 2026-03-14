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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface GetSensitivitySettingsResponses {
  /**
   * Gets data sensitivity settings for sensitive data discovery
   */
  @tag("sensitivitySettings")
  get is ArmResourceRead<
    GetSensitivitySettingsResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = CloudError
  >;

  /**
   * Create or update data sensitivity settings for sensitive data discovery
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("sensitivitySettings")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    GetSensitivitySettingsResponse,
    Request = UpdateSensitivitySettingsRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<GetSensitivitySettingsResponse>,
    Error = CloudError
  >;

  /**
   * Gets a list with a single sensitivity settings resource
   */
  list is ArmResourceListByParent<
    GetSensitivitySettingsResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<GetSensitivitySettingsListResponse>,
    Error = CloudError
  >;
}

@@doc(GetSensitivitySettingsResponse.name, "");
@@doc(GetSensitivitySettingsResponse.properties,
  "The sensitivity settings properties"
);
@@doc(GetSensitivitySettingsResponses.createOrUpdate::parameters.resource,
  "The data sensitivity settings to update"
);
