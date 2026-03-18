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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PermissionsOperationGroup {
  /**
   * Gets all permissions the caller has for a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Permissions_ListForResourceGroup")
  @autoRoute
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
  @autoRoute
  @get
  @action("permissions")
  listForResource is ArmProviderActionSync<
    Response = PermissionGetResult,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The namespace of the resource provider.
       */
      @path
      @segment("providers")
      resourceProviderNamespace: string;

      /**
       * The parent resource identity.
       */
      @path
      @segment("{resourceProviderNamespace}")
      parentResourcePath: string;

      /**
       * The resource type of the resource.
       */
      @path
      @segment("{parentResourcePath}")
      resourceType: string;

      /**
       * The name of the resource to get the permissions for.
       */
      @pattern(".+")
      @path
      @segment("{resourceType}")
      resourceName: string;
    }
  >;
}
