import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;
using Azure.ClientGenerator.Core;

namespace Microsoft.Network;

/**
 * An interconnect group resource.
 */
@added(Versions.v2025_07_01)
@featureFile(Features.interconnectGroup)
model InterconnectGroup is ResourceInstance<InterconnectGroupPropertiesFormat> {
  /** The name of the interconnect group. */
  @visibility(Lifecycle.Read)
  @path
  @key("interconnectGroupName")
  @segment("interconnectGroups")
  @pattern("^[^_\\W][\\w-._]{0,79}(?<![-.])$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is a standard envelope property on Network RP resources for optimistic concurrency"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "flattenProperty is required for backward compatibility with existing Network SDKs"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  InterconnectGroup.properties
);
@@doc(InterconnectGroup.properties, "Properties of the interconnect group.");

/**
 * A subgroup in an interconnect group.
 */
@added(Versions.v2025_07_01)
@featureFile(Features.interconnectGroup)
@parentResource(InterconnectGroup)
model Subgroup is SubResourceInstance<SubgroupProperties> {
  /** The name of the subgroup. */
  @visibility(Lifecycle.Read)
  @path
  @key("subgroupName")
  @segment("subgroups")
  name: string;
}

@@doc(Subgroup.properties, "Properties of the subgroup.");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "flattenProperty is required for backward compatibility with existing Network SDKs"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Subgroup.properties);

@added(Versions.v2025_07_01)
@featureFile(Features.interconnectGroup)
@armResourceOperations
interface InterconnectGroups {
  /**
   * Gets information about the specified interconnect group.
   */
  get is ArmResourceRead<InterconnectGroup, Error = CloudError>;

  /**
   * Creates or updates an interconnect group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    InterconnectGroup,
    Error = CloudError
  >;

  /**
   * Updates interconnect group tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    InterconnectGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified interconnect group.
   */
  delete is ArmResourceDeleteSync<InterconnectGroup, Error = CloudError>;

  /**
   * Gets all interconnect groups in a resource group.
   */
  list is ArmResourceListByParent<InterconnectGroup, Error = CloudError>;

  /**
   * Gets all interconnect groups in a subscription.
   */
  listAll is ArmListBySubscription<InterconnectGroup, Error = CloudError>;

  /**
   * Gets node availability for all subgroups in the specified interconnect group.
   */
  @action("nodeAvailability")
  getNodeAvailability is ArmResourceActionAsync<
    InterconnectGroup,
    void,
    InterconnectGroupNodeAvailability,
    Error = CloudError
  >;
}

@added(Versions.v2025_07_01)
@featureFile(Features.interconnectGroup)
@armResourceOperations
interface Subgroups {
  /**
   * Gets the specified subgroup in an interconnect group.
   */
  get is ArmResourceRead<Subgroup, Error = CloudError>;

  /**
   * Gets all subgroups in an interconnect group.
   */
  list is ArmResourceListByParent<Subgroup, Error = CloudError>;
}

@@doc(InterconnectGroup.name, "The name of the interconnect group.");
@@doc(InterconnectGroup.properties, "Properties of the interconnect group.");
@@doc(
  InterconnectGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update interconnect group operation."
);
@@doc(
  InterconnectGroups.updateTags::parameters.properties,
  "Parameters supplied to update interconnect group tags."
);
@@clientName(
  InterconnectGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(
  InterconnectGroups.updateTags::parameters.properties,
  "parameters"
);
