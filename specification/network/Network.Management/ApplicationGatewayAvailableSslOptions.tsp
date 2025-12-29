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
 * Response for ApplicationGatewayAvailableSslOptions API service call.
 */
@singleton("default")
@subscriptionResource
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationGatewayAvailableSslOptions extends Resource {
  properties?: ApplicationGatewayAvailableSslOptionsPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("applicationGatewayAvailableSslOption")
  @segment("applicationGatewayAvailableSslOptions")
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name: string;
}

alias ApplicationGatewayAvailableSslOptionsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the application gateway available ssl option. */
    @path
    @segment("applicationGatewayAvailableSslOptions")
    @key
    applicationGatewayAvailableSslOption: "default";
  },
  {
    /** The name of the ssl predefined policy. */
    @path
    @segment("predefinedPolicies")
    @key
    predefinedPolicyName: string;
  }
>;

@armResourceOperations
interface ApplicationGatewayAvailableSslOptionsOperationGroup {
  /**
   * Lists available Ssl options for configuring Ssl policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApplicationGateways_ListAvailableSslOptions")
  listAvailableSslOptions is ArmResourceRead<
    ApplicationGatewayAvailableSslOptions,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Lists all SSL predefined policies for configuring Ssl policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApplicationGateways_ListAvailableSslPredefinedPolicies")
  @list
  @get
  @action("predefinedPolicies")
  listAvailableSslPredefinedPolicies is ArmResourceActionSync<
    ApplicationGatewayAvailableSslOptions,
    void,
    ArmResponse<ApplicationGatewayAvailableSslPredefinedPolicies>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Gets Ssl predefined policy with the specified policy name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApplicationGateways_GetSslPredefinedPolicy")
  @get
  getSslPredefinedPolicy is ApplicationGatewayAvailableSslOptionsOps.Read<
    ApplicationGatewayAvailableSslOptions,
    Response = ArmResponse<ApplicationGatewaySslPredefinedPolicy>,
    OverrideErrorType = CloudError
  >;
}

@@doc(ApplicationGatewayAvailableSslOptions.name, "");
@@doc(ApplicationGatewayAvailableSslOptions.properties,
  "Properties of the application gateway available SSL options."
);
