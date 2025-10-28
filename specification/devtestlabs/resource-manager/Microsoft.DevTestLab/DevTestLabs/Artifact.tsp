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
model Artifact
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<
    ArtifactProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = Artifact,
    KeyName = "name",
    SegmentName = "artifacts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ArtifactOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,

        /** The name of the artifact source. */
        @path @segment("artifactsources") artifactSourceName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Artifact,
        KeyName = "name",
        SegmentName = "artifacts",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Artifacts {
  /**
   * Get artifact.
   */
  get is ArtifactOps.Read<
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
  list is ArtifactOps.List<
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
  generateArmTemplate is ArtifactOps.ActionSync<
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
