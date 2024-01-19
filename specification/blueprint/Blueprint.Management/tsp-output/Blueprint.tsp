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

namespace Microsoft.Blueprint;
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PublishedBlueprints_List")
  @doc("List published versions of given blueprint definition.")
  // FIXME: PublishedBlueprints_List could not be converted to a resource operation
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions")
  @get
  list is Azure.Core.Foundations.Operation<
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

@@projectedName(Blueprints.createOrUpdate::parameters.resource,
  "json",
  "blueprint"
);
@@extension(Blueprints.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "blueprint"
);
@@doc(Blueprints.createOrUpdate::parameters.resource, "Blueprint definition.");
