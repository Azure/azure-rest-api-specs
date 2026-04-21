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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.interconnectGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
model InterconnectGroup extends Common.Resource {
  /** Properties of the interconnect group. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-client-flatten is required for backward compatibility with existing Network SDKs"
  @extension("x-ms-client-flatten", true)
  properties?: InterconnectGroupPropertiesFormat;

  /** The name of the interconnect group. */
  @visibility(Lifecycle.Read)
  @path
  @key("interconnectGroupName")
  @segment("interconnectGroups")
  @pattern("^[^_\\W][\\w-._]{0,79}(?<![-.])$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * A subgroup in an interconnect group.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.interconnectGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(InterconnectGroup)
model Subgroup extends Common.SubResourceModel {
  /** Properties of the subgroup. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-client-flatten is required for backward compatibility with existing Network SDKs"
  @extension("x-ms-client-flatten", true)
  properties?: SubgroupProperties;

  /** The name of the subgroup. */
  @visibility(Lifecycle.Read)
  @path
  @key("subgroupName")
  @segment("subgroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.interconnectGroup)
@armResourceOperations
interface InterconnectGroups {
  /**
   * Gets information about the specified interconnect group.
   */
  get is ArmResourceRead<InterconnectGroup, Error = CloudError>;

  /**
   * Creates or updates an interconnect group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InterconnectGroup,
    Error = CloudError
  >;

  /**
   * Updates an interconnect group tags.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    InterconnectGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.interconnectGroup)
@armResourceOperations
interface Subgroups {
  /**
   * Gets the specified subgroup by interconnect group.
   */
  get is ArmResourceRead<Subgroup, Error = CloudError>;

  /**
   * Gets all subgroups in an interconnect group.
   */
  list is ArmResourceListByParent<Subgroup, Error = CloudError>;
}

@@doc(InterconnectGroup.name, "The name of the interconnect group.");
@@doc(InterconnectGroup.properties, "Properties of the interconnect group.");
@@doc(InterconnectGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update interconnect group operation."
);
@@doc(InterconnectGroups.updateTags::parameters.properties,
  "Parameters supplied to update interconnect group tags."
);
@@clientName(InterconnectGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(InterconnectGroups.updateTags::parameters.properties,
  "parameters"
);
