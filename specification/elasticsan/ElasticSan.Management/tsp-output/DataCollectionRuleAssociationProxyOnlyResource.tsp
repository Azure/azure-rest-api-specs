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
@doc("Definition of generic ARM proxy resource.")
model DataCollectionRuleAssociationProxyOnlyResource
  is ExtensionResource<DataCollectionRuleAssociationProxyOnlyResourceProperties> {
  @doc("The name of the association. The name is case insensitive.")
  @path
  @key("associationName")
  @segment("dataCollectionRuleAssociations")
  name: string;

  @doc("Resource entity tag (ETag).")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface DataCollectionRuleAssociationProxyOnlyResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the specified association.")
  @operationId("DataCollectionRuleAssociations_Get")
  get is ArmResourceRead<DataCollectionRuleAssociationProxyOnlyResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an association.")
  @operationId("DataCollectionRuleAssociations_Create")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRuleAssociationProxyOnlyResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an association.")
  @operationId("DataCollectionRuleAssociations_Delete")
  delete is ArmResourceDeleteSync<DataCollectionRuleAssociationProxyOnlyResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists associations for the specified resource.")
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
