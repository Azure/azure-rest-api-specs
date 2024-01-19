import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
@doc("Network function definition group resource.")
@parentResource(Publisher)
model NetworkFunctionDefinitionGroup
  is TrackedResource<NetworkFunctionDefinitionGroupPropertiesFormat> {
  @doc("The name of the network function definition group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("networkFunctionDefinitionGroupName")
  @segment("networkFunctionDefinitionGroups")
  name: string;
}

@armResourceOperations
interface NetworkFunctionDefinitionGroups {
  @doc("Gets information about the specified networkFunctionDefinition group.")
  get is ArmResourceRead<NetworkFunctionDefinitionGroup>;

  @doc("Creates or updates a network function definition group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NetworkFunctionDefinitionGroup,
    BaseParameters<NetworkFunctionDefinitionGroup>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a network function definition group resource.")
  update is ArmCustomPatchSync<NetworkFunctionDefinitionGroup, TagsObject>;

  @doc("Deletes a specified network function definition group.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunctionDefinitionGroup,
    BaseParameters<NetworkFunctionDefinitionGroup>,
    ArmLroLocationHeader
  >;

  @doc("Gets information of the network function definition groups under a publisher.")
  listByPublisher is ArmResourceListByParent<NetworkFunctionDefinitionGroup>;
}

@@projectedName(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update publisher network function definition group operation."
);
@@projectedName(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "Parameters supplied to the create or update publisher network function definition group operation."
);
