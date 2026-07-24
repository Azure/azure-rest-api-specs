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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "The data scanner is an extension resource addressable at multiple scopes (a subscription or a resource group) through a single {scopeId} path parameter, matching the sibling PricingsAPI modeling. The extension base parameter and the scopeId parameter are both required to express this."
@extensionResource
model DataScanner
  is Azure.ResourceManager.ExtensionResource<DataScannerProperties> {
  ...ResourceNameParameter<
    Resource = DataScanner,
    KeyName = "scannerName",
    SegmentName = "dataScanners",
    NamePattern = "^[a-zA-Z0-9-]{1,260}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

alias DataScannersOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The scope of the data scanner. Valid scopes are a subscription (format: 'subscriptions/{subscriptionId}') or a resource group (format: 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}').
     */
    @path(#{ allowReserved: true })
    @key
    scopeId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The name of the data scanner. */
    @path
    @segment("dataScanners")
    @key
    @pattern("^[a-zA-Z0-9-]{1,260}$")
    scannerName: string;
  }
>;

@armResourceOperations
interface DataScanners {
  /**
   * Gets a data scanner resource for the specified scope.
   */
  get is DataScannersOps.Read<DataScanner, ErrorType = CloudError>;

  /**
   * Creates or updates a data scanner resource for the specified scope.
   */
  createOrUpdate is DataScannersOps.CreateOrUpdateSync<
    DataScanner,
    ErrorType = CloudError
  >;

  /**
   * Deletes a data scanner resource for the specified scope.
   */
  delete is DataScannersOps.DeleteSync<DataScanner, ErrorType = CloudError>;

  /**
   * Lists all data scanner resources for the specified scope.
   */
  list is DataScannersOps.List<
    DataScanner,
    Response = ArmResponse<DataScannerList>,
    ErrorType = CloudError
  >;
}

@@doc(DataScanner.name, "The name of the data scanner.");
@@doc(DataScanner.properties, "Data scanner resource properties.");
@@doc(
  DataScanners.createOrUpdate::parameters.resource,
  "The data scanner resource."
);
