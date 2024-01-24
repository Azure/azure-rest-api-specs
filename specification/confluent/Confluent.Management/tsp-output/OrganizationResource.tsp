import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Confluent;
/**
 * Organization resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  OrganizationResourceProperties
)
@includeInapplicableMetadataInPayload(false)
model OrganizationResource extends TrackedResourceBase {
  /**
   * Organization resource name
   */
  @path
  @key("organizationName")
  @segment("organizations")
  name: string;

  /**
   * Organization resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties: OrganizationResourceProperties;
}

@armResourceOperations
interface OrganizationResources {
  /**
   * Get the properties of a specific Organization resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Organization_Get")
  get is ArmResourceRead<OrganizationResource>;

  /**
   * Create Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Organization_Create")
  create is ArmResourceCreateOrReplaceAsync<
    OrganizationResource,
    BaseParameters<OrganizationResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Organization_Update")
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;

  /**
   * Delete Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Organization_Delete")
  delete is ArmResourceDeleteAsync<
    OrganizationResource,
    BaseParameters<OrganizationResource>,
    ArmLroLocationHeader
  >;

  /**
   * List all Organizations under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Organization_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;

  /**
   * List all organizations under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Organization_ListBySubscription")
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}

@@projectedName(OrganizationResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(OrganizationResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(OrganizationResources.create::parameters.resource,
  "Organization resource model"
);
@@projectedName(OrganizationResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(OrganizationResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(OrganizationResources.update::parameters.properties,
  "Updated Organization resource"
);
