import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Management;
/**
 * The management group details.
 */
model ManagementGroup
  is Azure.ResourceManager.ProxyResource<ManagementGroupProperties> {
  ...ResourceNameParameter<
    Resource = ManagementGroup,
    KeyName = "groupId",
    SegmentName = "managementGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagementGroups {
  /**
   * Get the details of the management group.
   *
   */
  get is Extension.Read<
    Extension.Tenant,
    ManagementGroup,
    Parameters = {
      /**
       * The $expand=children query string parameter allows clients to request inclusion of children in the response payload.  $expand=path includes the path from the root group to the current group.  $expand=ancestors includes the ancestor Ids of the current group.
       */
      @query("$expand")
      $expand?: ManagementGroupExpandType;

      /**
       * The $recurse=true query string parameter allows clients to request inclusion of entire hierarchy in the response payload. Note that  $expand=children must be passed up if $recurse is set to true.
       */
      @query("$recurse")
      $recurse?: boolean;

      /**
       * A filter which allows the exclusion of subscriptions from results (i.e. '$filter=children.childType ne Subscription')
       */
      @query("$filter")
      $filter?: string;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Create or update a management group.
   * If a management group is already created and a subsequent create request is issued with different properties, the management group properties will be updated.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrReplaceAsync<
    Extension.Tenant,
    ManagementGroup,
    Request = CreateManagementGroupRequest,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    },
    Response = ArmResourceUpdatedResponse<ManagementGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ManagementGroup>> & {
      @bodyRoot
      _: AzureAsyncOperationResults;
    })
  >;

  /**
   * Update a management group.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.Tenant,
    ManagementGroup,
    PatchModel = PatchManagementGroupRequest,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Delete management group.
   * If a management group contains child resources, the request will fail.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is Extension.DeleteWithoutOkAsync<
    Extension.Tenant,
    ManagementGroup,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    },
    Response = (ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureAsyncOperationResults;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List all entities that descend from a management group.
   *
   */
  @list
  @get
  @action("descendants")
  getDescendants is Extension.ActionSync<
    Extension.Tenant,
    ManagementGroup,
    void,
    ArmResponse<DescendantListResult>,
    Parameters = {
      /**
       * Page continuation token is only used if a previous operation returned a partial result.
       * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
       *
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * Number of elements to return when retrieving results. Passing this in will override $skipToken.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets all the hierarchy settings defined at the Management Group level. Settings can only be set on the root Management Group of the hierarchy.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("settings")
  list is Extension.ActionSync<
    Extension.Tenant,
    ManagementGroup,
    void,
    ArmResponse<HierarchySettingsList>
  >;
}

@@doc(ManagementGroup.name, "Management Group ID.");
@@doc(ManagementGroup.properties,
  "The generic properties of a management group."
);
@@doc(ManagementGroups.createOrUpdate::parameters.resource,
  "Management group creation parameters."
);
@@doc(ManagementGroups.update::parameters.properties,
  "Management group patch parameters."
);
