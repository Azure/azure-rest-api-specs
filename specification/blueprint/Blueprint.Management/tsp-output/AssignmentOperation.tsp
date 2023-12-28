import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Assignment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Blueprint;
@doc("Represents underlying deployment detail for each update to the blueprint assignment.")
@parentResource(Assignment)
model AssignmentOperation is ProxyResource<AssignmentOperationProperties> {
  @doc("Name of the blueprint assignment operation.")
  @key("assignmentOperationName")
  @segment("assignmentOperations")
  name: string;
}

@armResourceOperations
interface AssignmentOperations {
  @doc("Get a blueprint assignment operation.")
  get is ArmResourceRead<AssignmentOperation>;
  @doc("List operations for given blueprint assignment within a subscription or a management group.")
  list is ArmResourceListByParent<AssignmentOperation>;
}
