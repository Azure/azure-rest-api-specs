import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;

/**
 * Resource information.
 */
model GenericResource is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = ResourceGroup,
    KeyName = "resourceName",
    SegmentName = "resourceNames",
    NamePattern = ""
  >;

  /**
   * The plan of the resource.
   */
  plan?: Plan;

  /**
   * The kind of the resource.
   */
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * ID of the resource that manages this resource.
   */
  managedBy?: string;

  /**
   * The SKU of the resource.
   */
  sku?: Sku;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource extended location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

alias genericOps = Azure.ResourceManager.Legacy.RoutedOperations<
  ApiVersionParameter,
  {
    @path(#{ allowReserved: true }) @key resourceId: string;
  },
  CloudError
>;

@armResourceOperations
interface Resources {
  /**
   * Checks by ID whether a resource exists. This API currently works only for a limited set of Resource providers. In the event that a Resource provider does not implement this API, ARM will respond with a 405. The alternative then is to use the GET API to check for the existence of the resource.
   */
  checkExistenceById is genericOps.CheckExistence<GenericResource>;

  /**
   * Gets a resource by ID.
   */
  getById is genericOps.Read<GenericResource>;

  /**
   * Create a resource by ID.
   */
  createOrUpdateById is genericOps.CreateOrUpdateAsync<
    GenericResource,
    Response = ArmResourceUpdatedResponse<GenericResource> | ArmResourceCreatedResponse<
      GenericResource,
      ArmLroLocationHeader<FinalResult = GenericResource> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedResponse
  >;

  /**
   * Update a resource by ID.
   */
  updateById is genericOps.CustomPatchAsync<GenericResource, GenericResource>;

  /**
   * Deletes a resource by ID.
   */
  deleteById is genericOps.DeleteWithoutOkAsync<
    GenericResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

alias specificResourcesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /**
     * The name of the resource group containing the resource to get. The name is case insensitive.
     */
    @path
    @pattern("^[-\\w\\._\\(\\)]+$")
    @minLength(1)
    @maxLength(90)
    @segment("resourcegroups")
    resourceGroupName: string;

    /** The resource provider of the resource to check. */
    @path
    @segment("providers")
    resourceProviderNamespace: string;

    /** The parent resource identity. */
    @path(#{ allowReserved: true })
    parentResourcePath: string;

    /** The resource type. */
    @path(#{ allowReserved: true })
    resourceType: string;
  },
  {
    /** The name of the resource to check whether it exists. */
    @path
    @key
    resourceName: string;
  },
  CloudError
>;

@armResourceOperations(#{ omitTags: true })
interface SpecificResources {
  /** Checks whether a resource exists. */
  @tag("Resources")
  checkExistence is specificResourcesOps.CheckExistence<GenericResource>;

  /**
   * Gets a resource.
   */
  @tag("Resources")
  get is specificResourcesOps.Read<GenericResource>;

  /**
   * Creates a resource.
   */
  @tag("Resources")
  createOrUpdate is specificResourcesOps.CreateOrUpdateAsync<
    GenericResource,
    Response = ArmResourceUpdatedResponse<GenericResource> | ArmResourceCreatedResponse<
      GenericResource,
      ArmLroLocationHeader<FinalResult = GenericResource> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedResponse
  >;

  /**
   * Updates a resource.
   */
  @tag("Resources")
  update is specificResourcesOps.CustomPatchAsync<
    GenericResource,
    GenericResource
  >;

  /**
   * Deletes a resource.
   */
  @tag("Resources")
  delete is specificResourcesOps.DeleteWithoutOkAsync<
    GenericResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}
