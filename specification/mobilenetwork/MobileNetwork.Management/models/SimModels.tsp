import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("The state of the SIM resource.")
union SimState {
  @doc("The SIM is disabled because not all configuration required for enabling is present.")
  Disabled: "Disabled",

  @doc("The SIM is enabled.")
  Enabled: "Enabled",

  @doc("The SIM cannot be enabled because some of the associated configuration is invalid.")
  Invalid: "Invalid",

  string,
}

@doc("Common SIM properties.")
model CommonSimPropertiesFormat {
  @doc("The provisioning state of the SIM resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The state of the SIM resource.")
  @visibility("read")
  simState?: SimState;

  @doc("A dictionary of sites to the provisioning state of this SIM on that site.")
  @visibility("read")
  siteProvisioningState?: SiteProvisioning;

  @doc("The international mobile subscriber identity (IMSI) for the SIM.")
  @visibility("read", "create")
  @pattern("^[0-9]{5,15}$")
  internationalMobileSubscriberIdentity: string;

  @doc("The integrated circuit card ID (ICCID) for the SIM.")
  @pattern("^[0-9]{10,20}$")
  integratedCircuitCardIdentifier?: string;

  @doc("An optional free-form text field that can be used to record the device type this SIM is associated with, for example 'Video camera'. The Azure portal allows SIMs to be grouped and filtered based on this value.")
  deviceType?: string;

  @doc("The SIM policy used by this SIM. The SIM policy must be in the same location as the SIM.")
  simPolicy?: SimPolicyResourceId;

  @doc("A list of static IP addresses assigned to this SIM. Each address is assigned at a defined network scope, made up of {attached data network, slice}.")
  @minItems(1)
  @extension("x-ms-identifiers", ["attachedDataNetwork", "slice"])
  staticIpConfiguration?: SimStaticIpProperties[];

  @doc("The name of the SIM vendor who provided this SIM, if any.")
  @visibility("read")
  vendorName?: string;

  @doc("The public key fingerprint of the SIM vendor who provided this SIM, if any.")
  @visibility("read")
  vendorKeyFingerprint?: string;
}

@doc("Static IP configuration for a SIM, scoped to a particular attached data network and slice.")
model SimStaticIpProperties {
  @doc("The attached data network on which the static IP address will be used. The combination of attached data network and slice defines the network scope of the IP address. The attached data network must be in the same location as the SIM.")
  attachedDataNetwork?: AttachedDataNetworkResourceId;

  @doc("The network slice on which the static IP address will be used. The combination of attached data network and slice defines the network scope of the IP address. The slice must be in the same location as the SIM.")
  slice?: SliceResourceId;

  @doc("The static IP configuration for the SIM to use at the defined network scope.")
  staticIp?: SimStaticIpPropertiesStaticIp;
}

@doc("The static IP configuration for the SIM to use at the defined network scope.")
model SimStaticIpPropertiesStaticIp {
  @doc("The IPv4 address assigned to the SIM at this network scope. This address must be in the userEquipmentStaticAddressPoolPrefix defined in the attached data network.")
  ipv4Address?: Ipv4Addr;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("SIM properties.")
model SimPropertiesFormat extends CommonSimPropertiesFormat {
  @doc("The Ki value for the SIM.")
  @extension("x-ms-secret", true)
  @visibility("create", "update")
  @pattern("^[0-9a-fA-F]{32}$")
  authenticationKey?: string;

  @doc("The Opc value for the SIM.")
  @extension("x-ms-secret", true)
  @visibility("create", "update")
  @pattern("^[0-9a-fA-F]{32}$")
  operatorKeyCode?: string;
}

@doc("The SIMs to upload.")
model SimUploadList {
  @doc("A list of SIMs to upload.")
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  sims: SimNameAndProperties[];
}

@doc("SIM name and properties.")
model SimNameAndProperties {
  @doc("The name of the SIM.")
  name: string;

  @doc("SIM Properties.")
  @extension("x-ms-client-flatten", true)
  properties: SimPropertiesFormat;
}

@doc("The SIMs to upload. The SIM credentials must be encrypted.")
model EncryptedSimUploadList {
  @doc("The upload file format version.")
  @minValue(1)
  version: int32;

  @doc("An identifier for the Azure SIM onboarding public key used for encrypted upload.")
  @minValue(1)
  azureKeyIdentifier: int32;

  @doc("The fingerprint of the SIM vendor public key. The private counterpart is used for signing the encrypted transport key.")
  @pattern("^[0-9a-fA-F]+$")
  vendorKeyFingerprint: string;

  @doc("The transport key used for encrypting SIM credentials, encrypted using the SIM onboarding public key.")
  @pattern("^[0-9a-fA-F]+$")
  encryptedTransportKey: string;

  @doc("The encrypted transport key, signed using the SIM vendor private key.")
  @pattern("^[0-9a-fA-F]+$")
  signedTransportKey: string;

  @doc("A list of SIMs to upload, with encrypted properties.")
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  sims: SimNameAndEncryptedProperties[];
}

@doc("SIM name and encrypted properties.")
model SimNameAndEncryptedProperties {
  @doc("The name of the SIM.")
  name: string;

  @doc("Encrypted SIM Properties.")
  @extension("x-ms-client-flatten", true)
  properties: EncryptedSimPropertiesFormat;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Encrypted SIM properties.")
model EncryptedSimPropertiesFormat extends CommonSimPropertiesFormat {
  @doc("The encrypted SIM credentials.")
  @extension("x-ms-secret", true)
  @pattern("^[0-9a-fA-F]+$")
  encryptedCredentials?: string;
}

@doc("The SIMs to move.")
model SimMove {
  @doc("The SIM Group where the SIMs should be moved.")
  targetSimGroupId?: SimGroupResourceId;

  @doc("A list of SIM resource names to be moved.")
  @minItems(1)
  sims?: SimName[];
}

@doc("The SIMs to clone.")
model SimClone {
  @doc("The SIM Group where the SIMs should be cloned.")
  targetSimGroupId?: SimGroupResourceId;

  @doc("A list of SIM resource names to be cloned.")
  @minItems(1)
  sims?: SimName[];
}

@doc("The SIMs to delete.")
model SimDeleteList {
  @doc("A list of SIM resource names to delete.")
  @minItems(1)
  sims?: SimName[];
}
