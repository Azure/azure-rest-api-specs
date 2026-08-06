import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Microsoft.SerialConsole;
using Azure.ClientGenerator.Core;
using TypeSpec.Rest;

@@clientName(
  Microsoft.SerialConsole,
  "MicrosoftSerialConsoleClient",
  "javascript,python,go"
);

@@clientLocation(
  Microsoft.SerialConsole.SerialConsoleOperationGroup.disableConsole,
  Microsoft.SerialConsole,
  "go,javascript,python"
);
@@clientLocation(
  Microsoft.SerialConsole.SerialConsoleOperationGroup.enableConsole,
  Microsoft.SerialConsole,
  "go,javascript,python"
);

@@clientName(
  SerialConsoleOperationsValueItem,
  "SerialConsoleOperationInfo",
  "csharp"
);
@@clientName(
  SerialConsoleOperationsValueItemDisplay,
  "SerialConsoleOperationDisplay",
  "csharp"
);
@@access(Operations.list, Access.internal, "csharp");
@@access(SerialConsoleOperations, Access.internal, "csharp");
@@access(SerialConsoleOperationsValueItem, Access.internal, "csharp");
@@access(SerialConsoleOperationsValueItemDisplay, Access.internal, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Expose the parent-scope list operation as pageable in the C# SDK."
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(SerialPorts.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Expose the subscription-level list operation as pageable in the C# SDK."
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  SerialPorts.listBySubscriptions,
  "csharp"
);
@@access(SerialPortListResult, Access.internal, "csharp");
@@alternateType(DisableSerialConsoleResult, SerialConsoleStatus, "csharp");
@@clientName(
  DisableSerialConsoleResult,
  "DisableSerialConsoleResultInternal",
  "csharp"
);
@@access(DisableSerialConsoleResult, Access.internal, "csharp");
@@clientName(
  DisableSerialConsoleResultProperties,
  "DisableSerialConsoleResultPropertiesInternal",
  "csharp"
);
@@access(DisableSerialConsoleResultProperties, Access.internal, "csharp");
@@alternateType(EnableSerialConsoleResult, SerialConsoleStatus, "csharp");
@@clientName(
  EnableSerialConsoleResult,
  "EnableSerialConsoleResultInternal",
  "csharp"
);
@@access(EnableSerialConsoleResult, Access.internal, "csharp");
@@clientName(
  EnableSerialConsoleResultProperties,
  "EnableSerialConsoleResultPropertiesInternal",
  "csharp"
);
@@access(EnableSerialConsoleResultProperties, Access.internal, "csharp");
@@clientName(Operations.list, "GetSerialConsoleOperations", "csharp");
@@clientName(SerialPorts.listBySubscriptions, "GetSerialPorts", "csharp");
@@clientName(SerialConsoleStatusProperties.disabled, "IsDisabled", "csharp");
@@clientName(
  DisableSerialConsoleResultProperties.disabled,
  "IsDisabled",
  "csharp"
);
@@clientName(
  EnableSerialConsoleResultProperties.disabled,
  "IsDisabled",
  "csharp"
);
@@clientName(SerialPortConnectResult, "SerialPortConnectionInfo", "csharp");
@@alternateType(
  SerialConsoleOperationsValueItem.isDataAction,
  boolean,
  "csharp"
);

@@alternateType(getConsoleStatus::parameters.default, "default", "csharp");
@@alternateType(ConsoleServiceDefaultParameter.default, "default", "csharp");
