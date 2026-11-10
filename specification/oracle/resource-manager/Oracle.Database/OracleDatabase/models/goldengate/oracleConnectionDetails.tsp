import "./connectionBase.tsp";

using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@doc("Allowed modes for database connection session.")
union SessionMode {
  @doc("For a non-RAC database.")
  Direct: "DIRECT",

  @doc("For a RAC database.")
  Redirect: "REDIRECT",

  string,
}

@added(Versions.v20260301_preview)
@doc("Allowed values for Oracle technology type.")
union OracleConnectionTechnologyType {
  @doc("Oracle databases hosted on Amazon RDS.")
  AmazonRdsOracle: "AMAZON_RDS_ORACLE",

  @doc("OCI Autonomous Database.")
  OciAutonomousDatabase: "OCI_AUTONOMOUS_DATABASE",

  @doc("On-premise Oracle database.")
  OracleDatabase: "ORACLE_DATABASE",

  @doc("On-premise Exadata database.")
  OracleExadata: "ORACLE_EXADATA",

  @doc("Exadata database on Azure.")
  OracleExadataDatabaseAtAzure: "ORACLE_EXADATA_DATABASE_AT_AZURE",

  @doc("Exadata database on GCP.")
  OracleExadataDatabaseAtGoogleCloud: "ORACLE_EXADATA_DATABASE_AT_GOOGLE_CLOUD",

  @doc("Exadata database on AWS.")
  OracleExadataDatabaseAtAws: "ORACLE_EXADATA_DATABASE_AT_AWS",

  @doc("Autonomous database on Azure.")
  OracleAutonomousDatabaseAtAzure: "ORACLE_AUTONOMOUS_DATABASE_AT_AZURE",

  @doc("Autonomous database on GCP.")
  OracleAutonomousDatabaseAtGoogleCloud: "ORACLE_AUTONOMOUS_DATABASE_AT_GOOGLE_CLOUD",

  @doc("Autonomous database on AWS.")
  OracleAutonomousDatabaseAtAws: "ORACLE_AUTONOMOUS_DATABASE_AT_AWS",

  string,
}

@added(Versions.v20260301_preview)
@doc("The metadata of an Oracle Database Connection.")
model OracleConnectionDetails extends ConnectionBaseProperties {
  connectionType: ConnectionType.Oracle;

  @doc("The Oracle technology type.")
  technologyType: OracleConnectionTechnologyType;

  @doc("The mode of the database connection session to be established by the data client.")
  sessionMode?: SessionMode;

  @doc("The username that is used to connect the associated system of the given technology.")
  username: string;

  @doc("The connection string used to connect the associated database.")
  connectionString?: string;

  @doc("The authentication mode used to connect the associated database.")
  authenticationMode?: string;

  @doc("The OCID of the Secret where the password is stored.")
  passwordSecretId?: Ocid;

  @doc("The OCID of the Secret where the wallet is stored.")
  walletSecretId?: Ocid;

  @doc("The OCID of the associated database.")
  databaseId?: Ocid;

  @doc("The private IP of the associated database endpoint.")
  privateIp?: string;
}
