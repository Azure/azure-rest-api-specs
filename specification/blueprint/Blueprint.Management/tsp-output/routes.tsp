import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Blueprint;

interface PublishedArtifactsOperations {
  @doc("Get an artifact for a published blueprint definition.")
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions/{versionId}/artifacts/{artifactName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The scope of the resource. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}').")
      @path
      resourceScope: string;

      @doc("Name of the blueprint definition.")
      @path
      blueprintName: string;

      @doc("Version of the published blueprint definition.")
      @path
      versionId: string;

      @doc("Name of the blueprint artifact.")
      @path
      artifactName: string;
    },
    Artifact
  >;

  @doc("List artifacts for a version of a published blueprint definition.")
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions/{versionId}/artifacts")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The scope of the resource. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}').")
      @path
      resourceScope: string;

      @doc("Name of the blueprint definition.")
      @path
      blueprintName: string;

      @doc("Version of the published blueprint definition.")
      @path
      versionId: string;
    },
    ResourceListResult<Artifact>
  >;
}
