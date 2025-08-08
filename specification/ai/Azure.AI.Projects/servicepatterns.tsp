import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

@doc("Defines the request parameters for the createOrUpdateVersion operations.")
model InputParameters<
  TEntityType extends Reflection.Model,
  TBodyName extends valueof string = "body"
> {
  @doc("The {name} to create or update.", TEntityType)
  @Http.bodyRoot
  @clientName(TBodyName)
  body: TEntityType;

  @doc("Content type for patch")
  @Http.header("Content-Type")
  contentType: "application/merge-patch+json";

  @doc(
    "The specific version id of the {name} to create or update.",
    TEntityType
  )
  @Rest.segment("versions")
  @Http.path
  version: string;
}

@Rest.autoRoute
interface VersionedOperations<
  TEntityType extends Reflection.Model,
  TInputParameters extends Reflection.Model,
  TListLatestParameters extends Reflection.Model = {},
  TListVersionsParameters extends Reflection.Model = {}
> {
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "We are using the resource action as a building block."
  @doc("List all versions of the given {name}", TEntityType)
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @Http.get
  listVersions is Azure.Core.StandardResourceOperations.ResourceAction<
    TEntityType,
    TListVersionsParameters,
    Azure.Core.Page<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc("List the latest version of each {name}", TEntityType)
  @Rest.listsResource(TEntityType)
  listLatest is Azure.Core.Foundations.ResourceList<
    TEntityType,
    TListLatestParameters,
    Azure.Core.Page<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    TEntityType
  )
  getVersion is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    {
      @doc("The specific version id of the {name} to retrieve.", TEntityType)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Delete the specific version of the {name}. The service returns 204 No Content if the {name} was deleted successfully or if the {name} does not exist.",
    TEntityType
  )
  @Http.delete
  deleteVersion is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    {
      @doc("The version of the {name} to delete.", TEntityType)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Create a new or update an existing {name} with the given version id",
    TEntityType
  )
  @Http.patch
  createOrUpdateVersion is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    TInputParameters,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<TEntityType>
  >;
}
