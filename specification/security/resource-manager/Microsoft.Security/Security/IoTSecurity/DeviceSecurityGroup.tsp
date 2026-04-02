import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The device security group resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model DeviceSecurityGroup
  is Azure.ResourceManager.ExtensionResource<DeviceSecurityGroupProperties> {
  ...ResourceNameParameter<
    Resource = DeviceSecurityGroup,
    KeyName = "deviceSecurityGroupName",
    SegmentName = "deviceSecurityGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeviceSecurityGroups {
  /**
   * Use this method to get the device security group for the specified IoT Hub resource.
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    DeviceSecurityGroup,
    Error = CloudError
  >;

  /**
   * Use this method to creates or updates the device security group on a specified IoT Hub resource.
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    DeviceSecurityGroup,
    Error = CloudError
  >;

  /**
   * User this method to deletes the device security group.
   */
  delete is Azure.ResourceManager.Extension.DeleteSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    DeviceSecurityGroup,
    Error = CloudError
  >;

  /**
   * Use this method get the list of device security groups for the specified IoT Hub resource.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    DeviceSecurityGroup,
    Response = ArmResponse<DeviceSecurityGroupList>,
    Error = CloudError
  >;
}

@@doc(DeviceSecurityGroup.name,
  "The name of the device security group. Note that the name of the device security group is case insensitive."
);
@@doc(DeviceSecurityGroup.properties, "Device Security group data");
@@doc(DeviceSecurityGroups.createOrUpdate::parameters.resource,
  "Security group object."
);
