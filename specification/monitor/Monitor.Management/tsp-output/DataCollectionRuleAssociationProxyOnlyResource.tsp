import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("Definition of generic ARM proxy resource.")
model DataCollectionRuleAssociationProxyOnlyResource
  is ExtensionResource<DataCollectionRuleAssociationProxyOnlyResourceProperties> {
  @doc("The name of the association. The name is case insensitive.")
  @key("associationName")
  @segment("dataCollectionRuleAssociations")
  name: string;

  @doc("Resource entity tag (ETag).")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface DataCollectionRuleAssociations {
  @doc("Returns the specified association.")
  get is ArmResourceRead<DataCollectionRuleAssociationProxyOnlyResource>;
  @doc("Creates or updates an association.")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRuleAssociationProxyOnlyResource>;
  @doc("Deletes an association.")
  delete is ArmResourceDeleteSync<DataCollectionRuleAssociationProxyOnlyResource>;
  @doc("Lists associations for the specified resource.")
  listByResource is ArmResourceListByParent<DataCollectionRuleAssociationProxyOnlyResource>;
}
