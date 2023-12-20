import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Blueprint;
@doc("Represents a Blueprint definition.")
model Blueprint is ExtensionResource<BlueprintProperties> {
  @doc("Name of the blueprint definition.")
  @path
  @key("blueprintName")
  @segment("blueprints")
  name: string;
}

@armResourceOperations
interface Blueprints {
  @doc("Get a blueprint definition.")
  get is ArmResourceRead<Blueprint>;
  @doc("Create or update a blueprint definition.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Blueprint>;
  @doc("Delete a blueprint definition.")
  delete is ArmResourceDeleteSync<Blueprint>;
  @doc("List blueprint definitions.")
  list is ArmResourceListByParent<Blueprint>;
  @doc("List published versions of given blueprint definition.")
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The scope of the resource. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}').")
      @path
      resourceScope: string;

      @doc("Name of the blueprint definition.")
      @path
      blueprintName: string;
    },
    PublishedBlueprintList
  >;
}
