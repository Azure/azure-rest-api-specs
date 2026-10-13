import "./connection.tsp";

using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@doc("Allowed values for Microsoft Fabric technology type.")
union MicrosoftFabricConnectionTechnologyType {
  @doc("The Microsoft Fabric Lakehouse type.")
  MicrosoftFabricLakehouse: "MICROSOFT_FABRIC_LAKEHOUSE",

  @doc("The Microsoft Fabric Mirror type.")
  MicrosoftFabricMirror: "MICROSOFT_FABRIC_MIRROR",

  string,
}

@added(Versions.v20260301_preview)
@doc("The metadata of a Microsoft Fabric Connection.")
model MicrosoftFabricConnectionDetails extends ConnectionBaseProperties {
  connectionType: ConnectionType.MicrosoftFabric;

  @doc("The Microsoft Fabric technology type.")
  technologyType: MicrosoftFabricConnectionTechnologyType;

  @doc("Azure tenant ID of the application.")
  @minLength(1)
  @maxLength(36)
  tenantId: string;

  @doc("Azure client ID of the application.")
  @minLength(1)
  @maxLength(36)
  clientId: string;

  @doc("The OCID of the Secret where the client secret is stored.")
  clientSecretSecretId?: Ocid;

  @doc("The Microsoft Fabric service endpoint.")
  @maxLength(261)
  endpoint?: url;
}
