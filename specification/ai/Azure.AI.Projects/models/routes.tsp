import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListModelVersionsParameters = {
  @doc("Specifies which view type to apply when listing model versions.")
  @query
  listViewType?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@autoRoute
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface Models {
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "We are using the resource action as a building block."
  @doc("List all versions of the given Model")
  @action("versions")
  @actionSeparator("/")
  @get
  @list
  listVersions is Azure.Core.StandardResourceOperations.ResourceAction<
    Model,
    ListModelVersionsParameters,
    Azure.Core.Page<Model>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc("Get the specific version of the Model. The service returns 404 Not Found error if the Model does not exist.")
  getVersion is Azure.Core.Foundations.ResourceOperation<
    Model,
    {
      @doc("The specific version id of the Model to retrieve.")
      @segment("versions")
      @path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<Model>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc("Delete the specific version of the Model. The service returns 204 No Content if the Model was deleted successfully or if the Model does not exist.")
  @delete
  deleteVersion is Azure.Core.Foundations.ResourceOperation<
    Model,
    {
      @doc("The version of the Model to delete.")
      @segment("versions")
      @path
      version: string;
    },
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "PUT create-or-update pattern required by the Model Versions API wire format"
  @doc("Create a new or update an existing Model with the given version id")
  @put
  createOrUpdateVersion is Azure.Core.Foundations.ResourceOperation<
    Model,
    {
      @doc("The model to create or update.")
      @bodyRoot
      body: Model;

      @doc("The specific version id of the Model to create or update.")
      @segment("versions")
      @path
      version: string;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Model>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Publish action requires version path segment and body"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Publish returns 200 with no body"
  @doc("Publish a model version to a registry.")
  @post
  @action("publish")
  @actionSeparator("/")
  publish is Azure.Core.Foundations.ResourceOperation<
    Model,
    {
      @doc("The destination asset parameters for publishing.")
      @bodyRoot
      destinationAsset: DestinationAsset;

      @doc("The specific version of the model to publish.")
      @segment("versions")
      @path
      version: string;
    },
    Http.OkResponse
  >;
}
