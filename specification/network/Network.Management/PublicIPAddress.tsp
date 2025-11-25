import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkInterface.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Public IP address resource.
 */
@parentResource(NetworkInterface)
model PublicIPAddress
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PublicIPAddressPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = PublicIPAddress,
    KeyName = "publicIpAddressName",
    SegmentName = "publicipaddresses",
    NamePattern = ""
  >;

  /**
   * The extended location of the public ip address.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * The public IP address SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: PublicIPAddressSku;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

alias PublicIPAddressOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    @path
    @segment("providers")
    providerName: "microsoft.Compute";

    /** The name of the cloud service. */
    @path
    @segment("cloudServices")
    @key
    cloudServiceName: string;

    /** The role instance name. */
    @path
    @segment("roleInstances")
    @key
    roleInstanceName: string;

    /** The name of the network interface. */
    @path
    @segment("networkInterfaces")
    @key
    networkInterfaceName: string;

    /** The name of the IP configuration. */
    @path
    @segment("ipconfigurations")
    @key
    ipConfigurationName: string;
  },
  {
    /** The name of the public IP Address. */
    @path
    @segment("publicipaddresses")
    @key
    publicIpAddressName: string;
  }
>;

alias PublicIPAddressSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the public IP Address. */
    @path
    @segment("publicIPAddresses")
    @key
    publicIpAddressName: string;
  }
>;

@armResourceOperations
interface PublicIPAddresses {
  /**
   * Get the specified public IP address in a cloud service.
   */
  getCloudServicePublicIPAddress is PublicIPAddressOps.Read<
    PublicIPAddress,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Gets information about all public IP addresses in a role instance IP configuration in a cloud service.
   */
  listCloudServiceRoleInstancePublicIPAddresses is PublicIPAddressOps.List<PublicIPAddress, OverrideErrorType = CloudError>;
}
alias PublicIPAddressOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the public IP address. */
    @path
    @segment("publicIPAddresses")
    @key
    publicIpAddressName: string;
  }
>;

@armResourceOperations
interface PublicIPAddressOperationGroup {
  /**
   * Gets the specified public IP address in a specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_Get")
  get is PublicIPAddressOperationGroupOps.Read<
    PublicIPAddress,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a static or dynamic public IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_CreateOrUpdate")
  createOrUpdate is PublicIPAddressOperationGroupOps.CreateOrUpdateAsync<PublicIPAddress,  OverrideErrorType = CloudError>;

  /**
   * Updates public IP address tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is PublicIPAddressOperationGroupOps.CustomPatchSync<
    PublicIPAddress,
    PatchModel = TagsObject,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified public IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PublicIPAddresses_Delete")
  delete is PublicIPAddressOperationGroupOps.DeleteWithoutOkAsync<
    PublicIPAddress,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
,    OverrideErrorType = CloudError>;

  /**
   * Gets all public IP addresses in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_List")
  list is PublicIPAddressOperationGroupOps.List<PublicIPAddress, OverrideErrorType = CloudError>;

  /**
   * Gets all the public IP addresses in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_ListAll")
  listAll is PublicIPAddressSubscriptionOps.List<PublicIPAddress, OverrideErrorType = CloudError>;

  /**
   * Gets the Ddos Protection Status of a Public IP Address
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_DdosProtectionStatus")
  ddosProtectionStatus is PublicIPAddressOperationGroupOps.ActionAsync<
    PublicIPAddress,
    void,
    ArmResponse<PublicIpDdosProtectionStatusResult>
  >;

  /**
   * Reserves the specified Cloud Service Public IP by switching its allocation method to Static. If rollback is requested, reverts the allocation method to Dynamic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_ReserveCloudServicePublicIpAddress")
  reserveCloudServicePublicIpAddress is PublicIPAddressOperationGroupOps.ActionAsync<
    PublicIPAddress,
    ReserveCloudServicePublicIpAddressRequest,
    ArmResponse<PublicIPAddress>
  >;

  /**
   * Disassociates the Cloud Service reserved Public IP and associates the specified Standalone Public IP to the same Cloud Service frontend.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_DisassociateCloudServiceReservedPublicIp")
  disassociateCloudServiceReservedPublicIp is PublicIPAddressOperationGroupOps.ActionAsync<
    PublicIPAddress,
    DisassociateCloudServicePublicIpRequest,
    ArmResponse<PublicIPAddress>
  >;
}

@@doc(PublicIPAddress.name, "The name of the public IP Address.");
@@doc(PublicIPAddress.properties, "Public IP address properties.");
@@doc(PublicIPAddressOperationGroup.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update public IP address operation."
);
@@doc(PublicIPAddressOperationGroup.updateTags::parameters.properties,
  "Parameters supplied to update public IP address tags."
);
@@doc(PublicIPAddressOperationGroup.reserveCloudServicePublicIpAddress::parameters.body,
  "Parameter that define which Public IP Address should be associated in place of given Public IP Address."
);
@@doc(PublicIPAddressOperationGroup.disassociateCloudServiceReservedPublicIp::parameters.body,
  "Parameter that define which Public IP Address should be associated in place of given Public IP Address."
);
