import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

@doc("The snapshot id query parameter.")
model SnapshotIdQueryParameter {
  @doc("Required parameter that specifies the snapshot id to use for the restore operation.")
  @query
  snapshotId: string;
}

@doc("The delay until query parameter.")
model DelayUntilQueryParameter {
  @doc("The time to delay the Dev Box action or actions until, in RFC3339 format.")
  @query("until")
  delayUntil: utcDateTime;
}

@doc("The hibernate query parameter.")
model HibernateQueryParameter {
  @doc("Optional parameter to hibernate the dev box.")
  @query
  hibernate?: boolean;
}

@doc("The Dev Box name path parameter.")
model DevBoxNameParameter {
  @doc("The name of a Dev Box.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @path
  devBoxName: string;
}
