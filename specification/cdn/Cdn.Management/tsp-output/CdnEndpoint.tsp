import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * CDN endpoint is the entity within a CDN profile containing configuration information such as origin, protocol, content caching and delivery behavior. The CDN endpoint uses the URL format <endpointname>.azureedge.net.
 */
@parentResource(Profile)
model CdnEndpoint is TrackedResource<EndpointProperties> {
  /**
   * Name of the endpoint under the profile which is unique globally.
   */
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface CdnEndpoints {
  /**
   * Gets an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<CdnEndpoint>;

  /**
   * Creates a new CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  create is ArmResourceCreateOrReplaceAsync<CdnEndpoint>;

  /**
   * Updates an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile. Only tags can be updated after creating an endpoint. To update origins, use the Update Origin operation. To update origin groups, use the Update Origin group operation. To update custom domains, use the Update Custom Domain operation.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<CdnEndpoint, EndpointUpdateParameters>;

  /**
   * Deletes an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  delete is ArmResourceDeleteAsync<CdnEndpoint>;

  /**
   * Lists existing CDN endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CdnEndpoints_ListByProfile")
  listByProfile is ArmResourceListByParent<CdnEndpoint>;

  /**
   * Starts an existing CDN endpoint that is on a stopped state.
   */
  start is ArmResourceActionAsync<CdnEndpoint, void, CdnEndpoint>;

  /**
   * Stops an existing running CDN endpoint.
   */
  stop is ArmResourceActionAsync<CdnEndpoint, void, CdnEndpoint>;

  /**
   * Removes a content from CDN.
   */
  purgeContent is ArmResourceActionAsync<CdnEndpoint, PurgeParameters, void>;

  /**
   * Pre-loads a content to CDN. Available for Verizon Profiles.
   */
  loadContent is ArmResourceActionAsync<CdnEndpoint, LoadParameters, void>;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct CDN endpoint in DNS.
   */
  validateCustomDomain is ArmResourceActionSync<
    CdnEndpoint,
    ValidateCustomDomainContent,
    ValidateCustomDomainResult
  >;

  /**
   * Checks the quota and usage of geo filters and custom domains under the given endpoint.
   */
  listResourceUsage is ArmResourceActionSync<
    CdnEndpoint,
    void,
    ResourceUsageListResult
  >;
}

@@projectedName(CdnEndpoints.create::parameters.resource,
  "json",
  "endpointInput"
);
@@extension(CdnEndpoints.create::parameters.resource,
  "x-ms-client-name",
  "endpointInput"
);
@@doc(CdnEndpoints.create::parameters.resource, "Endpoint properties");
@@projectedName(CdnEndpoints.update::parameters.properties,
  "json",
  "endpointUpdateProperties"
);
@@extension(CdnEndpoints.update::parameters.properties,
  "x-ms-client-name",
  "endpointUpdateProperties"
);
@@doc(CdnEndpoints.update::parameters.properties, "Endpoint update properties");
@@projectedName(CdnEndpoints.purgeContent::parameters.body,
  "json",
  "contentFilePaths"
);
@@extension(CdnEndpoints.purgeContent::parameters.body,
  "x-ms-client-name",
  "contentFilePaths"
);
@@doc(CdnEndpoints.purgeContent::parameters.body,
  "The path to the content to be purged. Path can be a full URL, e.g. '/pictures/city.png' which removes a single file, or a directory with a wildcard, e.g. '/pictures/*' which removes all folders and files in the directory."
);
@@projectedName(CdnEndpoints.loadContent::parameters.body,
  "json",
  "contentFilePaths"
);
@@extension(CdnEndpoints.loadContent::parameters.body,
  "x-ms-client-name",
  "contentFilePaths"
);
@@doc(CdnEndpoints.loadContent::parameters.body,
  "The path to the content to be loaded. Path should be a full URL, e.g. ‘/pictures/city.png' which loads a single file "
);
@@projectedName(CdnEndpoints.validateCustomDomain::parameters.body,
  "json",
  "customDomainProperties"
);
@@extension(CdnEndpoints.validateCustomDomain::parameters.body,
  "x-ms-client-name",
  "customDomainProperties"
);
@@doc(CdnEndpoints.validateCustomDomain::parameters.body,
  "Custom domain to be validated."
);
