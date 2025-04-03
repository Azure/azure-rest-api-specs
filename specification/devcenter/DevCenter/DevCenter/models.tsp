import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace DevCenterService;

@doc("A pending approval.")
@resource("approvals")
@parentResource(Project)
@added(APIVersions.v2025_04_01_preview)
model Approval {
  @doc("The identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdBy?: Azure.Core.uuid;

  @doc("The identity type that created the resource.")
  @visibility(Lifecycle.Read)
  createdByType?: string;

  @doc("The timestamp the resource was created at.")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The resource that is pending approval.")
  @visibility(Lifecycle.Read)
  @key
  resourceUri: string;
}
