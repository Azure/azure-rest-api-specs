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

namespace Microsoft.HybridCompute;
@doc("Describes a Extension Metadata")
@locationResource
model ExtensionValue is ProxyResource<ExtensionValueProperties> {
  @doc("The version of the Extension being received.")
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ExtensionValues {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an Extension Metadata based on location, publisher, extensionType and version")
  @operationId("ExtensionMetadata_Get")
  get is ArmResourceRead<ExtensionValue>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all Extension versions based on location, publisher, extensionType")
  @operationId("ExtensionMetadata_List")
  list is ArmResourceListByParent<ExtensionValue>;
}
