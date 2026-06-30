import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace DataScannersAPI;
/**
 * The data scanner resource used by Defender for Storage to scan data for malware and sensitive data discovery.
 */
model DataScanner
  is Azure.ResourceManager.ProxyResource<DataScannerProperties> {
  ...ResourceNameParameter<
    Resource = DataScanner,
    KeyName = "scannerName",
    SegmentName = "datascanners",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

alias DataScannerSubscriptionOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {
    /** The name of the data scanner. */
    @path
    @segment("datascanners")
    @key
    @pattern("^[a-zA-Z0-9-]*$")
    scannerName: string;
  },
  CloudError
>;

alias DataScannerResourceGroupOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {
    /** The name of the data scanner. */
    @path
    @segment("datascanners")
    @key
    @pattern("^[a-zA-Z0-9-]*$")
    scannerName: string;
  },
  CloudError
>;

@armResourceOperations(#{ omitTags: true })
interface DataScanners {
  /**
   * Gets a data scanner resource at subscription level.
   */
  @tag("DataScanners")
  get is DataScannerSubscriptionOps.Read<DataScanner>;

  /**
   * Creates or updates a data scanner resource at subscription level.
   */
  @tag("DataScanners")
  createOrUpdate is DataScannerSubscriptionOps.CreateOrUpdateSync<DataScanner>;

  /**
   * Deletes a data scanner resource at subscription level.
   */
  @tag("DataScanners")
  delete is DataScannerSubscriptionOps.DeleteSync<DataScanner>;

  /**
   * Lists all data scanner resources under the given subscription.
   */
  @tag("DataScanners")
  list is DataScannerSubscriptionOps.List<
    DataScanner,
    Response = ArmResponse<DataScannerList>
  >;

  /**
   * Gets a data scanner resource at resource group level.
   */
  @tag("DataScanners")
  getByResourceGroup is DataScannerResourceGroupOps.Read<DataScanner>;

  /**
   * Creates or updates a data scanner resource at resource group level.
   */
  @tag("DataScanners")
  createOrUpdateByResourceGroup is DataScannerResourceGroupOps.CreateOrUpdateSync<DataScanner>;

  /**
   * Deletes a data scanner resource at resource group level.
   */
  @tag("DataScanners")
  deleteByResourceGroup is DataScannerResourceGroupOps.DeleteSync<DataScanner>;
}

@@doc(DataScanner.name, "The name of the data scanner.");
@@doc(DataScanner.properties, "Data scanner resource properties.");
