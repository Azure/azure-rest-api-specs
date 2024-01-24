import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A custom domain
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SignalRResource)
@Azure.ResourceManager.Private.armResourceInternal(CustomDomainProperties)
@includeInapplicableMetadataInPayload(false)
model CustomDomain extends ProxyResourceBase {
  /**
   * Custom domain name.
   */
  @path
  @key("name")
  @segment("customDomains")
  name: string;

  /**
   * Properties of a custom domain.
   */
  @extension("x-ms-client-flatten", true)
  properties: CustomDomainProperties;
}

@armResourceOperations
interface CustomDomains {
  /**
   * Get a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomDomains_Get")
  get is ArmResourceRead<CustomDomain>;

  /**
   * Create or update a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CustomDomain>;

  /**
   * Delete a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<CustomDomain>;

  /**
   * List all custom domains.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomDomains_List")
  list is ArmResourceListByParent<CustomDomain>;
}

@@projectedName(CustomDomains.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(CustomDomains.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CustomDomains.createOrUpdate::parameters.resource, "");
