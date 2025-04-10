import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store trusted identity provider information.
 */
@parentResource(DataLakeStoreAccount)
model TrustedIdProvider
  is Azure.ResourceManager.ProxyResource<TrustedIdProviderProperties> {
  ...ResourceNameParameter<
    Resource = TrustedIdProvider,
    KeyName = "trustedIdProviderName",
    SegmentName = "trustedIdProviders",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    TrustedIdProvider,
    Response = ArmResourceUpdatedResponse<TrustedIdProvider>
  >;

  /**
   * Updates the specified trusted identity provider.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    TrustedIdProvider,
    PatchModel = UpdateTrustedIdProviderParameters
  >;

  /**
   * Deletes the specified trusted identity provider from the specified Data Lake Store account
   */
  delete is ArmResourceDeleteSync<TrustedIdProvider>;

  /**
   * Lists the Data Lake Store trusted identity providers within the specified Data Lake Store account.
   */
  listByAccount is ArmResourceListByParent<TrustedIdProvider>;
}

@@doc(TrustedIdProvider.name,
  "The name of the trusted identity provider to retrieve."
);
@@doc(TrustedIdProvider.properties,
  "The trusted identity provider properties."
);
@@doc(TrustedIdProviders.createOrUpdate::parameters.resource,
  "Parameters supplied to create or replace the trusted identity provider."
);
@@doc(TrustedIdProviders.update::parameters.properties,
  "Parameters supplied to update the trusted identity provider."
);
