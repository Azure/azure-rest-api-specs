import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maps;

// Remove namespace qualification from CommonTypes encryption types for OpenAPI compatibility
@@clientName(
  Azure.ResourceManager.CommonTypes.CustomerManagedKeyEncryption,
  "CustomerManagedKeyEncryption"
);
@@clientName(Azure.ResourceManager.CommonTypes.Encryption, "Encryption");
@@clientName(
  Azure.ResourceManager.CommonTypes.InfrastructureEncryption,
  "InfrastructureEncryption"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "KeyEncryptionKeyIdentity"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "KeyEncryptionKeyIdentityType"
);
@@clientName(Azure.Core.uuid, "uuid");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened Maps Account update model used by existing SDKs."
@@Legacy.flattenProperty(MapsAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened Maps Account update model used by existing SDKs."
@@Legacy.flattenProperty(MapsAccountUpdateParametersV1.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened Creator update model in the 2025 preview SDKs."
@@Legacy.flattenProperty(CreatorUpdateParameters.properties);

@@clientName(Accounts.createOrUpdate::parameters.resource, "MapsAccount");
@@clientName(Accounts.createOrUpdateV1::parameters.resource, "MapsAccount");
@@clientName(
  Accounts.update::parameters.properties,
  "MapsAccountUpdateParameters"
);
@@clientName(
  Accounts.updateV1::parameters.properties,
  "MapsAccountUpdateParameters"
);
@@clientName(Accounts.listSas::parameters.body, "MapsAccountSasParameters");
@@clientName(Accounts.regenerateKeys::parameters.body, "keySpecification");

@@clientName(
  PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
@@clientName(
  PrivateEndpointConnections.createV1::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened private endpoint connection model used by existing SDKs."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(Creators.createOrUpdate::parameters.resource, "CreatorResource");
@@clientName(Creators.update::parameters.properties, "CreatorUpdateParameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened private link resource model used by existing SDKs."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(OperationResultOperationGroup.get, "OperationResult");

@@clientLocation(OperationStatusOperationGroup.get, "OperationStatus");

@@clientLocation(Operations.list, "Maps");
@@clientName(Operations.list, "ListOperations");
