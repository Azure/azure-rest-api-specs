namespace DeveloperServicesAPI.Models;

model ApiVersionSet {
  id: string;
  name: string;
  description: string;
  versioningScheme: ApiVersionSetScheme;
  versionQueryName: string;
  versionHeaderName: string;
}

enum ApiVersionSetScheme {
  Segment: "Segment",
  Query: "Query",
  Header: "Header",
}
