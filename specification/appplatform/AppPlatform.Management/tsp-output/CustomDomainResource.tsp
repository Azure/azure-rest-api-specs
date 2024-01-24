import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Custom domain resource payload.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AppResource)
@Azure.ResourceManager.Private.armResourceInternal(CustomDomainProperties)
@includeInapplicableMetadataInPayload(false)
model CustomDomainResource extends ProxyResource {
  /**
   * The name of the custom domain resource.
   */
  @path
  @key("domainName")
  @segment("domains")
  name: string;

  /**
   * Properties of the custom domain resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CustomDomainProperties;
}

@armResourceOperations
interface CustomDomainResources {
  /**
   * Get the custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CustomDomains_Get")
  get is ArmResourceRead<CustomDomainResource>;

  /**
   * Create or update custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CustomDomainResource>;

  /**
   * Update custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("CustomDomains_Update")
  update is ArmCustomPatchAsync<CustomDomainResource, CustomDomainResource>;

  /**
   * Delete the custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CustomDomains_Delete")
  delete is ArmResourceDeleteAsync<CustomDomainResource>;

  /**
   * List the custom domains of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CustomDomains_List")
  list is ArmResourceListByParent<CustomDomainResource>;
}

@@projectedName(CustomDomainResources.createOrUpdate::parameters.resource,
  "json",
  "domainResource"
);
@@extension(CustomDomainResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "domainResource"
);
@@doc(CustomDomainResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(CustomDomainResources.update::parameters.properties,
  "json",
  "domainResource"
);
@@extension(CustomDomainResources.update::parameters.properties,
  "x-ms-client-name",
  "domainResource"
);
@@doc(CustomDomainResources.update::parameters.properties,
  "Parameters for the create or update operation"
);
