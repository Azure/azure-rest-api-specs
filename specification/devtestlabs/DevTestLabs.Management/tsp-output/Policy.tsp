import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
@doc("A Policy.")
@parentResource(Lab)
model Policy is TrackedResource<PolicyProperties> {
  @doc("The name of the policy.")
  @key("name")
  @segment("policies")
  name: string;
}

@armResourceOperations
interface Policies {
  @doc("Get policy.")
  get is ArmResourceRead<
    Policy,
    {
      ...BaseParameters<Policy>;

      @doc("Specify the $expand query. Example: 'properties($select=description)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Policy>;

  @doc("Allows modifying tags of policies. All other properties will be ignored.")
  update is ArmCustomPatchSync<Policy, PolicyFragment>;

  @doc("Delete policy.")
  delete is ArmResourceDeleteSync<Policy>;

  @doc("List policies in a given policy set.")
  list is ArmResourceListByParent<
    Policy,
    {
      ...BaseParameters<Policy>;

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
