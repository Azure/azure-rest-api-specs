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
@singleton("vaultExtendedInfo")
@parentResource(Vault)
model RecoveryServicesVaultExtendedInfo
  is ProxyResource<VaultExtendedInfoProperties> {
  @key("extendedInformation")
  @segment("extendedInformation")
  name: string;
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
