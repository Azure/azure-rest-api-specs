namespace DeveloperServicesApi.Models;

@doc("API Version Set")
model ApiVersionSet {
  @doc("API Version Set identifier.")
  id: string;

  @doc("API Version Set name.")
  name: string;

  @doc("API Version Set description.")
  description: string;

  @doc("Versioning scheme.")
  versioningScheme: ApiVersionSetScheme;

  @doc("Version query name.")
  versionQueryName: string;

  @doc("Version header name.")
  versionHeaderName: string;
}

@doc("Versioning scheme types.")
enum ApiVersionSetScheme {
  @doc("Use segment for versioning scheme")
  Segment: "Segment",

  @doc("Use query for versioning scheme")
  Query: "Query",

  @doc("Use header for versioning scheme")
  Header: "Header",
}
