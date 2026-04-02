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

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApiCollectionsOperationGroup {
  /**
   * Gets a list of API collections within a resource group that have been onboarded to Microsoft Defender for APIs.
   */
  @tag("D4APICollectionList")
  @summary("Gets a list of API collections within a resource group")
  @autoRoute
  @get
  @list
  @action("apiCollections")
  listByResourceGroup is ArmProviderActionSync<
    Response = ApiCollectionList,
    Scope = Azure.ResourceManager.Extension.ResourceGroup
  >;
}
