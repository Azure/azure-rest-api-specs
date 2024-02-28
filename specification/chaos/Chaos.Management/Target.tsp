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
@parentResource(ArmLocationResource<"Subscription">)
model Target is ProxyResource<Record<unknown>> {
  @doc("String that represents a Target resource name.")
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;
}

alias ParentResourceParameters = {
  @doc("The parent resource provider namespace.")
  @path
  @segment("providers")
  parentProviderNamespace: string;

  @doc("The parent resource type.")
  @path
  parentResourceType: string;

  @doc("The parent resource name.")
  @path
  parentResourceName: string;
};

alias TargetParentResourceParameters = BaseParameters<Target> &
  ParentResourceParameters;

@armResourceOperations
interface Targets {
  @doc("Get a Target resource that extends a tracked regional resource.")
  get is ArmResourceRead<Target, TargetParentResourceParameters>;

  @doc("Create or update a Target resource that extends a tracked regional resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Target,
    TargetParentResourceParameters
  >;

  @doc("Delete a Target resource that extends a tracked regional resource.")
  delete is ArmResourceDeleteSync<Target, TargetParentResourceParameters>;

  @doc("Get a list of Target resources that extend a tracked regional resource.")
  list is ArmResourceListByParent<
    Target,
    {
      ...TargetParentResourceParameters;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
