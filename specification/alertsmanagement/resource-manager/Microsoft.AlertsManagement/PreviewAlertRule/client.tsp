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
    `ZERO`: 0,

    /**
     * 1
     */
    `ONE`: 1,

    /**
     * 2
     */
    `TWO`: 2,

    /**
     * 3
     */
    `THREE`: 3,

    /**
     * 4
     */
    `FOUR`: 4,
  }
}
@@alternateType(AlertSeverity,
  AlertSeverityCustomization.AlertSeverity,
  "python"
);
