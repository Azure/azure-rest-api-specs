using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DocumentDB;

interface Operations extends Azure.ResourceManager.Operations {}

/** The provisioning state of the last accepted operation. */
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /** An operation is in-progress on the resource. */
  "InProgress",

  /** An update operation is in-progress on the resource. */
  "Updating",

  /** A drop operation is in-progress on the resource. */
  "Dropping",
}
