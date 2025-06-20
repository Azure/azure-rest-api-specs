import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Vaults.createOrUpdate::parameters.resource, "vault");
@@clientName(Vaults.update::parameters.properties, "vault");
@@clientName(Vaults.create::parameters.properties, "certificateRequest");

@@clientName(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "resourceResourceExtendedInfoDetails"
);
@@clientName(VaultExtendedInfoResources.update::parameters.properties,
  "resourceResourceExtendedInfoDetails"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VaultExtendedInfoResource.properties);
@@clientName(RecoveryServicesOperationGroup.capabilities::parameters.body,
  "input"
);

// @@clientLocation decorators for @operationId operations
@@clientLocation(PrivateLinkResourceOperationGroup.get,
  PrivateLinkResourceOperationGroup
);
@@clientLocation(PrivateLinkResourceOperationGroup.list,
  PrivateLinkResourceOperationGroup
);

@@clientLocation(RecoveryServicesOperationGroup.checkNameAvailability,
  RecoveryServicesOperationGroup
);
@@clientLocation(RecoveryServicesOperationGroup.capabilities,
  RecoveryServicesOperationGroup
);

@@clientLocation(Vaults.create, Vaults);
@@clientLocation(Vaults.registeredIdentitiesDelete, Vaults);
@@clientLocation(Vaults.list, Vaults);
@@clientLocation(Vaults.getOperationStatus, Vaults);
@@clientLocation(Vaults.listByVaults, Vaults);

@@clientLocation(GetOperationResult.getOperationResult, GetOperationResult);
@@clientLocation(GetOperationResult.listByResourceGroup, GetOperationResult);

@@clientLocation(VaultExtendedInfoResources.get, VaultExtendedInfoResources);
@@clientLocation(VaultExtendedInfoResources.createOrUpdate,
  VaultExtendedInfoResources
);
@@clientLocation(VaultExtendedInfoResources.update, VaultExtendedInfoResources);
