import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
/**
 * An artifact.
 */
@parentResource(ArtifactSource)
model Artifact
  is Azure.ResourceManager.ProxyResource<ArtifactProperties, false> {
  ...ResourceNameParameter<
    Resource = Artifact,
    KeyName = "artifactName",
    SegmentName = "artifacts",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Artifacts {
  /**
   * Get artifact.
   */
  get is ArmResourceRead<
    Artifact,
    Parameters = {
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
  list is ArmResourceListByParent<
    Artifact,
    Parameters = {
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
    },
    Response = ArmResponse<ArtifactList>
  >;

  /**
   * Generates an ARM template for the given artifact, uploads the required files to a storage account, and validates the generated artifact.
   */
  generateArmTemplate is ArmResourceActionSync<
    Artifact,
    GenerateArmTemplateRequest,
    ArmResponse<ArmTemplateInfo>
  >;
}

@@doc(Artifact.name, "The name of the artifact.");
@@doc(Artifact.properties, "The properties of the resource.");
@@doc(Artifacts.generateArmTemplate::parameters.body,
  "Parameters for generating an ARM template for deploying artifacts."
);
