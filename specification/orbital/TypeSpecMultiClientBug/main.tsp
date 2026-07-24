import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@service(#{ title: "TypeSpec Multi-Client Bug Demo" })
@versioned(Versions)
@server("https://example.com", "Example service endpoint")
namespace TypeSpecMultiClientBug;

enum Versions {
  v2025_01_01: "2025-01-01",
}

// Dog model
model Dog {
  id: string;
  name: string;
}

// Cat model
model Cat {
  id: string;
  name: string;
}

// Dog-specific operations
@route("/dogs")
interface Dogs {
  @get
  @route("/{id}")
  get(@path id: string, @query `api-version`: Versions): Dog;
}

// Cat-specific operations
@route("/cats")
interface Cats {
  @get
  @route("/{id}")
  get(@path id: string, @query `api-version`: Versions): Cat;
}
