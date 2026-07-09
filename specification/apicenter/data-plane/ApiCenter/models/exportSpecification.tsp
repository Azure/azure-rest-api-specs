namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("Export specification result model.")
@resource("definitions")
@parentResource(ApiVersion)
model ApiSpecExportResult {
  @doc("API definition identifier.")
  @key("definitionName")
  @visibility(Lifecycle.Query)
  definitionName: string;

  @doc("The result of the specification export.")
  value: string;

  @doc("The format of the specification export result.")
  format: ApiSpecExportResultFormat;
}

@doc("Export specification result format")
union ApiSpecExportResultFormat {
  string,

  @doc("Link format")
  Link: "link",
}
