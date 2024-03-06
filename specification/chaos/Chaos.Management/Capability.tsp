import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Target.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Capability resource.
 */
@parentResource(Target)
model Capability is ProxyResource<CapabilityProperties> {
  /**
   * String that represents a Capability resource name.
   */
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityName")
  @segment("capabilities")
  name: string;
}

@armResourceOperations
interface Capabilities {
  /**
   * Get a Capability resource that extends a Target resource.
   */
  @armResourceRead(Capability)
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

    /**
     * String that represents a Capability resource name.
     */
    @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
    @path
    @segment("capabilities")
    capabilityName: string;
  ):ArmResponse<Capability> | ErrorResponse;

  /**
   * Create or update a Capability resource that extends a Target resource.
   */
  @armResourceCreateOrUpdate(Capability)
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
     * String that represents a Capability resource name.
     */
    @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
    @path
    @segment("capabilities")
    capabilityName: string;

    /**
     * Capability resource to be created or updated.
     */
    @body
    capability: Capability;
  ):ArmResponse<Capability> | ErrorResponse;

  /**
   * Delete a Capability that extends a Target resource.
   */
  @armResourceDelete(Capability)
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

    /**
     * String that represents a Capability resource name.
     */
    @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
    @path
    @segment("capabilities")
    capabilityName: string;
  ):ArmDeletedResponse | ArmNoContentResponse | ErrorResponse;

  /**
   * Get a list of Capability resources that extend a Target resource..
   */
  @armResourceList(Capability)
  @get
  @segment("capabilities")
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
     * String that represents a Target resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("targets")
    targetName: string;

    /**
     * String that sets the continuation token.
     */
    @query("continuationToken")
    continuationToken?: string;
  ): ArmResponse<Azure.Core.Page<Capability>> | ErrorResponse;
}
