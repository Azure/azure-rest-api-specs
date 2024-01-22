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

namespace Microsoft.Insights;
/**
 * Definition of generic ARM proxy resource.
 */
model DataCollectionRuleAssociationProxyOnlyResource
  is ExtensionResource<DataCollectionRuleAssociationProxyOnlyResourceProperties> {
  /**
   * The name of the association. The name is case insensitive.
   */
  @path
  @key("associationName")
  @segment("dataCollectionRuleAssociations")
  name: string;

  /**
   * Resource entity tag (ETag).
   */
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface DataCollectionRuleAssociationProxyOnlyResources {
  /**
   * Returns the specified association.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_Get")
  get is ArmResourceRead<DataCollectionRuleAssociationProxyOnlyResource>;

  /**
   * Creates or updates an association.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_Create")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRuleAssociationProxyOnlyResource>;

  /**
   * Deletes an association.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_Delete")
  delete is ArmResourceDeleteSync<DataCollectionRuleAssociationProxyOnlyResource>;

  /**
   * Lists associations for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_ListByResource")
  listByResource is ArmResourceListByParent<DataCollectionRuleAssociationProxyOnlyResource>;
}

@@projectedName(DataCollectionRuleAssociationProxyOnlyResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(DataCollectionRuleAssociationProxyOnlyResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DataCollectionRuleAssociationProxyOnlyResources.create::parameters.resource,
  "The payload"
);
