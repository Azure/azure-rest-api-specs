import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLabArtifactSource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("An Azure Resource Manager template.")
@parentResource(DevTestLabArtifactSource)
model DevTestLabArmTemplate is TrackedResource<ArmTemplateProperties> {
  @doc("The name of the azure resource manager template.")
  @path
  @key("name")
  @segment("armtemplates")
  name: string;
}

@armResourceOperations
interface DevTestLabArmTemplates {
  @doc("Get azure resource manager template.")
  get is ArmResourceRead<
    DevTestLabArmTemplate,
    {
      ...BaseParameters<DevTestLabArmTemplate>;

      @doc("Specify the $expand query. Example: 'properties($select=displayName)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("List azure resource manager templates in a given artifact source.")
  list is ArmResourceListByParent<
    DevTestLabArmTemplate,
    {
      ...BaseParameters<DevTestLabArmTemplate>;

      @doc("Specify the $expand query. Example: 'properties($select=displayName)'")
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
