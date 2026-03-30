import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.App;

/** Resource tags update model */
model ResourceTagsUpdate {
  /** Resource tags */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is a free-form dictionary"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}
