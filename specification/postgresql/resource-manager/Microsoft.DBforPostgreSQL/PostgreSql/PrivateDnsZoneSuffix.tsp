import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Private DNS suffix.
 */
@mediaTypeHint("application/json")
scalar PrivateDnsZoneSuffix extends string;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PrivateDnsZoneSuffixOperationGroup {
  /**
   * Gets the private DNS zone suffix.
   */
  @autoRoute
  @action("getPrivateDnsZoneSuffix")
  get is ArmProviderActionSync<Response = {
    @body
    privateDnsZoneSuffix: PrivateDnsZoneSuffix;
  }>;
}
