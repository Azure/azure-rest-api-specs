import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Basic properties of medadata resources. */
model MetadataProperties {
  /** Guid of the resource. */
  guid: string;

  /** Short id of the resource */
  @pattern("^[a-zA-Z-]{2,6}$")
  shortId?: string;

  /** Index of the resource */
  @minValue(1)
  @maxValue(9999)
  index: int32;
}
