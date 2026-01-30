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
model ProductPackageModel
  is Azure.ResourceManager.ProxyResource<ProductPackageProperties> {
  ...ResourceNameParameter<
    Resource = ProductPackageModel,
    KeyName = "packageId",
    SegmentName = "contentProductPackages",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface ProductPackageModels {
  /**
   * Gets a package by its identifier from the catalog.
   */
  get is Extension.Read<
    OperationalInsights,
    ProductPackageModel,
    Error = CloudError
  >;

  /**
   * Gets all packages from the catalog.
   * Expandable properties:
   * - properties/installed
   * - properties/packagedContent
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    ProductPackageModel,
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
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Searches for a substring in the response. Optional.
       */
      @query("$search")
      $search?: string;
    },
    Response = ArmResponse<ProductPackageList>,
    Error = CloudError
  >;
}

@@doc(ProductPackageModel.name, "package Id");
@@doc(ProductPackageModel.properties, "package properties");
