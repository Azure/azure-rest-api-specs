import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Data.Tables;

namespace ClientCustomizations;

@@clientNamespace(Data.Tables, "Azure.Data.Tables._generated", "python");
@@clientNamespace(
  Data.Tables.Service,
  "Azure.Data.Tables._generated",
  "python"
);
@@clientNamespace(Data.Tables.Table, "Azure.Data.Tables._generated", "python");
@@clientNamespace(
  ClientCustomizations,
  "Azure.Data.Tables._generated",
  "python"
);

@@alternateType(AccessPolicy.start, string, "python,javascript");
@@alternateType(AccessPolicy.expiry, string, "python,javascript");

/** The signed identifier. */
model SignedIdentifier {
  /** The unique ID for the signed identifier. */
  @Xml.name("Id") id: string;

  /** The access policy for the signed identifier. */
  @Xml.name("AccessPolicy") accessPolicy?: AccessPolicy;
}
@@alternateType(SignedIdentifier, SignedIdentifier, "python");

@@clientName(TablesServiceError, "TableServiceError", "javascript");
@@clientName(Metrics.includeApis, "includeAPIs", "javascript");
@@clientName(EtagResponseHeader.eTag, "etag", "javascript");
