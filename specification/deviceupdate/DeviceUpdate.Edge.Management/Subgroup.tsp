import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./Group.tsp";
import "./models/SubgroupProperties.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.DeviceUpdate;
/**
 * Device Update Subgroup details.
 */
@parentResource(Group)
@added(Versions.v2025_05_01_preview)
model Subgroup is Azure.ResourceManager.TrackedResource<SubgroupProperties> {
  ...ResourceNameParameter<
    Resource = Subgroup,
    KeyName = "subgroupName",
    SegmentName = "deviceClassSubgroups",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
}

@added(Versions.v2025_05_01_preview)
@armResourceOperations
interface Subgroups {
  /**
   * Returns Subgroup details.
   */
  get is ArmResourceRead<Subgroup>;

  /**
   * Creates or updates a Subgroup.
   */
  create is ArmResourceCreateOrReplaceSync<Subgroup>;

  /**
   * Updates a Subgroup.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Subgroup, TagUpdate>;

  /**
   * Delete Subgroup.
   */
  delete is ArmResourceDeleteSync<Subgroup>;

  /**
   * Returns Subgroups for the given group name.
   */
  listByUpdateAccountAndGroup is ArmResourceListByParent<Subgroup>;
}

@@maxLength(Subgroup.name, 255);
@@minLength(Subgroup.name, 1);
@@doc(Subgroup.name, "Subgroup Name");
@@doc(Subgroups.create::parameters.resource, "Subgroup details.");
@@doc(Subgroups.update::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@clientName(Subgroups.create::parameters.resource, "subgroup");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Subgroups.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Subgroups.update::parameters.properties, "tagUpdatePayload");
