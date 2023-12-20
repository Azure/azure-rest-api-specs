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
model DataCollectionRuleAssociation
  is ExtensionResource<DataCollectionRuleAssociationProxyOnlyResourceProperties> {
  @doc("The name of the association. The name is case insensitive.")
  @path
  @key("associationName")
  @segment("dataCollectionRuleAssociations")
  name: string;
}

@armResourceOperations
interface DataCollectionRuleAssociations {
  @doc("Returns the specified association.")
  get is ArmResourceRead<DataCollectionRuleAssociation>;
  @doc("Creates or updates an association.")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRuleAssociation>;
  @doc("Deletes an association.")
  delete is ArmResourceDeleteSync<DataCollectionRuleAssociation>;
  @doc("Lists associations for the specified resource.")
  listByResource is ArmResourceListByParent<DataCollectionRuleAssociation>;
}
