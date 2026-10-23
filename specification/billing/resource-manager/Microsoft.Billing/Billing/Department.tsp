import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * Optional grouping of enrollment accounts to segment costs into logical groupings and set budgets.
 */
@tenantResource
@parentResource(BillingAccount)
model Department is Azure.ResourceManager.ProxyResource<DepartmentProperties> {
  ...ResourceNameParameter<
    Resource = Department,
    KeyName = "departmentName",
    SegmentName = "departments",
    NamePattern = BillingProfileCustomerInvoiceSectionNamePattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface Departments {
  /**
   * Gets a department by ID. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("Department")
  get is ArmResourceRead<
    Department,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the departments that a user has access to. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("Department")
  listByBillingAccount is ArmResourceListByParent<
    Department,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      @query("skip")
      skip?: int64;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      @query("search")
      search?: string;
    },
    Response = ArmResponse<DepartmentListResult>
  >;

  /**
   * Lists the billing permissions the caller has for a department.
   */
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByDepartment is ArmResourceActionSync<
    Department,
    void,
    ArmResponse<BillingPermissionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Provides a list of check access response objects for a department.
   */
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByDepartment is ArmResourceActionSync<
    Department,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(Department.name, "The name of the department.");
@@doc(
  Department.properties,
  "Optional grouping of enrollment accounts to segment costs into logical groupings and set budgets."
);
@@doc(
  Departments.checkAccessByDepartment::parameters.body,
  "The request object against which access of the caller will be checked."
);
