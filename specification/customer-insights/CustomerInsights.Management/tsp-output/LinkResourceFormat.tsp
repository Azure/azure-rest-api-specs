import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
@doc("The link resource format.")
@parentResource(Hub)
model LinkResourceFormat is ProxyResource<LinkDefinition> {
  @doc("The name of the link.")
  @path
  @key("linkName")
  @segment("links")
  name: string;
}

@armResourceOperations
interface LinkResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a link in the hub.")
  @operationId("Links_Get")
  get is ArmResourceRead<LinkResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a link or updates an existing link in the hub.")
  @operationId("Links_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LinkResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a link in the hub.")
  @operationId("Links_Delete")
  delete is ArmResourceDeleteSync<LinkResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the links in the specified hub.")
  @operationId("Links_ListByHub")
  listByHub is ArmResourceListByParent<LinkResourceFormat>;
}

@@projectedName(LinkResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Link operation."
);
