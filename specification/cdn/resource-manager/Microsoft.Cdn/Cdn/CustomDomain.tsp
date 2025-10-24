import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Endpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly domain name mapping to the endpoint hostname that the customer provides for branding purposes, e.g. www.contoso.com.
 */
@parentResource(Endpoint)
model CustomDomain
  is Azure.ResourceManager.ProxyResource<CustomDomainProperties> {
  ...ResourceNameParameter<
    Resource = CustomDomain,
    KeyName = "customDomainName",
    SegmentName = "customDomains",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CustomDomains {
  /**
   * Gets an existing custom domain within an endpoint.
   */
  get is ArmResourceRead<CustomDomain>;

  /**
   * Creates a new custom domain within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  create is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      CustomDomain,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<CustomDomain>
    >,
    CustomDomainParameters,
    Response = ArmResourceUpdatedResponse<CustomDomain> | ArmResourceCreatedResponse<
      CustomDomain,
      ArmLroLocationHeader<FinalResult = CustomDomain> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CustomDomain>> & {
      @bodyRoot
      _: CustomDomain;
    }),
    ErrorResponse = ErrorResponse
  >;

  /**
   * Deletes an existing custom domain within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomDomain,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> & {
      @bodyRoot
      _: CustomDomain;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing custom domains within an endpoint.
   */
  @list
  listByEndpoint is ArmResourceListByParent<CustomDomain>;

  /**
   * Disable https delivery of the custom domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableCustomHttps is ArmResourceActionAsyncBase<
    CustomDomain,
    void,
    ArmResponse<CustomDomain> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CustomDomain>> & {
      @bodyRoot
      _: CustomDomain;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<CustomDomain>
  >;

  /**
   * Enable https delivery of the custom domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableCustomHttps is ArmResourceActionAsyncBase<
    CustomDomain,
    CustomDomainHttpsParameters,
    ArmResponse<CustomDomain> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CustomDomain>> & {
      @bodyRoot
      _: CustomDomain;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<CustomDomain>,
    OptionalRequestBody = true
  >;
}

@@doc(CustomDomain.name, "Name of the custom domain within an endpoint.");
@@doc(CustomDomain.properties,
  "The JSON object that contains the properties of the custom domain to create."
);
@@doc(CustomDomains.create::parameters.resource,
  "Properties required to create a new custom domain."
);
@@doc(CustomDomains.enableCustomHttps::parameters.body,
  "The configuration specifying how to enable HTTPS for the custom domain - using CDN managed certificate or user's own certificate. If not specified, enabling ssl uses CDN managed certificate by default."
);
