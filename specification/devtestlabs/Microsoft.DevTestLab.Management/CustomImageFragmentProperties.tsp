import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;

/**
 * Properties for updating a custom image.
 */
model CustomImageFragmentProperties {
  /**
   * The description of the custom image.
   */
  description?: string;

  /**
   * Indicates whether this custom image can be used for VM creation.
   */
  enabled?: EnableStatus;
}

/**
 * Properties for updating a virtual network.
 */
model VirtualNetworkFragmentProperties {
  /**
   * The description of the virtual network.
   */
  description?: string;

  /**
   * The external provider of the virtual network.
   */
  externalProviderResourceId?: string;

  /**
   * The resource ID of the subnet.
   */
  subnetId?: string;
}

/**
 * Properties for updating a bastion host.
 */
model BastionHostFragmentProperties {
  /**
   * The description of the bastion host.
   */
  description?: string;

  /**
   * The external provider of the bastion host.
   */
  externalProviderResourceId?: string;
}
