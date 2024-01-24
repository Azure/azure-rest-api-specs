import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A class representing a SuppressionList resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DomainResource)
@Azure.ResourceManager.Private.armResourceInternal(SuppressionListProperties)
@includeInapplicableMetadataInPayload(false)
model SuppressionListResource extends ProxyResourceBase {
  /**
   * The name of the suppression list.
   */
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("suppressionListName")
  @segment("suppressionLists")
  name: string;

  /**
   * The properties of a SuppressionList resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SuppressionListProperties;
}

@armResourceOperations
interface SuppressionListResources {
  /**
   * Get a SuppressionList resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionLists_Get")
  get is ArmResourceRead<SuppressionListResource>;

  /**
   * Add a new SuppressionList resource under the parent Domains resource or update an existing SuppressionList resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionLists_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListResource>;

  /**
   * Delete a SuppressionList.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionLists_Delete")
  delete is ArmResourceDeleteSync<SuppressionListResource>;

  /**
   * List all suppression lists for a domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionLists_ListByDomain")
  listByDomain is ArmResourceListByParent<SuppressionListResource>;
}

@@projectedName(SuppressionListResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SuppressionListResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SuppressionListResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
