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
/**
 * An artifact.
 */
@parentResource(ArtifactSource)
model Artifact is TrackedResource<ArtifactProperties> {
  /**
   * The name of the artifact.
   */
  @path
  @key("name")
  @segment("artifacts")
  name: string;
}

@armResourceOperations
interface Artifacts {
  /**
   * Get artifact.
   */
  get is ArmResourceRead<
    Artifact,
    {
      ...BaseParameters<Artifact>;

      /**
       * Specify the $expand query. Example: 'properties($select=title)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * List artifacts in a given artifact source.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Artifacts_List")
  list is ArmResourceListByParent<
    Artifact,
    {
      ...BaseParameters<Artifact>;

      /**
       * Specify the $expand query. Example: 'properties($select=title)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Generates an ARM template for the given artifact, uploads the required files to a storage account, and validates the generated artifact.
   */
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
