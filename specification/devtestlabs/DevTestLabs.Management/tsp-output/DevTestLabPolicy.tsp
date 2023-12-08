import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A Policy.")
@parentResource(DevTestLab)
model DevTestLabPolicy is TrackedResource<PolicyProperties> {
  @doc("The name of the policy.")
  @path
  @key("name")
  @segment("policies")
  name: string;
}

@armResourceOperations
interface DevTestLabPolicies {
  @doc("Get policy.")
  get is ArmResourceRead<
    DevTestLabPolicy,
    {
      ...BaseParameters<DevTestLabPolicy>;

      @doc("Specify the $expand query. Example: 'properties($select=description)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevTestLabPolicy>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of policies. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLabPolicy, PolicyFragment>;
  @doc("Delete policy.")
  delete is ArmResourceDeleteSync<DevTestLabPolicy>;
  @doc("List policies in a given policy set.")
  list is ArmResourceListByParent<
    DevTestLabPolicy,
    {
      ...BaseParameters<DevTestLabPolicy>;

      @doc("Specify the $expand query. Example: 'properties($select=description)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
