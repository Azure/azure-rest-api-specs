import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./Group.tsp";
import "./models/DeviceClassSubgroupProperties.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.DeviceUpdate;
/**
 * Device Update Device Class Subgroup details.
 */
@parentResource(Group)
@added(Versions.v2025_05_01_preview)
model DeviceClassSubgroup
  is Azure.ResourceManager.TrackedResource<DeviceClassSubgroupProperties> {
  ...ResourceNameParameter<
    Resource = DeviceClassSubgroup,
    KeyName = "subgroupName",
    SegmentName = "deviceClassSubgroups",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the DeviceClassSubgroup.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_05_01_preview)
  extendedLocation?: ExtendedLocation;
}

@added(Versions.v2025_05_01_preview)
@armResourceOperations
interface DeviceClassSubgroups {
  /**
   * Returns Device Class Subgroup details.
   */
  get is ArmResourceRead<DeviceClassSubgroup>;

  /**
   * Creates or updates a Device Class Subgroup.
   */
  create is ArmResourceCreateOrReplaceSync<DeviceClassSubgroup>;

  /**
   * Updates a Device Class Subgroup.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<DeviceClassSubgroup, TagUpdate>;

  /**
   * Delete Device Class Subgroup.
   */
  delete is ArmResourceDeleteSync<DeviceClassSubgroup>;

  /**
   * Returns Device Class Subgroups for the given group name.
   */
  listByUpdateAccountAndGroup is ArmResourceListByParent<DeviceClassSubgroup>;
}

@@maxLength(DeviceClassSubgroup.name, 255);
@@minLength(DeviceClassSubgroup.name, 1);
@@doc(DeviceClassSubgroup.name, "DeviceClassSubgroup Name");
@@doc(DeviceClassSubgroups.create::parameters.resource,
  "DeviceClassSubgroup details."
);
@@doc(DeviceClassSubgroups.update::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@clientName(DeviceClassSubgroups.create::parameters.resource,
  "deviceclasssubgroup"
);

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(DeviceClassSubgroups.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(DeviceClassSubgroups.update::parameters.properties,
  "tagUpdatePayload"
);
