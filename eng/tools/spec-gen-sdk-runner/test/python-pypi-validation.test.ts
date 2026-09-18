import { afterEach, describe, expect, test, vi } from "vitest";
import * as log from "../src/log.ts";
import { LogLevel } from "../src/log.ts";
import { checkPackageOnPyPI, validatePythonPackagesOnPyPI } from "../src/python-pypi-validation.ts";

function createFetchResponse(status: number): Response {
  return { status } as Response;
}

describe("checkPackageOnPyPI", () => {
  test("returns registered for HTTP 200", async () => {
    const fetchMock = vi.fn().mockResolvedValue(createFetchResponse(200));

    const result = await checkPackageOnPyPI("azure-mgmt-widget", fetchMock);

    expect(result.status).toBe("registered");
    expect(result.packageName).toBe("azure-mgmt-widget");
    expect(result.packageUrl).toBe("https://pypi.org/pypi/azure-mgmt-widget/json");
  });

  test("returns notRegistered for HTTP 404", async () => {
    const fetchMock = vi.fn().mockResolvedValue(createFetchResponse(404));

    const result = await checkPackageOnPyPI("azure-mgmt-widget", fetchMock);

    expect(result.status).toBe("notRegistered");
  });

  test("returns checkFailed immediately for non-retryable HTTP errors", async () => {
    const fetchMock = vi.fn().mockResolvedValue(createFetchResponse(400));
    const noSleep = vi.fn().mockResolvedValue(undefined);

    const result = await checkPackageOnPyPI("azure-mgmt-widget", fetchMock, noSleep);

    expect(result.status).toBe("checkFailed");
    expect(result.reason).toBe("PyPI returned HTTP 400");
    expect(fetchMock).toHaveBeenCalledTimes(1);
    expect(noSleep).not.toHaveBeenCalled();
  });

  test("retries on retryable HTTP status codes and returns checkFailed after max retries", async () => {
    const fetchMock = vi.fn().mockResolvedValue(createFetchResponse(503));
    const noSleep = vi.fn().mockResolvedValue(undefined);

    const result = await checkPackageOnPyPI("azure-mgmt-widget", fetchMock, noSleep);

    expect(result.status).toBe("checkFailed");
    expect(result.reason).toBe("PyPI returned HTTP 503");
    expect(fetchMock).toHaveBeenCalledTimes(4); // 1 initial + 3 retries
    expect(noSleep).toHaveBeenCalledTimes(3);
    expect(noSleep).toHaveBeenCalledWith(1000);
  });

  test("succeeds on retry after transient failure", async () => {
    const fetchMock = vi
      .fn()
      .mockResolvedValueOnce(createFetchResponse(503))
      .mockResolvedValueOnce(createFetchResponse(200));
    const noSleep = vi.fn().mockResolvedValue(undefined);

    const result = await checkPackageOnPyPI("azure-mgmt-widget", fetchMock, noSleep);

    expect(result.status).toBe("registered");
    expect(fetchMock).toHaveBeenCalledTimes(2);
    expect(noSleep).toHaveBeenCalledTimes(1);
  });

  test("retries on fetch errors and returns checkFailed after max retries", async () => {
    const fetchMock = vi.fn().mockRejectedValue(new Error("network unavailable"));
    const noSleep = vi.fn().mockResolvedValue(undefined);

    const result = await checkPackageOnPyPI("azure-mgmt-widget", fetchMock, noSleep);

    expect(result.status).toBe("checkFailed");
    expect(result.reason).toContain("Error: network unavailable");
    expect(fetchMock).toHaveBeenCalledTimes(4);
    expect(noSleep).toHaveBeenCalledTimes(3);
  });

  test("URL-encodes package names", async () => {
    const fetchMock = vi.fn().mockResolvedValue(createFetchResponse(200));

    await checkPackageOnPyPI("@azure/widget package", fetchMock);

    expect(fetchMock).toHaveBeenCalledWith(
      "https://pypi.org/pypi/%40azure%2Fwidget%20package/json",
    );
  });
});

describe("validatePythonPackagesOnPyPI", () => {
  afterEach(() => {
    vi.unstubAllGlobals();
    vi.restoreAllMocks();
  });

  test("succeeds with no packages", async () => {
    const fetchMock = vi.fn();
    vi.stubGlobal("fetch", fetchMock);

    const result = await validatePythonPackagesOnPyPI([]);

    expect(result).toEqual({ succeeded: true, errors: [] });
    expect(fetchMock).not.toHaveBeenCalled();
  });

  test("logs success when a Python package is registered", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue(createFetchResponse(200)));
    const logSpy = vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const result = await validatePythonPackagesOnPyPI([{ packageName: "azure-mgmt-widget" }]);

    expect(result).toEqual({ succeeded: true, errors: [] });
    expect(logSpy).toHaveBeenCalledWith(
      "Checking whether Python package 'azure-mgmt-widget' is registered on PyPI.org...",
      LogLevel.Info,
    );
    expect(logSpy).toHaveBeenCalledWith(
      "Python package 'azure-mgmt-widget' is already registered on PyPI.org.",
      LogLevel.Info,
    );
  });

  test("logs guidance when a Python package is not registered", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue(createFetchResponse(404)));
    const logSpy = vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const result = await validatePythonPackagesOnPyPI([{ packageName: "azure-mgmt-widget" }]);

    expect(result).toEqual({
      succeeded: false,
      errors: [
        "Python package 'azure-mgmt-widget' is not registered on PyPI.org yet. To reserve this package name, complete these actions: 1. Request namespace review at aka.ms/azsdk/ns-review; 2. After namespace approval, trigger the package-name reservation pipeline: aka.ms/python-reserve-pkg",
      ],
    });
    expect(logSpy).toHaveBeenCalledWith(
      "Checking whether Python package 'azure-mgmt-widget' is registered on PyPI.org...",
      LogLevel.Info,
    );
  });

  test("logs validation failure when the PyPI check fails", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue(createFetchResponse(503)));
    const logSpy = vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    const noSleep = vi.fn().mockResolvedValue(undefined);

    const result = await validatePythonPackagesOnPyPI(
      [{ packageName: "azure-mgmt-widget" }],
      noSleep,
    );

    expect(result).toEqual({
      succeeded: false,
      errors: [
        "Unable to verify whether Python package 'azure-mgmt-widget' is registered on PyPI.org. Treating this as a validation failure. Details: PyPI returned HTTP 503",
      ],
    });
    expect(logSpy).toHaveBeenCalledWith(
      "Checking whether Python package 'azure-mgmt-widget' is registered on PyPI.org...",
      LogLevel.Info,
    );
  });

  test("fails when any Python package is not registered", async () => {
    const fetchMock = vi
      .fn()
      .mockResolvedValueOnce(createFetchResponse(200))
      .mockResolvedValueOnce(createFetchResponse(404));
    vi.stubGlobal("fetch", fetchMock);
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const result = await validatePythonPackagesOnPyPI([
      { packageName: "azure-mgmt-registered" },
      { packageName: "azure-mgmt-new" },
    ]);

    expect(result.succeeded).toBe(false);
    expect(result.errors).toEqual([
      "Python package 'azure-mgmt-new' is not registered on PyPI.org yet. To reserve this package name, complete these actions: 1. Request namespace review at aka.ms/azsdk/ns-review; 2. After namespace approval, trigger the package-name reservation pipeline: aka.ms/python-reserve-pkg",
    ]);
    expect(fetchMock).toHaveBeenCalledTimes(2);
  });
});
