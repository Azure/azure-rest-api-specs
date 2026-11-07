import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared-models.tsp";
import "./NetworkInterface.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * IPConfiguration in a network interface.
 */
@featureFile(Features.virtualNetwork)
@parentResource(NetworkInterface)
model NetworkInterfaceIPConfiguration
  is SubResourceInstance<NetworkInterfaceIPConfigurationPropertiesFormat> {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  @path
  @key("ipConfigurationName")
  @segment("ipConfigurations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(
  NetworkInterfaceIPConfiguration.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
