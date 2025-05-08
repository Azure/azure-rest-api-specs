import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Vaults.createOrUpdate::parameters.resource, "vault");
@@clientName(Vaults.update::parameters.properties, "vault");
@@clientName(Vaults.create::parameters.body, "certificateRequest");

@@clientName(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "resourceResourceExtendedInfoDetails"
);
@@clientName(VaultExtendedInfoResources.update::parameters.properties,
  "resourceResourceExtendedInfoDetails"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VaultExtendedInfoResource.properties);
@@clientName(RecoveryServicesOperationGroup.capabilities::parameters.body,
  "input"
);
