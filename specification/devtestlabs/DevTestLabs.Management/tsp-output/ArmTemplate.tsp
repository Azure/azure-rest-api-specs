import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArtifactSource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("An Azure Resource Manager template.")
@parentResource(ArtifactSource)
model ArmTemplate is TrackedResource<ArmTemplateProperties> {
  @doc("The name of the azure resource manager template.")
  @path
  @key("name")
  @segment("armtemplates")
  name: string;
}

@armResourceOperations
interface ArmTemplates {
  @doc("Get azure resource manager template.")
  get is ArmResourceRead<
    ArmTemplate,
    {
      ...BaseParameters<ArmTemplate>;

      @doc("Specify the $expand query. Example: 'properties($select=displayName)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("List azure resource manager templates in a given artifact source.")
  list is ArmResourceListByParent<
    ArmTemplate,
    {
      ...BaseParameters<ArmTemplate>;

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
