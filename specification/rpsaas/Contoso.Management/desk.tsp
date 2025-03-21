import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Contoso;

/** Desk resource */
@parentResource(Employee)
model Desk is TrackedResource<DeskProperties> {
  ...ResourceNameParameter<Desk>;
}

/** Desk properties */
model DeskProperties {
  /** Type of Desk */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(20)
  deskType: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Desks {
  get is ArmResourceRead<Desk>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Desk>;
  update is ArmResourcePatchSync<Desk, DeskProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Desk>;
  list is ArmResourceListByParent<Desk>;
}
