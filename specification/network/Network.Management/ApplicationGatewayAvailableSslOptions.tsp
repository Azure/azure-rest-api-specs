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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@singleton("default")
@subscriptionResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ApplicationGatewayAvailableSslOptions extends Resource {
  properties?: ApplicationGatewayAvailableSslOptionsPropertiesFormat;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @path
  @key("applicationGatewayAvailableSslOption")
  @segment("applicationGatewayAvailableSslOptions")
  name: string;
}

alias ApplicationGatewayAvailableSslOptionsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
  },
  {
    /** The name of the ssl predefined policy. */
    @path
    @segment("predefinedPolicies")
    @key
    predefinedPolicyName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/{applicationGatewayAvailableSslOption}/predefinedPolicies",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ApplicationGatewayAvailableSslOptionsOperationGroup {
  /**
   * Lists available Ssl options for configuring Ssl policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApplicationGateways_ListAvailableSslOptions")
  @autoRoute
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
  @autoRoute
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
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}")
  getSslPredefinedPolicy is ApplicationGatewayAvailableSslOptionsOps.ActionSync<
    ApplicationGatewayAvailableSslOptions,
    void,
    Response = ArmResponse<ApplicationGatewaySslPredefinedPolicy>,
    OverrideErrorType = CloudError
  >;
}

@@doc(ApplicationGatewayAvailableSslOptions.name, "");
@@doc(ApplicationGatewayAvailableSslOptions.properties,
  "Properties of the application gateway available SSL options."
);
