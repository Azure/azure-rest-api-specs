import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Widget;

/** Badge assignment extension resource */
model BadgeAssignment is ProxyResource<BadgeAssignmentProperties> {
  ...ResourceNameParameter<BadgeAssignment>;
}

/** Badge assignment properties */
model BadgeAssignmentProperties {
  /** Identifier of the badge. */
  badgeId: string;

  /** The date when the badge was assigned. */
  assignedDate?: plainDate;

  /** Indicates whether the badge assignment is active. */
  isActive?: boolean;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface BadgeAssignments {
  get is ArmResourceRead<BadgeAssignment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BadgeAssignment>;
  update is ArmResourcePatchSync<BadgeAssignment, BadgeAssignmentProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<BadgeAssignment>;
  listByParent is ArmResourceListByParent<BadgeAssignment>;
}
