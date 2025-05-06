using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
@doc("The Oracle Grid Infrastructure (GI) minor version resource definition.")
@parentResource(GiVersion)
model GiMinorVersion is ProxyResource<GiMinorVersionProperties> {
  ...ResourceNameParameter<GiMinorVersion>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20241201_preview)
@doc("The Oracle Grid Infrastructure (GI) minor version properties")
model GiMinorVersionProperties {
  @doc("A valid Oracle Grid Infrastructure (GI) software version.")
  @minLength(1)
  @maxLength(255)
  version: string;

  @doc("Grid Infrastructure Image Id")
  @minLength(1)
  @maxLength(255)
  gridImageOcid?: Ocid;
}

@added(Versions.v20241201_preview)
@doc("Provides GiMinorVersion query parameter for list operations.")
model GiMinorVersionFilter {
  @query
  @doc("If provided, filters the results to the set of database versions which are supported for the given shape family.")
  shapeFamily?: ShapeFamily;

  @query
  @doc("Filters the result for the given Azure Availability Zone")
  zone?: string;
}

@added(Versions.v20241201_preview)
@doc("Allowed values for GI Minor Versions shapeFamily filter")
union ShapeFamily {
  @doc("Family value for Exadata Shape")
  Exadata: "EXADATA",

  @doc("Family value for Exadb XS Shape")
  ExadbXs: "EXADB_XS",

  string,
}
