import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace IoTSecurityAPI;
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

alias DeviceSecurityGroupsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The name of the device security group. Note that the name of the device security group is case insensitive. */
    @path
    @segment("deviceSecurityGroups")
    @key
    deviceSecurityGroupName: string;
  }
>;

@armResourceOperations
interface DeviceSecurityGroups {
  /**
   * Use this method to get the device security group for the specified IoT Hub resource.
   */
  get is DeviceSecurityGroupsOps.Read<
    DeviceSecurityGroup,
    ErrorType = CloudError
  >;

  /**
   * Use this method to creates or updates the device security group on a specified IoT Hub resource.
   */
  createOrUpdate is DeviceSecurityGroupsOps.CreateOrUpdateSync<
    DeviceSecurityGroup,
    ErrorType = CloudError
  >;

  /**
   * User this method to deletes the device security group.
   */
  delete is DeviceSecurityGroupsOps.DeleteSync<
    DeviceSecurityGroup,
    ErrorType = CloudError
  >;

  /**
   * Use this method get the list of device security groups for the specified IoT Hub resource.
   */
  list is DeviceSecurityGroupsOps.List<
    DeviceSecurityGroup,
    Response = ArmResponse<DeviceSecurityGroupList>,
    ErrorType = CloudError
  >;
}

@@doc(
  DeviceSecurityGroup.name,
  "The name of the device security group. Note that the name of the device security group is case insensitive."
);
@@doc(DeviceSecurityGroup.properties, "Device Security group data");
@@doc(
  DeviceSecurityGroups.createOrUpdate::parameters.resource,
  "Security group object."
);
