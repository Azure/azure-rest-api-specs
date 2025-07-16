import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Enum to determine the provisioning state of the environment.")
union AssetProvisioningState {
  string,

  @doc("Successfully provisioned.")
  Succeeded: "Succeeded",

  @doc("Failed to provision.")
  Failed: "Failed",

  @doc("Provisioning was canceled.")
  Canceled: "Canceled",

  @doc("Currently being created.")
  Creating: "Creating",

  @doc("Currently being updated.")
  Updating: "Updating",

  @doc("Currently being deleted.")
  Deleting: "Deleting",
}

@doc("System metadata for the environment version.")
model SystemDataV3 {
  @doc("The timestamp of resource creation (UTC).")
  createdAt?: utcDateTime;

  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: string;

  @doc("The timestamp of resource last modification (UTC).")
  lastModifiedAt?: utcDateTime;
}

@doc("Enum to determine the type of Docker specification.")
union DockerSpecificationType {
  string,

  @doc("Docker build context.")
  Context: "Context",

  @doc("Docker image.")
  Image: "Image",
}

@doc("Docker image platform information.")
model DockerImagePlatform {
  @doc("Platform architecture.")
  architecture?: string;

  @doc("Operating system.")
  os?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Configuration settings for Docker")
@discriminator("dockerSpecificationType")
model DockerSpecification {
  @doc("Docker specification must be either Build or Image")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerSpecificationType: DockerSpecificationType;

  @doc("The platform information of the docker image.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  platform?: DockerImagePlatform;
}

@doc("Class to represent configuration settings for Docker Image")
model DockerImage extends DockerSpecification {
  @doc("Docker specification must be Image")
  dockerSpecificationType: DockerSpecificationType.Image;

  @doc("Image name of a custom base image.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  dockerImageUri: string;
}

@doc("Class to represent configuration settings for Docker Build")
model DockerBuild extends DockerSpecification {
  @doc("Docker specification must be Build")
  dockerSpecificationType: DockerSpecificationType.Context;

  @doc("Dockerfile content or path")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  dockerfile: string;

  @doc("Path to a snapshot of the Docker Context. This property is only valid if Dockerfile is specified.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  context?: string;
}

@doc("Environment image details.")
model ImageDetails {
  @doc("Image URI.")
  imageUri?: string;

  @doc("Image registry details.")
  registry?: string;

  @doc("Image tag.")
  tag?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Environment Version Definition")
@Rest.resource("environments")
@added(Versions.v2025_05_01)
model EnvironmentVersion {
  @doc("Specifies the type of environment.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  type: string;

  @doc("Configuration settings for Docker.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  docker?: DockerSpecification;

  @doc("Provisioning state for the environment version.")
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;

  @doc("Stage in the environment lifecycle assigned to this environment.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stage?: string;

  @doc("Environment image details.")
  @visibility(Lifecycle.Read)
  imageDetails?: ImageDetails;

  @doc("System metadata for the environment version.")
  @visibility(Lifecycle.Read)
  systemData?: SystemDataV3;

  ...AssetBase;
}