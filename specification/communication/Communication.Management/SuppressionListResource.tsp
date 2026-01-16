import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A class representing a SuppressionList resource.
 */
@parentResource(DomainResource)
model SuppressionListResource
  is Azure.ResourceManager.ProxyResource<SuppressionListProperties> {
  ...ResourceNameParameter<
    Resource = SuppressionListResource,
    KeyName = "suppressionListName",
    SegmentName = "suppressionLists",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

@armResourceOperations
interface SuppressionLists {
  /**
   * Get a SuppressionList resource.
   */
  @summary("Get")
  get is ArmResourceRead<SuppressionListResource>;

  /**
   * Add a new SuppressionList resource under the parent Domains resource or update an existing SuppressionList resource.
   */
  @summary("Create Or Update")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListResource>;

  /**
   * Delete a SuppressionList.
   */
  @summary("Delete")
  delete is ArmResourceDeleteSync<SuppressionListResource>;

  /**
   * List all suppression lists for a domains resource.
   */
  @summary("List")
  listByDomain is ArmResourceListByParent<
    SuppressionListResource,
    Response = ArmResponse<SuppressionListResourceCollection>
  >;
}

@@maxLength(SuppressionListResource.name, 253);
@@minLength(SuppressionListResource.name, 1);
@@doc(SuppressionListResource.name, "The name of the suppression list.");
@@doc(SuppressionListResource.properties,
  "The properties of a SuppressionList resource."
);
@@doc(SuppressionLists.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
