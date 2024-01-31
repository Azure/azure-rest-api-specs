import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
/**
 * The springbootsites envelope resource definition.
 */
model SpringbootsitesModel is TrackedResource<SpringbootsitesProperties> {
  /**
   * The springbootsites name.
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-z][a-z0-9-]*$")
  @path
  @key("siteName")
  @segment("springbootsites")
  name: string;

  /**
   * The extended location definition.
   */
  extendedLocation?: SpringbootsitesModelExtendedLocation;
}

@armResourceOperations
interface SpringbootsitesModels {
  /**
   * Get a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @armResourceRead(SpringbootsitesModel)
  @operationId("springbootsites_Get")
  @get
  get(
    ...ResourceGroupBaseParameters,
    ...DefaultProviderNamespace,
    
    /**
     * The springbootsites name.
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[a-z][a-z0-9-]*$")
    @path
    @key("springbootsitesName")
    @segment("springbootsites")
    springbootsitesName: string;
  ): ArmResponse<SpringbootsitesModel> | ErrorResponse;

  /**
   * Create a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @armResourceCreateOrUpdate(SpringbootsitesModel)
  @operationId("springbootsites_CreateOrUpdate")
  @put
  createOrUpdate(
    ...ResourceGroupBaseParameters,
    ...DefaultProviderNamespace,

    /**
     * The springbootsites name.
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[a-z][a-z0-9-]*$")
    @path
    @key("springbootsitesName")
    @segment("springbootsites")
    springbootsitesName: string;

    /**
     * Create a springbootsites payload.
     */
    @body
    springbootsites: SpringbootsitesModel;
  ): 
    | ArmResourceUpdatedResponse<SpringbootsitesModel> 
    | ArmResourceCreatedSyncResponse<SpringbootsitesModel> 
    | ErrorResponse;

  /**
   * Update a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @armResourceUpdate(SpringbootsitesPatch)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @parameterVisibility("read")
  @operationId("springbootsites_Update")
  @patch
  update(
    ...ResourceGroupBaseParameters,
    ...DefaultProviderNamespace,

    /**
     * The springbootsites name.
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[a-z][a-z0-9-]*$")
    @path
    @key("springbootsitesName")
    @segment("springbootsites")
    springbootsitesName: string;

    /**
     * Update a springbootsites payload.
     */
    @body
    springbootsites: SpringbootsitesPatch;
  ): 
    | ArmResourceUpdatedResponse<SpringbootsitesModel>
    | ArmAcceptedLroResponse<"Updates the springbootsites resource.">
    | ErrorResponse;

    /**
   * Delete a springbootsites resource.
   */
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
    @armResourceDelete(SpringbootsitesModel)
    @extension("x-ms-long-running-operation", true)
    @extension(
      "x-ms-long-running-operation-options",
      {
        `final-state-via`: "location",
      }
    )
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
    @operationId("springbootsites_Delete")
    @delete
    delete(
      ...ResourceGroupBaseParameters,
      ...DefaultProviderNamespace,
  
      /**
       * The springbootsites name.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-z][a-z0-9-]*$")
      @path
      @key("springbootsitesName")
      @segment("springbootsites")
      springbootsitesName: string;
    ): 
      | ArmAcceptedLroResponse<"Deletes the springbootsites resource.">
      | ArmNoContentResponse<"Deletes the springbootsites resource.">
      | ErrorResponse;

  /**
   * List springbootsites resource by resourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootsitesModel>;

  /**
   * List springbootsites resource by subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootsitesModel>;

  /**
   * Trigger refresh springbootsites action
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @armResourceAction(SpringbootsitesModel)
  @operationId("springbootsites_TriggerRefreshSite")
  @action("refreshSite")
  @post
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  triggerRefreshSite(
    ...ResourceGroupBaseParameters,
    ...DefaultProviderNamespace,

    /**
     * The springbootsites name.
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[a-z][a-z0-9-]*$")
    @path
    @key("springbootsitesName")
    @segment("springbootsites")
    springbootsitesName: string;
  ): ArmAcceptedLroResponse | ErrorResponse;
}
