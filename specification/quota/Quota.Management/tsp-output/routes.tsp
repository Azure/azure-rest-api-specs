import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureQuotaExtensionAPI;

interface UsagesOperations {
  @doc("Get the current usage of a resource.")
  @route("/{scope}/providers/Microsoft.Quota/usages/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Resource name for a given resource provider. For example:
- SKU name for
Microsoft.Compute
- SKU or TotalLowPriorityCores for
Microsoft.MachineLearningServices
 For Microsoft.Network PublicIPAddresses.
""")
      @path
      resourceName: string;

      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;
    },
    CurrentUsagesBase
  >;

  @doc("Get a list of current usage for all resources for the scope specified.")
  @route("/{scope}/providers/Microsoft.Quota/usages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;
    },
    UsagesLimits
  >;
}

interface QuotaOperations {
  @doc("""
Get the quota limit of a resource. The response can be used to determine the
remaining quota to calculate a new quota limit that can be submitted with a PUT
request.
""")
  @route("/{scope}/providers/Microsoft.Quota/quotas/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Resource name for a given resource provider. For example:
- SKU name for
Microsoft.Compute
- SKU or TotalLowPriorityCores for
Microsoft.MachineLearningServices
 For Microsoft.Network PublicIPAddresses.
""")
      @path
      resourceName: string;

      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;
    },
    CurrentQuotaLimitBase
  >;

  @doc("""
Create or update the quota limit for the specified resource with the requested
value. To update the quota, follow these steps:
1. Use the GET operation for
quotas and usages to determine how much quota remains for the specific resource
and to calculate the new quota limit. These steps are detailed in [this
example](https://techcommunity.microsoft.com/t5/azure-governance-and-management/using-the-new-quota-rest-api/ba-p/2183670).
2.
Use this PUT operation to update the quota limit. Please check the URI in
location header for the detailed status of the request.
""")
  @route("/{scope}/providers/Microsoft.Quota/quotas/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Resource name for a given resource provider. For example:
- SKU name for
Microsoft.Compute
- SKU or TotalLowPriorityCores for
Microsoft.MachineLearningServices
 For Microsoft.Network PublicIPAddresses.
""")
      @path
      resourceName: string;

      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;

      @doc("Quota request payload.")
      @body
      createQuotaRequest: CurrentQuotaLimitBase;
    },
    CurrentQuotaLimitBase | void
  >;

  @doc("""
Update the quota limit for a specific resource to the specified value:
1. Use
the Usages-GET and Quota-GET operations to determine the remaining quota for
the specific resource and to calculate the new quota limit. These steps are
detailed in [this
example](https://techcommunity.microsoft.com/t5/azure-governance-and-management/using-the-new-quota-rest-api/ba-p/2183670).
2.
Use this PUT operation to update the quota limit. Please check the URI in
location header for the detailed status of the request.
""")
  @route("/{scope}/providers/Microsoft.Quota/quotas/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
Resource name for a given resource provider. For example:
- SKU name for
Microsoft.Compute
- SKU or TotalLowPriorityCores for
Microsoft.MachineLearningServices
 For Microsoft.Network PublicIPAddresses.
""")
      @path
      resourceName: string;

      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;

      @doc("Quota requests payload.")
      @body
      createQuotaRequest: CurrentQuotaLimitBase;
    },
    CurrentQuotaLimitBase | void
  >;

  @doc("""
Get a list of current quota limits of all resources for the specified scope.
The response from this GET operation can be leveraged to submit requests to
update a quota.
""")
  @route("/{scope}/providers/Microsoft.Quota/quotas")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;
    },
    QuotaLimits
  >;
}

interface QuotaRequestStatusOperations {
  @doc("""
Get the quota request details and status by quota request ID for the resources
of the resource provider at a specific location. The quota request ID **id** is
returned in the response of the PUT operation.
""")
  @route("/{scope}/providers/Microsoft.Quota/quotaRequests/{id}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Quota request ID.")
      @path
      id: string;

      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;
    },
    QuotaRequestDetails
  >;

  @doc("""
For the specified scope, get the current quota requests for a one year period
ending at the time is made. Use the **oData** filter to select quota requests.
""")
  @route("/{scope}/providers/Microsoft.Quota/quotaRequests")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The target Azure resource URI. For example,
`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`.
This is the target Azure resource URI for the List GET operation. If a
`{resourceName}` is added after `/quotas`, then it's the target Azure resource
URI in the GET operation for the specific resource.
""")
      @path
      scope: string;

      @doc("""
| Field                    | Supported operators 

|---------------------|------------------------

|requestSubmitTime | ge, le,
eq, gt, lt
 |provisioningState eq {QuotaRequestState}
 |resourceName eq
{resourceName}

""")
      @query
      $filter: string;

      @doc("Number of records to return.")
      @query
      $top: int32;

      @doc("""
The **Skiptoken** parameter is used only if a previous operation returned a
partial result. If a previous response contains a **nextLink** element, its
value includes a **skiptoken** parameter that specifies a starting point to use
for subsequent calls.
""")
      @query
      $skiptoken: string;
    },
    QuotaRequestDetailsList
  >;
}

interface QuotaOperationOperations {
  @summary("GET quota operations.")
  @doc("List all the operations supported by the Microsoft.Quota resource provider.")
  @route("/providers/Microsoft.Quota/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}
