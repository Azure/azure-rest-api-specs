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
  @visibility("read")
  configurationType?: ConfigurationType;

  @doc("Type of configuration model")
  @visibility("read")
  configurationModel?: ConfigurationModel;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("DynamicSchema Resource")
@parentResource(Schema)
model DynamicSchema is ProxyResource<DynamicSchemaProperties> {
  ...ResourceNameParameter<DynamicSchema>;
}

@armResourceOperations
interface DynamicSchemas {
  @doc("Get a DynamicSchema Resource")
  get is ArmResourceRead<DynamicSchema>;

  @doc("List by Schema")
  listBySchema is ArmResourceListByParent<DynamicSchema>;
}
