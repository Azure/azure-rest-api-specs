import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListEnvironmentVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_05_01)
interface Environments
  extends VersionedOperations<
      EnvironmentVersion,
      InputParameters<EnvironmentVersion, "environmentVersion">,
      ListEnvironmentVersionsParameters,
      ListEnvironmentVersionsParameters
    > {
  @doc("Start a new or get an existing pending upload of an environment for a specific version.")
  @Rest.action("startPendingUpload")
  startPendingUploadVersion is Azure.Core.Foundations.ResourceOperation<
    EnvironmentVersion,
    {
      @doc("The pending upload request parameters")
      @Http.bodyRoot
      pendingUploadRequest: PendingUploadRequest;

      @doc("The specific version id of the EnvironmentVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    PendingUploadResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the SAS credential to access the storage account associated with an Environment version.")
  @post
  @Rest.action("credentials")
  @Rest.actionSeparator("/")
  getCredentials is Azure.Core.Foundations.ResourceOperation<
    EnvironmentVersion,
    {
      @doc("The specific version id of the EnvironmentVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AssetCredentialResponse
  >;
}