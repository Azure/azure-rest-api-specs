import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureSphere;

//Images
@doc("An image resource belonging to a catalog resource.")
@parentResource(Catalog)
model Image is ProxyResource<ImageProperties> {
  @doc("Image name. Use an image GUID for GA versions of the API.")
  @key("imageName")
  @path
  @segment("images")
  name: string;
}

@armResourceOperations
interface Images
  extends ProxyResourceOperationsReadListCreateDelete<
      Image,
      ListQueryParameters
    > {}

@doc("The properties of image")
model ImageProperties {
  @doc("Image as a UTF-8 encoded base 64 string on image create. This field contains the image URI on image reads.")
  @visibility("create", "read")
  image?: string;

  @doc("Image ID")
  @visibility("create", "read")
  imageId?: string;

  @doc("Image name")
  @visibility("read")
  imageName?: string;

  @doc("Regional data boundary for an image")
  @visibility("create", "read")
  regionalDataBoundary?: RegionalDataBoundary;

  @doc("Location the image")
  @visibility("read")
  uri?: string;

  @doc("The image description.")
  @visibility("read")
  description?: string;

  @doc("The image component id.")
  @visibility("read")
  componentId?: string;

  @doc("The image type.")
  @visibility("read")
  imageType?: ImageType;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Image type values.")
enum ImageType {
  /** Invalid image. */
  InvalidImageType,

  /** One Bl image type */
  OneBl,

  /** Pluton image type */
  PlutonRuntime,

  /** Wifi firmware image type */
  WifiFirmware,

  /** Security monitor image type */
  SecurityMonitor,

  /** Normal world loader image type */
  NormalWorldLoader,

  /** Normal world dtb image type */
  NormalWorldDtb,

  /** Normal world kernel image type */
  NormalWorldKernel,

  /** Root FS image type */
  RootFs,

  /** Services image type */
  Services,

  /** Applications image type */
  Applications,

  /** FW config image type */
  FwConfig,

  /** Boot manifest image type */
  BootManifest,

  /** Nwfs image type */
  Nwfs,

  /** Trusted key store image type */
  TrustedKeystore,

  /** Policy image type */
  Policy,

  /** Customer board config image type */
  CustomerBoardConfig,

  /** Update certificate store image type */
  UpdateCertStore,

  /** Base system update manifest image type */
  BaseSystemUpdateManifest,

  /** Firmware update manifest image type */
  FirmwareUpdateManifest,

  /** Customer update manifest image type */
  CustomerUpdateManifest,

  /** Recovery manifest image type */
  RecoveryManifest,

  /** manifest set image type */
  ManifestSet,

  /** Other image type */
  Other,
}
