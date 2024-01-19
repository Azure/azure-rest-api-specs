import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
@doc("The top level Linked service resource container.")
@parentResource(Workspace)
model LinkedService is ProxyResource<LinkedServiceProperties> {
  @doc("Name of the linked service.")
  @path
  @key("linkedServiceName")
  @segment("linkedServices")
  name: string;
}

@armResourceOperations
interface LinkedServices {
  @doc("Gets a linked service instance.")
  get is ArmResourceRead<LinkedService>;

  @doc("Create or update a linked service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LinkedService>;

  @doc("Deletes a linked service instance.")
  delete is ArmResourceDeleteAsync<LinkedService>;

  @doc("Gets the linked services instances in a workspace.")
  listByWorkspace is ArmResourceListByParent<LinkedService>;
}

@@projectedName(LinkedServices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkedServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkedServices.createOrUpdate::parameters.resource,
  "The parameters required to create or update a linked service."
);
