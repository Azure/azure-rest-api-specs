import "./../main.tsp";

import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Neon.Postgres;

// Define a reusable base resource model for all sub entities
@doc("Base model for all tracked resources")
@added(Neon.Postgres.Versions.v2_preview)
model BaseEntity {
  @doc("Unique identifier for the entity")
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9-]{1,60}$")
  entityId?: string;

  @doc("Name of the resource")
  @pattern("^\\S.{0,62}\\S$|^\\S$")
  entityName?: string;

  @doc("Timestamp indicating when the entity was created")
  @visibility(Lifecycle.Read)
  createdAt?: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Additional attributes for the entity")
  @identifiers(#[])
  attributes?: Attributes[];
}

@doc("Additional attributes specific to Neon Resources")
@added(Neon.Postgres.Versions.v2_preview)
model Attributes {
  @doc("Name of the attribute")
  name: string;

  @doc("Value of the attribute")
  value: string;
}

@doc("PostgreSQL Version model")
@added(Neon.Postgres.Versions.v2_preview)
model PgVersion {
  @doc("The major PostgreSQL version number")
  version?: int32;
}

@doc("Response model for PostgreSQL versions")
@added(Neon.Postgres.Versions.v2_preview)
model PgVersionsResult {
  @doc("List of PostgreSQL versions")
  @identifiers(#[])
  versions: PgVersion[];
}
