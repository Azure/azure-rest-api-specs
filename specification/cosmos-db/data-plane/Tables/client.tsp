import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Data.Tables;

namespace ClientCustomizations;

@@clientNamespace(Data.Tables, "Azure.Data.Tables._generated", "python");
@@clientNamespace(Data.Tables.Service,
  "Azure.Data.Tables._generated",
  "python"
);
@@clientNamespace(Data.Tables.Table, "Azure.Data.Tables._generated", "python");
@@clientNamespace(ClientCustomizations,
  "Azure.Data.Tables._generated",
  "python"
);

@@alternateType(Data.Tables.AccessPolicy.start, string, "python");
@@alternateType(Data.Tables.AccessPolicy.expiry, string, "python");

/** The signed identifier. */
model SignedIdentifier {
  /** The unique ID for the signed identifier. */
  @Xml.name("Id") id: string;

  /** The access policy for the signed identifier. */
  @Xml.name("AccessPolicy") accessPolicy?: AccessPolicy;
}
@@alternateType(Data.Tables.SignedIdentifier, SignedIdentifier, "python");
