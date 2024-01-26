import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Blueprint;

interface PublishedArtifactsOperations {
  /**
   * Get an artifact for a published blueprint definition.
   */
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions/{versionId}/artifacts/{artifactName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the resource. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}').
       */
      @path
      resourceScope: string;

      /**
       * Name of the blueprint definition.
       */
      @path
      blueprintName: string;

      /**
       * Version of the published blueprint definition.
       */
      @path
      versionId: string;

      /**
       * Name of the blueprint artifact.
       */
      @path
      artifactName: string;
    },
    Artifact
  >;

  /**
   * List artifacts for a version of a published blueprint definition.
   */
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions/{versionId}/artifacts")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the resource. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}').
       */
      @path
      resourceScope: string;

      /**
       * Name of the blueprint definition.
       */
      @path
      blueprintName: string;

      /**
       * Version of the published blueprint definition.
       */
      @path
      versionId: string;
    },
    ResourceListResult<Artifact>
  >;
}
