import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ProviderOperations;

/**
 * Resource Type
 */
model ResourceType {
  /**
   * The resource type name.
   */
  name?: string;

  /**
   * The resource type display name.
   */
  displayName?: string;

  /**
   * The resource type operations.
   */
  @identifiers(#[])
  operations?: ProviderOperation[];
}

/**
 * Operation
 */
model ProviderOperation {
  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation display name.
   */
  displayName?: string;

  /**
   * The operation description.
   */
  description?: string;

  /**
   * The operation origin.
   */
  origin?: string;

  /**
   * The operation properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;

  /**
   * The dataAction flag to specify the operation type.
   */
  isDataAction?: boolean;
}

/**
 * The resource model definition for resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
model SettableResource {
  /**
   * The provider ID.
   */
  id?: string;

  /**
   * The provider name.
   */
  name?: string;

  /**
   * The provider type.
   */
  type?: string;
}
