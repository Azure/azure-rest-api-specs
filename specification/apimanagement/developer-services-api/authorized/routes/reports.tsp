import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/report.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Reports;

@route("/users/{userId}/reports/{reportType}")
@doc("List a collection of tags.")
@get
op ListReports(
  ...UserParams,
  ...ListParams,

  @doc("Type of report.")
  @path
  reportType: string,

  @doc("Aggregate by interval.")
  @query
  interval?: string,

  @doc("OData order by query option.")
  @query
  orderBy?: string
): ApiResponse<Page<Report>>;
