import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
@doc("An environment, which is essentially an ARM template deployment.")
@parentResource(User)
model DtlEnvironment is TrackedResource<EnvironmentProperties> {
  @doc("The name of the environment.")
  @key("name")
  @segment("environments")
  name: string;
}

@armResourceOperations
@projectedName("client", "Environments")
interface DtlEnvironments_Environments {
  @doc("Get environment.")
  get is ArmResourceRead<
    DtlEnvironment,
    {
      ...BaseParameters<DtlEnvironment>;

      @doc("Specify the $expand query. Example: 'properties($select=deploymentProperties)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing environment. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DtlEnvironment>;

  @doc("Allows modifying tags of environments. All other properties will be ignored.")
  update is ArmCustomPatchSync<DtlEnvironment, DtlEnvironmentFragment>;

  @doc("Delete environment. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<DtlEnvironment>;

  @doc("List environments in a given user profile.")
  list is ArmResourceListByParent<
    DtlEnvironment,
    {
      ...BaseParameters<DtlEnvironment>;

      @doc("Specify the $expand query. Example: 'properties($select=deploymentProperties)'")
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
