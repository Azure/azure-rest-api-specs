import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./univariate/routes.tsp";
import "./multivariate/routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(APIVersion)
@service({
  title: "Anomaly Detector",
})
@useAuth(AnomalyDetectorApiKeyAuth)
@server(
  "{Endpoint}/anomalydetector/{ApiVersion}",
  "The Anomaly Detector API detects anomalies automatically in time series data. It supports two kinds of mode, one is for stateless using, another is for stateful using. In stateless mode, there are three functionalities. Entire Detect is for detecting the whole series with model trained by the time series, Last Detect is detecting last point with model trained by points before. ChangePoint Detect is for detecting trend changes in time series. In stateful mode, user can store time series, the stored time series will be used for detection anomalies. Under this mode, user can still use the above three functionalities by only giving a time range without preparing time series in client side. Besides the above three functionalities, stateful model also provide group based detection and labeling service. By leveraging labeling service user can provide labels for each detection result, these labels will be used for retuning or regenerating detection models. Inconsistency detection is a kind of group based detection, this detection will find inconsistency ones in a set of time series. By using anomaly detector service, business customers can discover incidents and establish a logic flow for root cause analysis.",
  {
    @doc("""
Supported Azure Cognitive Services endpoints (protocol and host name, such as
https://westus2.api.cognitive.microsoft.com).
""")
    Endpoint: string,

    @doc("Api Version")
    @path
    ApiVersion: APIVersion,
  }
)
@doc("""
The Anomaly Detector API detects anomalies automatically in time series data.
It supports both a stateless detection mode and a
stateful detection mode. In stateless mode, there are three functionalities. Entire
Detect is for detecting the whole series, with the model trained by the time series.
Last Detect is for detecting the last point, with the model trained by points before.
ChangePoint Detect is for detecting trend changes in the time series. In stateful
mode, the user can store time series. The stored time series will be used for
detection anomalies. In this mode, the user can still use the preceding three
functionalities by only giving a time range without preparing time series on the
client side. Besides the preceding three functionalities, the stateful model
provides group-based detection and labeling services. By using the labeling
service, the user can provide labels for each detection result. These labels will be
used for retuning or regenerating detection models. Inconsistency detection is
a kind of group-based detection that finds inconsistencies in
a set of time series. By using the anomaly detector service, business customers can
discover incidents and establish a logic flow for root cause analysis.
""")
namespace AnomalyDetector;

@doc("The secret key for your Azure Cognitive Services subscription.")
model AnomalyDetectorApiKeyAuth
  is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum APIVersion {
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v1_1: "v1.1",
}
