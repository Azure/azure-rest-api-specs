import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ConfigurationModel.tsp";
import "./ConfigurationType.tsp";
import "./ProvisioningState.tsp";
import "./Schema.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("DynamicSchema Properties")
model DynamicSchemaProperties {
  @doc("Type of configuration")
  @visibility(Lifecycle.Read)
  configurationType?: ConfigurationType;

  @doc("Type of configuration model")
  @visibility(Lifecycle.Read)
  configurationModel?: ConfigurationModel;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("DynamicSchema Resource")
@parentResource(Schema)
model DynamicSchema is ProxyResource<DynamicSchemaProperties> {
  @doc("The name of the DynamicSchema")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("dynamicSchemaName")
  @segment("dynamicSchemas")
  name: string;

  ...EntityTagProperty;
}

@armResourceOperations
interface DynamicSchemas {
  @doc("Get a DynamicSchema Resource")
  get is ArmResourceRead<DynamicSchema>;

  @doc("Create or update a DynamicSchema Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DynamicSchema>;

  @doc("update a DynamicSchema Resource")
  update is ArmResourcePatchSync<DynamicSchema, DynamicSchemaProperties>;

  @doc("Delete a DynamicSchema Resource")
  delete is ArmResourceDeleteWithoutOkAsync<DynamicSchema>;

  @doc("List by Schema")
  listBySchema is ArmResourceListByParent<DynamicSchema>;
}
