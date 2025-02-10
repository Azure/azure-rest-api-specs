import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Mobile network properties.")
model MobileNetworkPropertiesFormat {
  @doc("The provisioning state of the mobile network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The unique public land mobile network identifier for the network. If both 'publicLandMobileNetworks' and 'publicLandMobileNetworkIdentifier' are specified, then the 'publicLandMobileNetworks' will take precedence.")
  publicLandMobileNetworkIdentifier: PlmnId;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "For backward compatibility"
  @doc("A list of public land mobile networks including their identifiers. If both 'publicLandMobileNetworks' and 'publicLandMobileNetworkIdentifier' are specified, then the 'publicLandMobileNetworks' will take precedence.")
  @minItems(1)
  @extension("x-ms-identifiers", ["mcc", "mnc"])
  publicLandMobileNetworks?: PublicLandMobileNetwork[];

  @doc("The mobile network resource identifier")
  @visibility("read")
  serviceKey?: string;

  @doc("The list of endpoint security groups used in the mobile network.")
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  endpointSecurityGroups?: EndpointSecurityGroup[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Configuration relating to a particular PLMN")
model PublicLandMobileNetwork extends PlmnId {
  @doc("Configuration relating to SUPI concealment.")
  homeNetworkPublicKeys?: PublicLandMobileNetworkHomeNetworkPublicKeys;
}

@doc("Configuration relating to SUPI concealment.")
model PublicLandMobileNetworkHomeNetworkPublicKeys {
  @doc("This provides a mapping to identify which public key has been used for SUPI concealment using the Profile A Protection Scheme.")
  profileA?: HomeNetworkPublicKeys;

  @doc("This provides a mapping to identify which public key has been used for SUPI concealment using the Profile B Protection Scheme.")
  profileB?: HomeNetworkPublicKeys;
}

@doc("List of keys used for SUPI concealment.")
@minItems(0)
model HomeNetworkPublicKeys is Array<HomeNetworkPublicKey>;

@doc("A key used for SUPI concealment.")
model HomeNetworkPublicKey {
  @doc("The Home Network Public Key Identifier determines which public key was used to generate the SUCI sent to the AMF. See TS 23.003 Section 2.2B Section 5.")
  @maxValue(255)
  @minValue(1)
  id: int32;

  @doc("The URL of Azure Key Vault secret containing the private key, versioned or unversioned. For example: https://contosovault.vault.azure.net/secrets/mySuciPrivateKey/562a4bb76b524a1493a6afe8e536ee78.")
  url?: string;
}
