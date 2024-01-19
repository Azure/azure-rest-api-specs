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
@doc("Represents a blueprint assignment.")
model Assignment is ExtensionResource<AssignmentProperties> {
  @doc("Name of the blueprint assignment.")
  @path
  @key("assignmentName")
  @segment("blueprintAssignments")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Assignments {
  @doc("Get a blueprint assignment.")
  get is ArmResourceRead<Assignment>;

  @doc("Create or update a blueprint assignment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Assignment>;

  @doc("Delete a blueprint assignment.")
  delete is ArmResourceDeleteSync<
    Assignment,
    {
      ...BaseParameters<Assignment>;

      @doc("When deleteBehavior=all, the resources that were created by the blueprint assignment will be deleted.")
      @query("deleteBehavior")
      deleteBehavior?: AssignmentDeleteBehavior;
    }
  >;

  @doc("List blueprint assignments within a subscription or a management group.")
  list is ArmResourceListByParent<Assignment>;

  @doc("Get Blueprints service SPN objectId")
  whoIsBlueprint is ArmResourceActionSync<
    Assignment,
    void,
    WhoIsBlueprintContract
  >;
}

@@projectedName(Assignments.createOrUpdate::parameters.resource,
  "json",
  "assignment"
);
@@extension(Assignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "assignment"
);
@@doc(Assignments.createOrUpdate::parameters.resource,
  "Blueprint assignment object to save."
);
