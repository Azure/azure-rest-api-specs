import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.MachineLearningServices;

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @visibility(Lifecycle.Read)
  @doc("The timestamp the resource was created at.")
  createdAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The identity that created the resource.")
  createdBy?: string;

  @visibility(Lifecycle.Read)
  @doc("The identity type that created the resource.")
  createdByType?: string;

  @visibility(Lifecycle.Read)
  @doc("The timestamp of resource last modification (UTC)")
  lastModifiedAt?: utcDateTime;
}
