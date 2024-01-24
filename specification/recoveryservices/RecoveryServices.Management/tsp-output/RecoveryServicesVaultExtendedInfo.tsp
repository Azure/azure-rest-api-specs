import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Vault extended information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("vaultExtendedInfo")
@parentResource(Vault)
@Azure.ResourceManager.Private.armResourceInternal(VaultExtendedInfoProperties)
@includeInapplicableMetadataInPayload(false)
model RecoveryServicesVaultExtendedInfo extends ProxyResourceBase {
  @key("extendedInformation")
  @segment("extendedInformation")
  name: string;

  /**
   * Vault extended information.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VaultExtendedInfoProperties;
}

@armResourceOperations
interface RecoveryServicesVaultExtendedInfos {
  /**
   * Get the vault extended info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VaultExtendedInfo_Get")
  get is ArmResourceRead<RecoveryServicesVaultExtendedInfo>;

  /**
   * Create vault extended info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VaultExtendedInfo_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<RecoveryServicesVaultExtendedInfo>;

  /**
   * Update vault extended info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("VaultExtendedInfo_Update")
  update is ArmCustomPatchSync<
    RecoveryServicesVaultExtendedInfo,
    RecoveryServicesVaultExtendedInfo
  >;
}

@@projectedName(RecoveryServicesVaultExtendedInfos.createOrUpdate::parameters.resource,
  "json",
  "resourceResourceExtendedInfoDetails"
);
@@extension(RecoveryServicesVaultExtendedInfos.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "resourceResourceExtendedInfoDetails"
);
@@doc(RecoveryServicesVaultExtendedInfos.createOrUpdate::parameters.resource,
  "Details of ResourceExtendedInfo"
);
@@projectedName(RecoveryServicesVaultExtendedInfos.update::parameters.properties,
  "json",
  "resourceResourceExtendedInfoDetails"
);
@@extension(RecoveryServicesVaultExtendedInfos.update::parameters.properties,
  "x-ms-client-name",
  "resourceResourceExtendedInfoDetails"
);
@@doc(RecoveryServicesVaultExtendedInfos.update::parameters.properties,
  "Details of ResourceExtendedInfo"
);
