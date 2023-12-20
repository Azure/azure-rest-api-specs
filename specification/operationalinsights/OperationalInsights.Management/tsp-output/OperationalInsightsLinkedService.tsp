import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./OperationalInsightsWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("The top level Linked service resource container.")
@parentResource(OperationalInsightsWorkspace)
model OperationalInsightsLinkedService
  is ProxyResource<LinkedServiceProperties> {
  @doc("Name of the linked service.")
  @path
  @key("linkedServiceName")
  @segment("linkedServices")
  name: string;
}

@armResourceOperations
interface OperationalInsightsLinkedServices {
  @doc("Gets a linked service instance.")
  get is ArmResourceRead<OperationalInsightsLinkedService>;
  @doc("Create or update a linked service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OperationalInsightsLinkedService>;
  @doc("Deletes a linked service instance.")
  delete is ArmResourceDeleteAsync<OperationalInsightsLinkedService>;
  @doc("Gets the linked services instances in a workspace.")
  listByWorkspace is ArmResourceListByParent<OperationalInsightsLinkedService>;
}
