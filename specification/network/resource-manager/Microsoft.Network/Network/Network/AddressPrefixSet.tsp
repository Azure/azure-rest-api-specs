import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ApplicationSecurityGroup.tsp";
import "../Common/ApplicationSecurityGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

/**
 * Address prefix set child resource of an application security group.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy sub-resource model uses ARM private types for compatibility with existing Network RP patterns"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "AddressPrefixSet is a sub-resource of ApplicationSecurityGroup using legacy Network RP resource patterns"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extends SubResourceModel to match existing Network RP sub-resource conventions"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Uses legacy ARM resource patterns consistent with other Network RP sub-resources"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(ApplicationSecurityGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
model AddressPrefixSet extends SubResourceModel {
  /** Properties of the address prefix set. */
  properties?: AddressPrefixSetPropertiesFormat;

  /** The name of the address prefix set. */
  @visibility(Lifecycle.Read)
  @path
  @key("addressPrefixSetName")
  @segment("addressPrefixSets")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9_.-]{0,78}[a-zA-Z0-9_])?$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is a standard ARM envelope property returned by the Network RP for concurrency control"
  @visibility(Lifecycle.Read)
  etag?: string;

  /** Type of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "type is a standard ARM envelope property indicating the resource type"
  @visibility(Lifecycle.Read)
  type?: string;

  /** The system metadata related to this resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "systemData is a standard ARM envelope property for resource metadata tracking"
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * Properties of address prefix set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Uses legacy ARM resource patterns consistent with other Network RP property models"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AddressPrefixSetPropertiesFormat {
  /** The list of address prefixes in CIDR notation. Supports both IPv4 and IPv6 CIDR notation (e.g. '10.0.0.0/16', '2001:db8::/32'). */
  @minItems(1)
  addressPrefixes: string[];

  /** The provisioning state of the address prefix set resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Uses legacy ARM resource patterns consistent with other Network RP operation interfaces"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface AddressPrefixSets {
  /**
   * Gets the specified address prefix set.
   */
  @tag("AddressPrefixSets")
  get is ArmResourceRead<AddressPrefixSet, Error = CloudError>;

  /**
   * Creates or updates an address prefix set.
   */
  @tag("AddressPrefixSets")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AddressPrefixSet,
    Error = CloudError
  >;

  /**
   * Deletes the specified address prefix set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Network RP delete operations use 202+204 pattern without 200, matching existing ASG and other resource delete conventions"
  @tag("AddressPrefixSets")
  delete is ArmResourceDeleteWithoutOkAsync<
    AddressPrefixSet,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all address prefix sets in an application security group.
   */
  @tag("AddressPrefixSets")
  list is ArmResourceListByParent<AddressPrefixSet, Error = CloudError>;
}

@@doc(AddressPrefixSet.name, "The name of the address prefix set.");
@@doc(AddressPrefixSet.properties, "Properties of the address prefix set.");
@@doc(
  AddressPrefixSets.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update address prefix set operation."
);
