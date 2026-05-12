import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkInterface.tsp";
import "../Common/PublicIPAddress.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;

alias PublicIPAddressOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface PublicIPAddresses {
  /**
   * Get the specified public IP address in a cloud service.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listCloudServiceRoleInstancePublicIPAddresses is PublicIPAddressOps.List<
    PublicIPAddress,
    OverrideErrorType = CloudError
  >;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface PublicIPAddressOperationGroup {
  /**
   * Gets the specified public IP address in a specified resource group.
   */
  @tag("PublicIPAddresses")
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
  @tag("PublicIPAddresses")
  createOrUpdate is PublicIPAddressOperationGroupOps.CreateOrUpdateAsync<
    PublicIPAddress,
    OverrideErrorType = CloudError
  >;

  /**
   * Updates public IP address tags.
   */
  @tag("PublicIPAddresses")
  @patch(#{ implicitOptionality: false })
  updateTags is PublicIPAddressOperationGroupOps.CustomPatchSync<
    PublicIPAddress,
    PatchModel = TagsObject,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified public IP address.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PublicIPAddresses")
  delete is PublicIPAddressOperationGroupOps.DeleteWithoutOkAsync<
    PublicIPAddress,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all public IP addresses in a resource group.
   */
  @tag("PublicIPAddresses")
  list is PublicIPAddressOperationGroupOps.List<
    PublicIPAddress,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all the public IP addresses in a subscription.
   */
  @tag("PublicIPAddresses")
  listAll is PublicIPAddressSubscriptionOps.List<
    PublicIPAddress,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the Ddos Protection Status of a Public IP Address
   */
  @tag("PublicIPAddresses")
  ddosProtectionStatus is PublicIPAddressOperationGroupOps.ActionAsync<
    PublicIPAddress,
    void,
    PublicIpDdosProtectionStatusResult,
    OverrideErrorType = CloudError
  >;

  /**
   * Reserves the specified Cloud Service Public IP by switching its allocation method to Static. If rollback is requested, reverts the allocation method to Dynamic.
   */
  @tag("PublicIPAddresses")
  reserveCloudServicePublicIpAddress is PublicIPAddressOperationGroupOps.ActionAsync<
    PublicIPAddress,
    ReserveCloudServicePublicIpAddressRequest,
    Result = void,
    Response = ArmResponse<PublicIPAddress> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PublicIPAddress> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Disassociates the Cloud Service reserved Public IP and associates the specified Standalone Public IP to the same Cloud Service frontend.
   */
  @tag("PublicIPAddresses")
  disassociateCloudServiceReservedPublicIp is PublicIPAddressOperationGroupOps.ActionAsync<
    PublicIPAddress,
    DisassociateCloudServicePublicIpRequest,
    Result = void,
    Response = ArmResponse<PublicIPAddress> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PublicIPAddress> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
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
