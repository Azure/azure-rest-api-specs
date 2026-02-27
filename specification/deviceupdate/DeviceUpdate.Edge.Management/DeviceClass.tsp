import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./UpdateAccount.tsp";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.DeviceUpdate;
/**
 * Device Update Device Class details.
 */
@parentResource(UpdateAccount)
model DeviceClass
  is Azure.ResourceManager.TrackedResource<DeviceClassProperties> {
  ...ResourceNameParameter<
    Resource = DeviceClass,
    KeyName = "deviceClassName",
    SegmentName = "deviceClasses",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the DeviceClass.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface DeviceClasses {
  /**
   * Returns Device Class details.
   */
  get is ArmResourceRead<DeviceClass>;

  /**
   * Creates or updates a Device Class.
   */
  create is ArmResourceCreateOrReplaceSync<DeviceClass>;

  /**
   * Updates Device Class.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<DeviceClass, TagUpdate>;

  /**
   * Delete Device Class.
   */
  delete is ArmResourceDeleteSync<DeviceClass>;

  /**
   * Returns device compatibility classes for the given account name.
   */
  listByUpdateAccount is ArmResourceListByParent<DeviceClass>;
}

@@maxLength(DeviceClass.name, 255);
@@minLength(DeviceClass.name, 1);
@@doc(DeviceClass.name, "Device Class Name.");
@@doc(DeviceClasses.create::parameters.resource, "Device Class details.");
@@doc(DeviceClasses.update::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(DeviceClasses.create::parameters.resource,
  "application/json",
  "deviceClass"
);
@@clientName(DeviceClasses.create::parameters.resource, "deviceClass");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(DeviceClasses.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(DeviceClasses.update::parameters.properties, "tagUpdatePayload");
