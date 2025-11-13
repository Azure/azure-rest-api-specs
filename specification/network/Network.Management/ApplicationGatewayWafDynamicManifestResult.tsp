import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Response for ApplicationGatewayWafDynamicManifest API service call.
 */
@singleton("dafault")
@subscriptionResource
model ApplicationGatewayWafDynamicManifestResult
  is Azure.ResourceManager.ProxyResource<ApplicationGatewayWafDynamicManifestPropertiesResult> {
  ...ResourceNameParameter<
    Resource = ApplicationGatewayWafDynamicManifestResult,
    KeyName = "applicationGatewayWafDynamicManifest",
    SegmentName = "applicationGatewayWafDynamicManifests",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ApplicationGatewayWafDynamicManifestResults {
  /**
   * Gets the regional application gateway waf manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGatewayWafDynamicManifestsDefault_Get")
  get is ArmResourceRead<
    ApplicationGatewayWafDynamicManifestResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets the regional application gateway waf manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGatewayWafDynamicManifests_Get")
  applicationGatewayWafDynamicManifestsGet is ArmResourceListByParent<
    ApplicationGatewayWafDynamicManifestResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<ApplicationGatewayWafDynamicManifestResultList>
  >;
}

@@doc(ApplicationGatewayWafDynamicManifestResult.name, "");
@@doc(ApplicationGatewayWafDynamicManifestResult.properties,
  "Properties of the ApplicationGatewayWafDynamicManifest ."
);
