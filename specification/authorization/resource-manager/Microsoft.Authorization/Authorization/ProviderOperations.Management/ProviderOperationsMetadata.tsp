import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderOperations;
// FIXME: ProviderOperationsMetadata has no properties property
/**
 * Provider Operations metadata
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tenantResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ProviderOperationsMetadata extends SettableResource {
  @visibility(Lifecycle.Read)
  @path(#{ allowReserved: true })
  @segment("providerOperations")
  @key("resourceProviderNamespace")
  name: string;

  /**
   * The provider display name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string;

  /**
   * The provider resource types
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  resourceTypes?: ResourceType[];

  /**
   * The provider operations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  operations?: ProviderOperation[];
}

@armResourceOperations(#{ omitTags: true })
interface ProviderOperationsMetadataOperationGroup {
  /**
   * Gets provider operations metadata for the specified resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ProviderOperationsMetadata")
  get is ArmResourceRead<
    ProviderOperationsMetadata,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * Specifies whether to expand the values.
       */
      @query("$expand")
      $expand?: string = "resourceTypes";
    }
  >;

  /**
   * Gets provider operations metadata for all resource providers.
   */
  @tag("ProviderOperationsMetadata")
  list is ArmResourceListByParent<
    ProviderOperationsMetadata,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * Specifies whether to expand the values.
       */
      @query("$expand")
      $expand?: string = "resourceTypes";
    }
  >;
}

@@doc(ProviderOperationsMetadata.name,
  "The namespace of the resource provider."
);
