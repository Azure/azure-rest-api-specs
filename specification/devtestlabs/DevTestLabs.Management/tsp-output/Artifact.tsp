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
@doc("An artifact.")
@parentResource(ArtifactSource)
model Artifact is TrackedResource<ArtifactProperties> {
  @doc("The name of the artifact.")
  @path
  @key("name")
  @segment("artifacts")
  name: string;
}

@armResourceOperations
interface Artifacts {
  @doc("Get artifact.")
  get is ArmResourceRead<
    Artifact,
    {
      ...BaseParameters<Artifact>;

      @doc("Specify the $expand query. Example: 'properties($select=title)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("List artifacts in a given artifact source.")
  list is ArmResourceListByParent<
    Artifact,
    {
      ...BaseParameters<Artifact>;

      @doc("Specify the $expand query. Example: 'properties($select=title)'")
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

  @doc("Generates an ARM template for the given artifact, uploads the required files to a storage account, and validates the generated artifact.")
  generateArmTemplate is ArmResourceActionSync<
    Artifact,
    GenerateArmTemplateRequest,
    ArmTemplateInfo
  >;
}

@@projectedName(Artifacts.generateArmTemplate::parameters.body,
  "json",
  "generateArmTemplateRequest"
);
@@extension(Artifacts.generateArmTemplate::parameters.body,
  "x-ms-client-name",
  "generateArmTemplateRequest"
);
@@doc(Artifacts.generateArmTemplate::parameters.body,
  "Parameters for generating an ARM template for deploying artifacts."
);
