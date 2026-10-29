import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * An application security group in a resource group.
 */
@featureFile(Features.virtualNetwork)
model ApplicationSecurityGroup
  is ResourceInstance<ApplicationSecurityGroupPropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("applicationSecurityGroupName")
  @segment("applicationSecurityGroups")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(
  ApplicationSecurityGroup.name,
  "The name of the application security group."
);
@@doc(
  ApplicationSecurityGroup.properties,
  "Properties of the application security group."
);
