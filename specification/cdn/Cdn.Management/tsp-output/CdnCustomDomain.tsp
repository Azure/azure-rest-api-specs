import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CdnEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly domain name mapping to the endpoint hostname that the customer provides for branding purposes, e.g. www.contoso.com.
 */
@parentResource(CdnEndpoint)
model CdnCustomDomain is ProxyResource<CustomDomainProperties> {
  /**
   * Name of the custom domain within an endpoint.
   */
  @path
  @key("customDomainName")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface CdnCustomDomains {
  /**
   * Gets an existing custom domain within an endpoint.
   */
  get is ArmResourceRead<CdnCustomDomain>;

  /**
   * Creates a new custom domain within an endpoint.
   */
  create is ArmResourceCreateOrReplaceAsync<CdnCustomDomain>;

  /**
   * Deletes an existing custom domain within an endpoint.
   */
  delete is ArmResourceDeleteAsync<CdnCustomDomain>;

  /**
   * Lists all of the existing custom domains within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CdnCustomDomains_ListByEndpoint")
  listByEndpoint is ArmResourceListByParent<CdnCustomDomain>;

  /**
   * Disable https delivery of the custom domain.
   */
  disableCustomHttps is ArmResourceActionAsync<
    CdnCustomDomain,
    void,
    CdnCustomDomain
  >;

  /**
   * Enable https delivery of the custom domain.
   */
  enableCustomHttps is ArmResourceActionAsync<
    CdnCustomDomain,
    CustomDomainHttpsParameters,
    CdnCustomDomain
  >;
}

@@projectedName(CdnCustomDomains.create::parameters.resource,
  "json",
  "customDomainProperties"
);
@@extension(CdnCustomDomains.create::parameters.resource,
  "x-ms-client-name",
  "customDomainProperties"
);
@@doc(CdnCustomDomains.create::parameters.resource,
  "Properties required to create a new custom domain."
);
@@projectedName(CdnCustomDomains.enableCustomHttps::parameters.body,
  "json",
  "customDomainHttpsParameters"
);
@@extension(CdnCustomDomains.enableCustomHttps::parameters.body,
  "x-ms-client-name",
  "customDomainHttpsParameters"
);
@@doc(CdnCustomDomains.enableCustomHttps::parameters.body,
  "The configuration specifying how to enable HTTPS for the custom domain - using CDN managed certificate or user's own certificate. If not specified, enabling ssl uses CDN managed certificate by default."
);
