import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Data.Tables;

namespace ClientCustomizations;

// --- Client naming ---
// Rename client to "AzureTable*" to match old AutoRest naming.
// NOTE: The Python emitter always appends "Client" suffix, so this produces
// "AzureTableClient" / "AzureTableClientConfiguration" instead of
// "AzureTable" / "AzureTableConfiguration". The convenience layer handles the difference.
@@clientName(Data.Tables, "AzureTable", "python");

// --- Model renames to match old generated code ---
@@clientName(Data.Tables.TablesServiceError, "TableServiceError", "python");

// --- Parameter renames to match old generated code ---
// The "Prefer" header parameter is named "prefer" in TypeSpec but was
// "response_preference" in the old AutoRest-generated code
@@clientName(Data.Tables.Table.create::parameters.prefer,
  "responsePreference",
  "python"
);
@@clientName(Data.Tables.Table.insertEntity::parameters.prefer,
  "responsePreference",
  "python"
);

// --- AccessPolicy: use string types for start/expiry (not datetime) ---
@@alternateType(Data.Tables.AccessPolicy.start, string, "python");
@@alternateType(Data.Tables.AccessPolicy.expiry, string, "python");

// --- SignedIdentifier: override to match old structure ---
/** The signed identifier. */
model SignedIdentifier {
  /** The unique ID for the signed identifier. */
  @Xml.name("Id") id: string;

  /** The access policy for the signed identifier. */
  @Xml.name("AccessPolicy") accessPolicy?: AccessPolicy;
}
@@alternateType(Data.Tables.SignedIdentifier, SignedIdentifier, "python");
