import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./othermodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.SustainabilityServices;

@doc("Reference data.")
@resource("reference-data")
model ReferenceDataEntities {
  @doc("Logical name of the entity. Example: fueltype.")
  @key
  @visibility(Lifecycle.Read)
  entityName: string;

  @doc("Display name of the entity. Example: Fuel Type.")
  displayName: string;

  @doc("Schema name of the entity.")
  schemaName: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("Entity record.")
@parentResource(ReferenceDataEntities)
@resource("entity-records")
model EntityRecord {
  @doc("Record ID.")
  @key
  @visibility(Lifecycle.Read)
  id: uuid;

  @doc("Entity data.")
  data: Record<unknown>;
}
