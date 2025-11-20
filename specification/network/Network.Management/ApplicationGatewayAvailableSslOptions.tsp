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
model ApplicationGatewayAvailableSslOptions
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationGatewayAvailableSslOptionsPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ApplicationGatewayAvailableSslOptions,
    KeyName = "applicationGatewayAvailableSslOption",
    SegmentName = "applicationGatewayAvailableSslOptions",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_ListAvailableSslOptions")
  listAvailableSslOptions is ArmResourceRead<
    ApplicationGatewayAvailableSslOptions,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Lists all SSL predefined policies for configuring Ssl policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_ListAvailableSslPredefinedPolicies")
  @list
  @get
  @action("predefinedPolicies")
  listAvailableSslPredefinedPolicies is ArmResourceActionSync<
    ApplicationGatewayAvailableSslOptions,
    void,
    ArmResponse<ApplicationGatewayAvailableSslPredefinedPolicies>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets Ssl predefined policy with the specified policy name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_GetSslPredefinedPolicy")
  @get
  getSslPredefinedPolicy is ApplicationGatewayAvailableSslOptionsOps.Read<
    ApplicationGatewayAvailableSslOptions,
    Response = ArmResponse<ApplicationGatewaySslPredefinedPolicy>
  >;
}

@@doc(ApplicationGatewayAvailableSslOptions.name, "");
@@doc(ApplicationGatewayAvailableSslOptions.properties,
  "Properties of the application gateway available SSL options."
);
