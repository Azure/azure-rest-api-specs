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

namespace Microsoft.Chaos;
/**
 * Model that represents a Target resource.
 */
model Target is ProxyResource<Record<unknown>> {
  /**
   * String that represents a Target resource name.
   */
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;
}

@armResourceOperations
interface Targets {
  /**
   * Get a Target resource that extends a tracked regional resource.
   */
  @armResourceRead(Target)
  @get
  get(
    ...SubscriptionBaseParameters;
    ...ResourceGroupParameter;

    /**
     * String that represents a resource provider namespace.
     */
    @segment("providers")
    @pattern("^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$")
    @path
    parentProviderNamespace: string;

    /**
     * String that represents a resource type.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceType: string;

    /**
     * String that represents a resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceName: string;

    ...DefaultProviderNamespace;

    /**
     * String that represents a Target resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("targets")
    targetName: string;
  ): ArmResponse<Target> | ErrorResponse;

  /**
   * Create or update a Target resource that extends a tracked regional resource.
   */
  @armResourceCreateOrUpdate(Target)
  @put
  createOrUpdate(
    ...SubscriptionBaseParameters;
    ...ResourceGroupParameter;

    /**
     * String that represents a resource provider namespace.
     */
    @segment("providers")
    @pattern("^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$")
    @path
    parentProviderNamespace: string;

    /**
     * String that represents a resource type.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceType: string;

    /**
     * String that represents a resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceName: string;

    ...DefaultProviderNamespace;

    /**
     * String that represents a Target resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("targets")
    targetName: string;

    /**
     * Target resource to be created or updated.
     */
    @body
    target: Target;
  ):ArmResponse<Target> | ErrorResponse;

  /**
   * Delete a Target resource that extends a tracked regional resource.
   */
  @armResourceDelete(Target)
  @delete
  delete(
    ...SubscriptionBaseParameters;
    ...ResourceGroupParameter;

    /**
     * String that represents a resource provider namespace.
     */
    @segment("providers")
    @pattern("^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$")
    @path
    parentProviderNamespace: string;

    /**
     * String that represents a resource type.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceType: string;

    /**
     * String that represents a resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceName: string;

    ...DefaultProviderNamespace;

    /**
     * String that represents a Target resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("targets")
    targetName: string;
  ): ArmDeletedResponse | ArmNoContentResponse |ErrorResponse;

  /**
   * Get a list of Target resources that extend a tracked regional resource.
   */
  @armResourceList(Target)
  @get
  @segment("targets")
  list(
    ...SubscriptionBaseParameters;
    ...ResourceGroupParameter;

    /**
     * String that represents a resource provider namespace.
     */
    @segment("providers")
    @pattern("^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$")
    @path
    parentProviderNamespace: string;

    /**
     * String that represents a resource type.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceType: string;

    /**
     * String that represents a resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    parentResourceName: string;

    ...DefaultProviderNamespace;

    /**
     * String that sets the continuation token.
     */
    @query("continuationToken")
    continuationToken?: string;
  ): ArmResponse<Azure.Core.Page<Target>> | ErrorResponse;
}
