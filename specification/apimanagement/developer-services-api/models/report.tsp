namespace DeveloperServicesApi.Models;

@doc("Report definition.")
model Report {
  @doc("Depending on report endpoint specifies product, API, operation or developer name.")
  name: string;

  @doc("Start of aggregation period.")
  timestamp: zonedDateTime;

  @doc("Aggregation period.")
  interval: string;

  @doc("Country to which this record data is related.")
  country: string;

  @doc("Country region to which this record data is related.")
  region: string;

  @doc("Zip code to which this record data is related.")
  zip: string;

  @doc("User identifier.")
  userId: string;

  @doc("Product identifier.")
  productId: string;

  @doc("API identifier.")
  apiId: string;

  @doc("Operation identifier.")
  operationId: string;

  @doc("API region identifier.")
  apiRegion: string;

  @doc("Subscription identifier.")
  subscriptionId: string;

  @doc("Number of successful calls.")
  callCountSuccess: int32;

  @doc("Number of calls blocked due to invalid credentials.")
  callCountBlocked: int32;

  @doc("number of calls failed due to proxy or backend errors.")
  callCountFailed: int32;

  @doc("Number of other calls.")
  callCountOther: int32;

  @doc("Total number of calls.")
  callCountTotal: int32;

  @doc("Bandwidth consumed.")
  bandwidth: int64;

  @doc("Number of times when content was served from cache policy.")
  cacheHitCount: int32;

  @doc("Number of times content was fetched from backend.")
  cacheMissCount: int32;

  @doc("Average time it took to process request.")
  apiTimeAvg: float64;

  @doc("Minimum time it took to process request.")
  apiTimeMin: float64;

  @doc("Maximum time it took to process request.")
  apiTimeMax: float64;

  @doc("Average time it took to process request in backend.")
  serviceTimeAvg: float64;

  @doc("Minimum time it took to process request in backend.")
  serviceTimeMin: float64;

  @doc("Maximum time it took to process request in backend.")
  serviceTimeMax: float64;
}
