import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(Vaults.createOrUpdate::parameters.resource, "vault");
@@clientName(Vaults.update::parameters.properties, "vault");
@@clientName(Vaults.create::parameters.properties, "certificateRequest");

@@clientName(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "resourceResourceExtendedInfoDetails",
  "!python"
);
@@clientName(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "resourceExtendedInfoDetails",
  "python"
);
@@clientName(VaultExtendedInfoResources.update::parameters.properties,
  "resourceResourceExtendedInfoDetails",
  "!python"
);
@@clientName(VaultExtendedInfoResources.update::parameters.properties,
  "resourceExtendedInfoDetails",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VaultExtendedInfoResource.properties
);
@@clientName(RecoveryServicesOperationGroup.capabilities::parameters.body,
  "input"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// PrivateLinkResourceOperationGroup operations
@@clientLocation(PrivateLinkResourceOperationGroup.get, "PrivateLinkResources");
@@clientLocation(PrivateLinkResourceOperationGroup.list,
  "PrivateLinkResources"
);

// RecoveryServicesOperationGroup operations
@@clientLocation(RecoveryServicesOperationGroup.checkNameAvailability,
  "RecoveryServices"
);
@@clientLocation(RecoveryServicesOperationGroup.capabilities,
  "RecoveryServices"
);

// Vaults operations
@@clientLocation(Vaults.create, "VaultCertificates");
@@clientLocation(Vaults.registeredIdentitiesDelete, "RegisteredIdentities");
@@clientName(Vaults.registeredIdentitiesDelete, "Delete");
@@clientLocation(Vaults.list, "ReplicationUsages");
@@clientLocation(Vaults.listByVaults, "Usages");

// GetOperationResult operations
@@clientLocation(GetOperationResult.listByResourceGroup, Vaults);

// VaultExtendedInfoResources operations
@@clientLocation(VaultExtendedInfoResources.get, "VaultExtendedInfo");
@@clientLocation(VaultExtendedInfoResources.createOrUpdate,
  "VaultExtendedInfo"
);
@@clientLocation(VaultExtendedInfoResources.update, "VaultExtendedInfo");
