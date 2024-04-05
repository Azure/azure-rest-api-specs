using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Oracle.Database;

scalar AutonomousDatabaseId extends ResourceIdentifier<[
  {
    type: "Oracle.Database/autonomousDatabases",
  }
]>;