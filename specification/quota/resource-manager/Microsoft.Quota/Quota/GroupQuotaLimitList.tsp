import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GroupQuotasEntity.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Quota;
/**
 * List of Group Quota Limit details.
 */
@parentResource(GroupQuotasEntity)
model GroupQuotaLimitList
  is Azure.ResourceManager.ProxyResource<GroupQuotaLimitListProperties> {
  ...ResourceNameParameter<
    Resource = GroupQuotaLimitList,
    KeyName = "location",
    SegmentName = "groupQuotaLimits",
    NamePattern = ""
  >;
}

alias GroupQuotaLimitListsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    @key
    @minLength(3)
    @maxLength(63)
    managementGroupId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;

    /**
     * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
     */
    @path
    @segment("groupQuotas")
    @minLength(3)
    @maxLength(63)
    @key
    @pattern("^[a-z][a-z0-9]*$")
    groupQuotaName: string;

    /**
     * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
     */
    @path
    @key
    @segment("resourceProviders")
    @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
    resourceProviderName: string;

    /**
     * The name of the Azure region.
     */
    @path
    @minLength(1)
    @segment("groupQuotaLimits")
    location: Azure.Core.azureLocation;
  }
>;

@armResourceOperations
interface GroupQuotaLimitLists {
  /**
   * Gets the GroupQuotaLimits for the specified resource provider and location for resource names passed in $filter=resourceName eq {SKU}.
   */
  list is GroupQuotaLimitListsOps.Read<GroupQuotaLimitList>;

  /**
   * Create the GroupQuota requests for a specific ResourceProvider/Location/Resource. The resourceName properties are specified in the request body. Only 1 resource quota can be requested. Please note that patch request creates a new groupQuota request.
   * Use the polling API - OperationsStatus URI specified in Azure-AsyncOperation header field, with retry-after duration in seconds to check the intermediate status. This API provides the finals status with the request details and status.
   */
  @patch(#{ implicitOptionality: false })
  update is GroupQuotaLimitListsOps.CustomPatchAsync<
    GroupQuotaLimitList,
    PatchModel = GroupQuotaLimitList,
    OptionalRequestBody = true,
    Response = ArmResponse<GroupQuotaLimitList> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GroupQuotaLimitList> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@minLength(GroupQuotaLimitList.name, 1);
@@doc(GroupQuotaLimitList.name, "The name of the Azure region.");
@@doc(GroupQuotaLimitList.properties, "");
@@doc(GroupQuotaLimitLists.update::parameters.properties,
  "The GroupQuotaRequest body details for specific resourceProvider/location/resources."
);
