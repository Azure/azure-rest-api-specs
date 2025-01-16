import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

@doc("Configuration checks template resource.")
model ConfigurationChecksTemplates
  is ExtensionResource<ConfigurationChecksTemplateProperties> {
  @doc("The name of the configuration check template.")
  @key("configurationCheckTemplates")
  @segment("configurationCheckTemplates")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @path
  name: string;
}

@armResourceOperations
interface ConfigurationChecksTemplatesOperations {
  get is ArmResourceRead<ConfigurationChecksTemplates>;
  listByResourceGroup is ArmResourceListByParent<ConfigurationChecksTemplates>;
}
