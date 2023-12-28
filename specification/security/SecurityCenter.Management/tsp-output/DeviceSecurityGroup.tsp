import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("The device security group resource")
model DeviceSecurityGroup is ExtensionResource<DeviceSecurityGroupProperties> {
  @doc("The name of the device security group. Note that the name of the device security group is case insensitive.")
  @key("deviceSecurityGroupName")
  @segment("deviceSecurityGroups")
  name: string;
}

@armResourceOperations
interface DeviceSecurityGroups {
  @doc("Use this method to get the device security group for the specified IoT Hub resource.")
  get is ArmResourceRead<DeviceSecurityGroup>;
  @doc("Use this method to creates or updates the device security group on a specified IoT Hub resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DeviceSecurityGroup>;
  @doc("User this method to deletes the device security group.")
  delete is ArmResourceDeleteSync<DeviceSecurityGroup>;
  @doc("Use this method get the list of device security groups for the specified IoT Hub resource.")
  list is ArmResourceListByParent<DeviceSecurityGroup>;
}
