import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(Microsoft.AlertsManagement,
  "PreviewAlertRuleMgmtClient",
  "python"
);
namespace AlertSeverityCustomization {
  /**
   * Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.
   */
  union AlertSeverity {
    float64,

    /**
     * 0
     */
    `0`: 0,

    /**
     * 1
     */
    `1`: 1,

    /**
     * 2
     */
    `2`: 2,

    /**
     * 3
     */
    `3`: 3,

    /**
     * 4
     */
    `4`: 4,
  }
}
@@clientName(AlertSeverityCustomization.AlertSeverity.`0`, "ZERO", "python");
@@clientName(AlertSeverityCustomization.AlertSeverity.`1`, "ONE", "python");
@@clientName(AlertSeverityCustomization.AlertSeverity.`2`, "TWO", "python");
@@clientName(AlertSeverityCustomization.AlertSeverity.`3`, "THREE", "python");
@@clientName(AlertSeverityCustomization.AlertSeverity.`4`, "FOUR", "python");
@@alternateType(AlertSeverity,
  AlertSeverityCustomization.AlertSeverity,
  "python"
);

