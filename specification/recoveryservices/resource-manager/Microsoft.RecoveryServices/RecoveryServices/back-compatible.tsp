import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VaultExtendedInfoResource.properties);
@@clientName(RecoveryServicesOperationGroup.capabilities::parameters.body,
  "input"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// PrivateLinkResourceOperationGroup operations
@@clientLocation(PrivateLinkResourceOperationGroup.get,
  "PrivateLinkResources",
  "!csharp"
);
@@clientLocation(PrivateLinkResourceOperationGroup.list,
  "PrivateLinkResources",
  "!csharp"
);

// RecoveryServicesOperationGroup operations
@@clientLocation(RecoveryServicesOperationGroup.checkNameAvailability,
  "RecoveryServices",
  "!csharp"
);
@@clientLocation(RecoveryServicesOperationGroup.capabilities,
  "RecoveryServices",
  "!csharp"
);
@@alternateType(RecoveryServicesOperationGroup.capabilities::parameters.location,
  azureLocation,
  "csharp"
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
@@clientLocation(VaultExtendedInfoResources.get,
  "VaultExtendedInfo",
  "!csharp"
);
@@clientLocation(VaultExtendedInfoResources.createOrUpdate,
  "VaultExtendedInfo",
  "!csharp"
);
@@clientLocation(VaultExtendedInfoResources.update,
  "VaultExtendedInfo",
  "!csharp"
);
