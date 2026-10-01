import { inspect } from "node:util";
import { LogLevel, logMessage } from "./log.ts";
import { type ExecutionReportPackage } from "./types.ts";

export type PyPIPackageValidationStatus = "registered" | "notRegistered" | "checkFailed";

export interface PyPIPackageValidationResult {
  status: PyPIPackageValidationStatus;
  packageName: string;
  packageUrl: string;
  reason?: string;
}

export interface PythonPackagesPyPIValidationResult {
  succeeded: boolean;
  errors: string[];
}

type Fetch = typeof fetch;
type Sleep = (ms: number) => Promise<void>;

const PYPI_PACKAGE_BASE_URL = "https://pypi.org/pypi";
const MAX_RETRIES = 3;
const RETRY_DELAY_MS = 1000;
const RETRYABLE_HTTP_STATUS_CODES = new Set([429, 500, 502, 503, 504]);
const defaultSleep: Sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

function getPackageUrl(packageName: string): string {
  return `${PYPI_PACKAGE_BASE_URL}/${encodeURIComponent(packageName)}/json`;
}

export async function checkPackageOnPyPI(
  packageName: string,
  fetchImpl: Fetch = fetch,
  sleep: Sleep = defaultSleep,
): Promise<PyPIPackageValidationResult> {
  const packageUrl = getPackageUrl(packageName);
  let lastFailureReason = "";

  for (let attempt = 0; attempt <= MAX_RETRIES; attempt++) {
    if (attempt > 0) {
      await sleep(RETRY_DELAY_MS);
    }
    try {
      const response = await fetchImpl(packageUrl);
      if (response.status === 200) {
        return { status: "registered", packageName, packageUrl };
      }
      if (response.status === 404) {
        return { status: "notRegistered", packageName, packageUrl };
      }
      if (!RETRYABLE_HTTP_STATUS_CODES.has(response.status)) {
        return {
          status: "checkFailed",
          packageName,
          packageUrl,
          reason: `PyPI returned HTTP ${response.status}`,
        };
      }
      lastFailureReason = `PyPI returned HTTP ${response.status}`;
    } catch (error) {
      lastFailureReason = inspect(error);
    }
  }

  return {
    status: "checkFailed",
    packageName,
    packageUrl,
    reason: lastFailureReason,
  };
}

export async function validatePythonPackagesOnPyPI(
  packages: ExecutionReportPackage[],
  sleep: Sleep = defaultSleep,
): Promise<PythonPackagesPyPIValidationResult> {
  const errors: string[] = [];

  if (packages.length === 0) {
    return { succeeded: true, errors };
  }

  for (const pkg of packages) {
    if (!pkg.packageName) {
      continue;
    }

    logMessage(
      `Checking whether Python package '${pkg.packageName}' is registered on PyPI.org...`,
      LogLevel.Info,
    );
    const result = await checkPackageOnPyPI(pkg.packageName, fetch, sleep);

    if (result.status === "registered") {
      logMessage(
        `Python package '${pkg.packageName}' is already registered on PyPI.org.`,
        LogLevel.Info,
      );
      continue;
    }

    if (result.status === "notRegistered") {
      errors.push(
        `Python package '${pkg.packageName}' is not registered on PyPI.org yet. To reserve this package name, complete these actions: 1. Request namespace review at aka.ms/azsdk/ns-review; 2. After namespace approval, trigger the package-name reservation pipeline: aka.ms/python-reserve-pkg`,
      );
    } else {
      errors.push(
        `Unable to verify whether Python package '${pkg.packageName}' is registered on PyPI.org. Treating this as a validation failure. Details: ${result.reason ?? "Unknown error"}`,
      );
    }
  }

  return { succeeded: errors.length === 0, errors };
}
