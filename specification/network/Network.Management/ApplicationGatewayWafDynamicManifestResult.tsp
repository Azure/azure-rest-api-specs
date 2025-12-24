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
@Http.Private.includeInapplicableMetadataInPayload(false)
@singleton("dafault")
@subscriptionResource
model ApplicationGatewayWafDynamicManifestResult extends ProxyResource {
  /**
   * Properties of the ApplicationGatewayWafDynamicManifest.
   */
  properties?: ApplicationGatewayWafDynamicManifestPropertiesResult;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("applicationGatewayWafDynamicManifest")
  @segment("applicationGatewayWafDynamicManifests")
  name: string;
}

@@doc(ApplicationGatewayWafDynamicManifestResult.name, "Resource name.");

alias ApplicationGatewayWafDynamicManifestResultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The location for which the WAF dynamic manifest is requested. */
    @path
    @segment("locations")
    location: string;
  },
  {
    /** The name of the Application Gateway WAF Dynamic Manifest. */
    @path
    @segment("applicationGatewayWafDynamicManifests")
    @key
    applicationGatewayWafDynamicManifestName: "dafault";
  }
>;

@armResourceOperations
interface ApplicationGatewayWafDynamicManifestResults {
  /**
   * Gets the regional application gateway waf manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApplicationGatewayWafDynamicManifestsDefault_Get")
  get is ApplicationGatewayWafDynamicManifestResultOps.Read<ApplicationGatewayWafDynamicManifestResult, OverrideErrorType = CloudError>;

  /**
   * Gets the regional application gateway waf manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApplicationGatewayWafDynamicManifests_Get")
  applicationGatewayWafDynamicManifestsGet is ArmResourceListByParent<ApplicationGatewayWafDynamicManifestResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /** The location for which the WAF dynamic manifest is requested. */
      @path
      @segment("locations")
      location: string;
    },
    Response = ArmResponse<ApplicationGatewayWafDynamicManifestResultList>,
    Error = CloudError
  >;
}

@@doc(ApplicationGatewayWafDynamicManifestResult.name, "");
@@doc(ApplicationGatewayWafDynamicManifestResult.properties,
  "Properties of the ApplicationGatewayWafDynamicManifest ."
);
