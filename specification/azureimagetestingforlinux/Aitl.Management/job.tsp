namespace Microsoft.AzureImageTestingForLinux;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using Azure.Core;
using Azure.Core.Foundations;
using OpenAPI;

@doc("A job is an instance of LISA running the specified test parameters")
model Job is TrackedResource<JobResourceProperties> {
  @doc("Job name")
  @pattern("^[a-zA-Z0-9-_]{3,60}$")
  @key("jobName")
  @segment("jobs")
  @visibility("read")
  @path
  name: string;
}

@doc("The job properties")
model JobResourceProperties is ResourceProperties {
  @doc("Job template name. The name or the instance should be provided.")
  jobTemplateName?: string;

  @doc("Job Template to execute")
  jobTemplateInstance?: JobTemplateResourceProperties;

  @doc("Prefix to use for resource groups that are created during LISA validation.")
  resourceGroupNamePrefix?: string;

  @doc("An array of strings that define different package repos to use in tests.")
  repos?: string[];

  @doc("Image used during job")
  image?: Image;

  @doc("Default false")
  keepFailedEnvironment?: boolean = false;

  @doc("Test results once job is completed.")
  @visibility("read")
  results?: TestResultProperties[];

  @doc("Test duration in format 5h 10m 2s")
  @visibility("read")
  duration?: string;

  @doc("URL to see test logs")
  @visibility("read")
  logUrl?: string;
}

@doc("Image type to use for testing")
enum ImageType {
  @doc("VHD image")
  vhd,

  @doc("Marketplace image")
  marketplace,

  @doc("Shared image gallery")
  shared_gallery,
}

@doc("CPU Architecture")
enum Architecture {
  @doc("x64 architecture")
  x64,

  @doc("arm64 architecture")
  arm64,
}

@minValue(1)
@maxValue(2)
scalar VhdGeneration extends int32;

@doc("This object collects the image information used for testing. The associated properties of each image type must be populated.s")
@discriminator("type")
model Image {
  @doc("Options are 1 or 2. Defaults to 1")
  vhdGeneration?: VhdGeneration = 1;

  @doc("Options are x64 or arm64. Defaults to x64")
  architecture?: Architecture = Architecture.x64;
}

@doc("VHD image type object")
model Vhd extends Image {
  @doc("Image type = VHD")
  type: ImageType.vhd;

  @doc("VHD URL")
  url: string;
}

@doc("Marketplace image type object")
model MarketplaceImage extends Image {
  @doc("Image type = marketplace")
  type: ImageType.marketplace;

  @doc("Image Publisher")
  publisher: string;

  @doc("Image Offer")
  offer: string;

  @doc("Image SKU")
  sku: string;

  @doc("Image Version")
  version: string;
}

@doc("SIG image type object")
model SharedImageGallery extends Image {
  @doc("Image type = shared_gallery")
  type: ImageType.shared_gallery;

  @doc("SIG subscription ID - Optional. The default is the current subscription")
  subscriptionId?: string = "";

  @doc("Resource group name - Optional")
  resourceGroup?: string = "";

  @doc("Shared image gallery")
  gallery: string;

  @doc("Image definition")
  definition: string;

  @doc("Image version")
  version: string;
}

@doc("Job Operations")
@armResourceOperations(Job)
interface Jobs {
  listByResourceGroup is ArmResourceListByParent<Job>;
  listbySubscription is ArmListBySubscription<Job>;
  get is ArmResourceRead<Job>;
  createOrUpdate is ArmResourceCreateOrUpdateAsyncCompliant<Job>;
  update is ArmResourcePatchSync<Job, JobResourceProperties>;
  delete is ArmResourceDeleteAsync<Job>;
}
