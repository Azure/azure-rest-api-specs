import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

alias SnapshotIdQueryParameter = {
  @doc("Required parameter that specifies the snapshot id to use for the restore operation.")
  @query
  snapshotId: string;
};

alias DelayUntilQueryParameter = {
  @doc("The time to delay the Dev Box action or actions until, in RFC3339 format.")
  @query("until")
  delayUntil: utcDateTime;
};

alias HibernateQueryParameter = {
  @doc("Optional parameter to hibernate the dev box.")
  @query
  hibernate?: boolean;
};

alias DevBoxNameParameter = {
  @doc("The name of a Dev Box.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @path
  devBoxName: string;
};
