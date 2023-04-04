import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/report.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;
using DeveloperServicesAuthorizedApi.Common;

namespace DeveloperServicesAuthorizedApi.Resources.Reports;

@doc("Reports query parameters.")
model QueryParameters {
  ...DefaultListQueryParameters;

  @doc("Aggregate by interval.")
  @query
  interval?: string;

  @doc("OData order by query option.")
  @query
  orderBy?: string;
}
interface Reports {
  @doc("List a collection of reports.")
  listReports is ResourceList<
    ReportsResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by time.")
  listReportsByTime is ResourceList<
    ReportsByTimeResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by region.")
  listReportsByRegion is ResourceList<
    ReportsByRegionResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by developer.")
  listReportsByDeveloper is ResourceList<
    ReportsByDeveloperResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by product.")
  listReportsByProduct is ResourceList<
    ReportsByProductResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by endpoint.")
  listReportsByEndpoint is ResourceList<
    ReportsByEndpointResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by operation.")
  listReportsByOperation is ResourceList<
    ReportsByOperationResource,
    QueryParametersTrait<QueryParameters>
  >;

  @doc("List a collection of reports by subscription.")
  listReportsBySubscription is ResourceList<
    ReportsBySubscriptionResource,
    QueryParametersTrait<QueryParameters>
  >;
}

@doc("Reports resource model.")
@resource("reports/none")
@parentResource(UserResource)
model ReportsResource extends Report {
  @doc("Configuration content identifier.")
  @key("default")
  @visibility("query")
  default: "";
}

@doc("Reports by time resource model.")
@resource("reports/byTime")
model ReportsByTimeResource is ReportsResource;

@doc("Reports by region resource model.")
@resource("reports/byRegion")
model ReportsByRegionResource is ReportsResource;

@doc("Reports by developer resource model.")
@resource("reports/byDeveloper")
model ReportsByDeveloperResource is ReportsResource;

@doc("Reports by product resource model.")
@resource("reports/byProduct")
model ReportsByProductResource is ReportsResource;

@doc("Reports by endpoint resource model.")
@resource("reports/byEndpoint")
model ReportsByEndpointResource is ReportsResource;

@doc("Reports by operation resource model.")
@resource("reports/byOperation")
model ReportsByOperationResource is ReportsResource;

@doc("Reports by subscription resource model.")
@resource("reports/bySubscription")
model ReportsBySubscriptionResource is ReportsResource;
