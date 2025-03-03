using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/**
 * The SAP Virtual Instance Metadata.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@singleton
@parentResource(SubscriptionLocationResource)
@armVirtualResource
model SAPVirtualInstanceMetadata {
  /**
   * The default variable.
   */
  @path
  @visibility("read")
  @segment("sapVirtualInstanceMetadata")
  @key
  default: "string";
}
