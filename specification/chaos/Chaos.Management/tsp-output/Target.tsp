import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Chaos;
@doc("Model that represents a Target resource.")
model Target is ProxyResource<Record<unknown>> {
  @doc("String that represents a Target resource name.")
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;
}

@armResourceOperations
interface Targets {
  @doc("Get a Target resource that extends a tracked regional resource.")
  get is ArmResourceRead<Target>;
  @doc("Create or update a Target resource that extends a tracked regional resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Target>;
  @doc("Delete a Target resource that extends a tracked regional resource.")
  delete is ArmResourceDeleteSync<Target>;
  @doc("Get a list of Target resources that extend a tracked regional resource.")
  list is ArmResourceListByParent<
    Target,
    {
      ...BaseParameters<Target>;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
