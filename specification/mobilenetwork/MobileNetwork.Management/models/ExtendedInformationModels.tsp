import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Packet Data Network Type.")
enum PdnType {
  @doc("Packet Data Network Type IPv4.")
  IPV4,
}

@doc("Radio connection establishment cause.")
enum RrcEstablishmentCause {
  @doc("Emergency Cause.")
  Emergency,

  @doc("Mobile Originated Data.")
  MobileOriginatedData,

  @doc("Mobile Originated Signaling.")
  MobileOriginatedSignaling,

  @doc("Mobile Terminated Data.")
  MobileTerminatedData,

  @doc("Mobile Terminated Signaling.")
  MobileTerminatedSignaling,

  @doc("Short Message Service.")
  SMS,
}

@doc("The UE's usage setting.")
enum UeUsageSetting {
  @doc("Data Centric.")
  DataCentric,

  @doc("Voice Centric.")
  VoiceCentric,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility. The resource ExtendedInformation is for retrieving the information of the resources only."
@doc("Extended UE Information Properties.")
@discriminator("ratType")
model ExtendedUeInfoProperties {
  @doc("RAT Type")
  ratType: RatType;

  @doc("The timestamp of last UE info read from the packet core (UTC).")
  lastReadAt?: utcDateTime;
}

@doc("UE Information for 4G.")
model UeInfo4G extends ExtendedUeInfoProperties {
  @doc("RAT type 4G.")
  ratType: RatType.`4G`;

  @doc("UE Information properties for 4G.")
  info: UeInfo4GProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
@doc("UE Information properties for 4G.")
model UeInfo4GProperties {
  @doc("UE Connection Info for 4G.")
  connectionInfo?: UeConnectionInfo4G;

  @doc("Globally Unique Temporary Identifier (4G).")
  guti: Guti4G;

  @doc("International mobile equipment identity.")
  @pattern("^[0-9]{15}$")
  imei?: string;

  @doc("International mobile equipment identity – software version.")
  @pattern("^[0-9]{16}$")
  imeisv?: string;

  @doc("International mobile subscriber identifier.")
  @pattern("^[0-9]{5,15}$")
  imsi: string;

  @doc("UE Session Info for 4G.")
  @maxItems(11)
  @extension("x-ms-identifiers", [])
  sessionInfo?: Array<UeSessionInfo4G>;
}

@doc("UE Connection Info for 4G.")
model UeConnectionInfo4G {
  @doc("eNodeB S1AP identifier.")
  @minValue(0)
  @maxValue(16777215)
  enbS1apId: int32;

  @doc("Global RAN Node ID.")
  globalRanNodeId: GlobalRanNodeId;

  @doc("The timestamp of last activity of UE (UTC).")
  lastActivityTime?: utcDateTime;

  @doc("Last Visited TAI.")
  lastVisitedTai?: string;

  @doc("UE Location Info properties.")
  locationInfo?: UeLocationInfo;

  @doc("MME S1AP identifier.")
  @minValue(0)
  @maxValue(4294967295)
  mmeS1apId: int32;

  @doc("Per-UE transport network layer association.")
  perUeTnla?: string;

  @doc("Radio connection establishment cause.")
  rrcEstablishmentCause: RrcEstablishmentCause;

  @doc("State of the UE.")
  ueState: UeState;

  @doc("The UE's usage setting.")
  ueUsageSetting?: UeUsageSetting;
}

@doc("Globally Unique Temporary Identifier (4G).")
model Guti4G {
  @doc("MME identifier.")
  mmeId: MmeId;

  @doc("MME Temporary Mobile Subscriber Identity.")
  @minValue(0)
  @maxValue(4294967295)
  mTmsi: int32;

  @doc("PLMN Identifier.")
  plmn: PlmnId;
}

@doc("MME identifier.")
model MmeId {
  @doc("MME code.")
  @minValue(0)
  @maxValue(255)
  code: int32;

  @doc("MME group identifier.")
  @minValue(0)
  @maxValue(65535)
  groupId: int32;
}

@doc("UE Session Info for 4G.")
model UeSessionInfo4G {
  @doc("Access point name.")
  apn: string;

  @doc("EPS bearer identifier.")
  @minValue(5)
  @maxValue(15)
  ebi: int32;

  @doc("Packet Data Network Type.")
  pdnType: PdnType;

  @doc("UE IP address.")
  ueIpAddress: UeIpAddress;
}

@doc("Global RAN Node ID.")
model GlobalRanNodeId {
  @doc("eNodeB identifier.")
  @pattern("^(MacroeNB-[A-Fa-f0-9]{5}|LMacroeNB-[A-Fa-f0-9]{6}|SMacroeNB-[A-Fa-f0-9]{5}|HomeeNB-[A-Fa-f0-9]{7})$")
  eNbId?: string;

  @doc("gNodeB identifier.")
  gNbId?: GNbId;

  @doc("N3 IWF identifier.")
  @pattern("^[A-Fa-f0-9]+$")
  n3IwfId?: string;

  @doc("NG-eNodeB identifier.")
  @pattern("^(MacroNGeNB-[A-Fa-f0-9]{5}|LMacroNGeNB-[A-Fa-f0-9]{6}|SMacroNGeNB-[A-Fa-f0-9]{5})$")
  ngeNbId?: string;

  @doc("Network identifier.")
  @pattern("^[A-Fa-f0-9]{11}$")
  nid?: string;

  @doc("PLMN Identifier.")
  plmnId: PlmnId;

  @doc("TNGF identifier.")
  @pattern("^[A-Fa-f0-9]+$")
  tngfId?: string;

  @doc("W-AGF identifier.")
  @pattern("^[A-Fa-f0-9]+$")
  wagfId?: string;
}

@doc("UE Location Info properties.")
model UeLocationInfo {
  @doc("Location Type.")
  locationType: string;

  @doc("PLMN Identifier.")
  plmn: PlmnId;

  @doc("Type Allocation Code of UE.")
  tac: Tac;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
@doc("gNodeB identifier.")
model GNbId {
  @doc("Bit length.")
  @minValue(22)
  @maxValue(32)
  bitLength?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
  @doc("gNodeB value.")
  @pattern("^[A-Fa-f0-9]{6,8}$")
  gNBValue?: string;
}

@doc("Tracking Area Code (TAC).")
@pattern("(^[A-Fa-f0-9]{4}$)|(^[A-Fa-f0-9]{6}$)")
scalar Tac extends string;

@doc("UE Information for 5G.")
model UeInfo5G extends ExtendedUeInfoProperties {
  @doc("RAT type 5G.")
  ratType: RatType.`5G`;

  @doc("UE Information properties for 5G.")
  info: UeInfo5GProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
@doc("UE Information properties for 5G.")
model UeInfo5GProperties {
  @doc("UE Connection Info for 5G.")
  connectionInfo?: UeConnectionInfo5G;

  @doc("Globally Unique Temporary Identifier (5G).")
  fivegGuti: Guti5G;

  @doc("Permanent Equipment Identifier.")
  pei?: Pei;

  @doc("UE Session Info for 5G.")
  @maxItems(15)
  @extension("x-ms-identifiers", [])
  sessionInfo?: Array<UeSessionInfo5G>;

  @doc("Subscription Permanent Identifier.")
  supi: Supi;
}

@doc("UE Connection Info for 5G.")
model UeConnectionInfo5G {
  @doc("Allowed Network Slice Selection Assistance Information.")
  @maxItems(8)
  @extension("x-ms-identifiers", [])
  allowedNssai?: Array<Snssai>;

  @doc("The AMF UE NGAP ID.")
  @minValue(0)
  amfUeNgapId: int64;

  @doc("Global RAN Node ID.")
  globalRanNodeId: GlobalRanNodeId;

  @doc("The timestamp of last activity of UE (UTC).")
  lastActivityTime?: utcDateTime;

  @doc("Last Visited TAI.")
  lastVisitedTai?: string;

  @doc("UE Location Info properties.")
  locationInfo?: UeLocationInfo;

  @doc("Per-UE transport network layer association.")
  perUeTnla?: string;

  @doc("The RAN UE NGAP ID.")
  @minValue(0)
  @maxValue(4294967295)
  ranUeNgapId: int32;

  @doc("Radio connection establishment cause.")
  rrcEstablishmentCause: RrcEstablishmentCause;

  @doc("State of the UE.")
  ueState: UeState;

  @doc("The UE's usage setting.")
  ueUsageSetting?: UeUsageSetting;
}

@doc("Globally Unique Temporary Identifier (5G).")
model Guti5G {
  @doc("AMF identifier.")
  amfId: AmfId;

  @doc("5G Temporary Mobile Subscriber Identity.")
  @minValue(0)
  @maxValue(4294967295)
  fivegTmsi: int32;

  @doc("PLMN Identifier.")
  plmn: PlmnId;
}

@doc("AMF identifier.")
model AmfId {
  @doc("AMF pointer.")
  @minValue(0)
  @maxValue(63)
  pointer: int32;

  @doc("AMF region identifier.")
  @minValue(0)
  @maxValue(255)
  regionId: int32;

  @doc("AMF set identifier.")
  @minValue(0)
  @maxValue(1023)
  setId: int32;
}

@doc("Permanent Equipment Identifier.")
@pattern("^(imei-[0-9]{15}|imeisv-[0-9]{16}|.+)$")
scalar Pei extends string;

@doc("UE Session Info for 5G.")
model UeSessionInfo5G {
  @doc("Aggregate maximum bit rate.")
  ambr: Ambr;

  @doc("Data network name.")
  dnn: Dnn;

  @doc("Packet Data Network Type.")
  pdnType: PdnType;

  @doc("PDU session identifier.")
  pduSessionId: PduSessionId;

  @doc("QoS Flow.")
  @extension("x-ms-identifiers", [])
  qosFlow: Array<UeQOSFlow>;

  @doc("Single-network slice selection assistance information (S-NSSAI).")
  snssai: Snssai;

  @doc("UE IP address.")
  ueIpAddress: UeIpAddress;
}

@doc("PDU session identifier.")
@minValue(0)
@maxValue(255)
scalar PduSessionId extends int32;

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
@doc("QoS Flow.")
model UeQOSFlow {
  @doc("5G QoS Identifier.")
  fiveqi: FiveQi;

  @doc("Guaranteed Bit Rate.")
  gbr?: Ambr;

  @doc("Maximum Bit Rate.")
  mbr?: Ambr;

  @doc("Qos Flow Identifier.")
  qfi: Qfi;
}

@doc("Qos Flow Identifier.")
@minValue(0)
@maxValue(63)
scalar Qfi extends int32;

@doc("Subscription Permanent Identifier.")
@pattern("^(imsi-[0-9]{5,15}|nai-.+|.+)$")
scalar Supi extends string;
