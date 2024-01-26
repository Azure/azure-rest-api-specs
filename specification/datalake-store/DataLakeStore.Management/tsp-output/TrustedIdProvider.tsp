import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store trusted identity provider information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataLakeStoreAccount)
@includeInapplicableMetadataInPayload(false)
model TrustedIdProvider extends SubResource {
  /**
   * The name of the trusted identity provider to retrieve.
   */
  @path
  @key("trustedIdProviderName")
  @segment("trustedIdProviders")
  @visibility("read")
  name: string;

  /**
   * The trusted identity provider properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: TrustedIdProviderProperties;
}

@armResourceOperations
interface TrustedIdProviders {
  /**
   * Gets the specified Data Lake Store trusted identity provider.
   */
  get is ArmResourceRead<TrustedIdProvider>;

  /**
   * Creates or updates the specified trusted identity provider. During update, the trusted identity provider with the specified name will be replaced with this new provider
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<TrustedIdProvider>;

  /**
   * Updates the specified trusted identity provider.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    TrustedIdProvider,
    UpdateTrustedIdProviderParameters
  >;

  /**
   * Deletes the specified trusted identity provider from the specified Data Lake Store account
   */
  delete is ArmResourceDeleteSync<TrustedIdProvider>;

  /**
   * Lists the Data Lake Store trusted identity providers within the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TrustedIdProviders_ListByAccount")
  listByAccount is ArmResourceListByParent<TrustedIdProvider>;
}

@@projectedName(TrustedIdProviders.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(TrustedIdProviders.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(TrustedIdProviders.createOrUpdate::parameters.resource,
  "Parameters supplied to create or replace the trusted identity provider."
);
@@projectedName(TrustedIdProviders.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(TrustedIdProviders.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(TrustedIdProviders.update::parameters.properties,
  "Parameters supplied to update the trusted identity provider."
);
