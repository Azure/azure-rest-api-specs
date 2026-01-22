import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a Package in Azure Security Insights.
 */
model PackageModel is Azure.ResourceManager.ProxyResource<PackageProperties> {
  ...ResourceNameParameter<
    Resource = PackageModel,
    KeyName = "packageId",
    SegmentName = "contentPackages",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface PackageModels {
  /**
   * Gets an installed packages by its id.
   */
  get is Extension.Read<OperationalInsights, PackageModel, Error = CloudError>;

  /**
   * Install a package to the workspace.
   */
  install is Extension.CreateOrReplaceSync<
    OperationalInsights,
    PackageModel,
    Error = CloudError
  >;

  /**
   * Uninstall a package from the workspace.
   */
  uninstall is Extension.DeleteSync<
    OperationalInsights,
    PackageModel,
    Error = CloudError
  >;

  /**
   * Gets all installed packages.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    PackageModel,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Searches for a substring in the response. Optional.
       */
      @query("$search")
      $search?: string;

      /**
       * Instructs the server to return only object count without actual body. Optional.
       */
      @query("$count")
      $count?: boolean;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Used to skip n elements in the OData query (offset). Returns a nextLink to the next page of results if there are any left.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<PackageList>,
    Error = CloudError
  >;
}

@@doc(PackageModel.name, "package Id");
@@doc(PackageModel.properties, "package properties");
@@doc(PackageModels.install::parameters.resource,
  "Package installation properties"
);
