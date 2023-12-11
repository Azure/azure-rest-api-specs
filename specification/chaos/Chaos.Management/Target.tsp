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

alias ParentedResourceParameters = BaseParameters<Target> & {
  @path
  @segment("providers")
  parentProviderNamespace: string;

  @path
  parentResourceType: string;
};

@armResourceOperations
interface Targets {
  @doc("Get a Target resource that extends a tracked regional resource.")
  get is ArmResourceRead<Target, ParentedResourceParameters>;

  @doc("Create or update a Target resource that extends a tracked regional resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Target,
    ParentedResourceParameters
  >;

  @doc("Delete a Target resource that extends a tracked regional resource.")
  delete is ArmResourceDeleteSync<Target, ParentedResourceParameters>;

  @doc("Get a list of Target resources that extend a tracked regional resource.")
  list is ArmResourceListByParent<
    Target,
    {
      ...ParentedResourceParameters;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
