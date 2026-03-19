// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;

alias PermissionsForResourceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The ID of the target subscription.
     */
    @path
    @segment("subscriptions")
    @key
    subscriptionId: string;

    /**
     * The name of the resource group. The name is case insensitive.
     */
    @path
    @segment("resourceGroups")
    @key
    resourceGroupName: string;

    /**
     * The namespace of the resource provider.
     */
    @path(#{ allowReserved: true })
    @segment("providers")
    @key
    resourceProviderNamespace: string;

    /**
     * The parent resource identity.
     */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    parentResourcePath: string;

    /**
     * The resource type of the resource.
     */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    resourceType: string;

    /**
     * The name of the resource to get the permissions for.
     */
    @path
    @segment("")
    @key
    @pattern(".+")
    resourceName: string;

    /**
     * The provider namespace for Microsoft.Authorization.
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {}
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PermissionsOperationGroup {
  /**
   * Gets all permissions the caller has for a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Permissions_ListForResourceGroup")
  @autoRoute
  @tag("Permissions")
  @list
  @get
  @action("permissions")
  listForResourceGroup is ArmProviderActionSync<
    Response = PermissionGetResult,
    Scope = Extension.ResourceGroup
  >;
  /**
   * Gets all permissions the caller has for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Permissions_ListForResource")
  @tag("Permissions")
  @action("permissions")
  listForResource is PermissionsForResourceOps.List<
    Permission,
    Response = ArmResponse<PermissionGetResult>,
    OverrideResourceName = "permissions"
  >;
}
