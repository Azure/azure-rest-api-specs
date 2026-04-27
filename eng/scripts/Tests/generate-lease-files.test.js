#!/usr/bin/env node
// Tests for generate-lease-files.js

const path = require("path");
const fs = require("fs");
const {
  parseInputLine,
  generateLeaseYaml,
  getLeasePath,
  validateStartDate,
  validateDuration,
  validateRpNamespace,
  validateOrgName,
  validateReviewer,
  getTodayDate,
} = require("../generate-lease-files.js");

function assert(condition, message) {
  if (!condition) throw new Error(`Test failed: ${message}`);
}

function testParseInputLine() {
  // Test without service names
  const result1 = parseInputLine("storage, Microsoft.Storage");
  assert(result1.orgName === "storage", "Org name should be storage");
  assert(
    result1.rpNamespace === "Microsoft.Storage",
    "RP should be Microsoft.Storage",
  );
  assert(result1.serviceNames.length === 0, "Should have no service names");

  // Test with service names
  const result2 = parseInputLine(
    "compute, Microsoft.Compute, [ComputeRP, DiskRP]",
  );
  assert(result2.orgName === "compute", "Org name should be compute");
  assert(
    result2.rpNamespace === "Microsoft.Compute",
    "RP should be Microsoft.Compute",
  );
  assert(result2.serviceNames.length === 2, "Should have 2 service names");
  assert(
    result2.serviceNames[0] === "ComputeRP",
    "First name should be ComputeRP",
  );
  assert(result2.serviceNames[1] === "DiskRP", "Second name should be DiskRP");

  // Test empty line
  const result3 = parseInputLine("");
  assert(result3 === null, "Empty line should return null");

  // Test comment
  const result4 = parseInputLine("# This is a comment");
  assert(result4 === null, "Comment should return null");

  console.log("✓ parseInputLine tests passed");
}

function testGenerateLeaseYaml() {
  const yaml = generateLeaseYaml(
    "Microsoft.Test",
    "2026-06-01",
    "P180D",
    "@johnDoe",
  );

  assert(
    yaml.includes("resource-provider: Microsoft.Test"),
    "Should include resource provider",
  );
  assert(yaml.includes('startdate: "2026-06-01"'), "Should include startdate with quotes");
  assert(
    yaml.includes("duration: P180D"),
    "Should include duration (not duration-days)",
  );
  assert(
    !yaml.includes("duration-days:"),
    "Should NOT use duration-days field",
  );
  assert(yaml.includes('reviewer: "@johnDoe"'), "Should include reviewer with quotes");
  assert(yaml.endsWith("\n\n"), "Should have trailing blank line (6th line)");

  console.log("✓ generateLeaseYaml tests passed");
}

function testGetLeasePath() {
  const repoRoot = "/repo";

  // Without service name (use path.join for cross-platform)
  const path1 = getLeasePath(repoRoot, "storage", "Microsoft.Storage");
  const expected1 = path.join(
    repoRoot,
    ".github",
    "arm-leases",
    "storage",
    "Microsoft.Storage",
    "lease.yaml",
  );
  assert(path1 === expected1, "Path without service name should be correct");

  // With service name
  const path2 = getLeasePath(
    repoRoot,
    "compute",
    "Microsoft.Compute",
    "DiskRP",
  );
  const expected2 = path.join(
    repoRoot,
    ".github",
    "arm-leases",
    "compute",
    "Microsoft.Compute",
    "DiskRP",
    "lease.yaml",
  );
  assert(path2 === expected2, "Path with service name should be correct");

  console.log("✓ getLeasePath tests passed");
}

function testValidateStartDate() {
  const today = getTodayDate();

  // Valid date (today)
  try {
    validateStartDate(today);
    console.log("  ✓ Today date is valid");
  } catch (error) {
    throw new Error("Today should be valid");
  }

  // Valid date (future)
  try {
    validateStartDate("2027-12-31");
    console.log("  ✓ Future date is valid");
  } catch (error) {
    throw new Error("Future date should be valid");
  }

  // Valid date (within grace period - 5 days ago)
  const fiveDaysAgo = new Date();
  fiveDaysAgo.setDate(fiveDaysAgo.getDate() - 5);
  const fiveDaysAgoStr = fiveDaysAgo.toISOString().split("T")[0];
  try {
    validateStartDate(fiveDaysAgoStr);
    console.log("  ✓ Date within 10-day grace period is valid");
  } catch (error) {
    throw new Error(
      `Date within 10-day grace period should be valid: ${error.message}`,
    );
  }

  // Invalid format
  try {
    validateStartDate("12/31/2026");
    throw new Error("Should reject invalid format");
  } catch (error) {
    if (error.message.includes("Invalid date format")) {
      console.log("  ✓ Rejects invalid date format");
    } else {
      throw error;
    }
  }

  // Past date (beyond grace period)
  try {
    validateStartDate("2020-01-01");
    throw new Error("Should reject date too far in the past");
  } catch (error) {
    if (error.message.includes("past")) {
      console.log("  ✓ Rejects date too far in the past");
    } else {
      throw error;
    }
  }

  console.log("✓ validateStartDate tests passed");
}

function testValidateDuration() {
  // Valid durations
  assert(validateDuration("P180D") === "P180D", "P180D should be valid");
  assert(validateDuration("P90D") === "P90D", "P90D should be valid");
  assert(validateDuration("P1D") === "P1D", "P1D should be valid");
  assert(validateDuration("p30d") === "P30D", "Should convert to uppercase");

  // Invalid format
  try {
    validateDuration("180 days");
    throw new Error("Should reject invalid format");
  } catch (error) {
    if (error.message.includes("Invalid duration format")) {
      console.log("  ✓ Rejects invalid duration format");
    } else {
      throw error;
    }
  }

  // Over 180 days
  try {
    validateDuration("P200D");
    throw new Error("Should reject over 180 days");
  } catch (error) {
    if (error.message.includes("between 1 and 180")) {
      console.log("  ✓ Rejects duration over 180 days");
    } else {
      throw error;
    }
  }

  // Zero days
  try {
    validateDuration("P0D");
    throw new Error("Should reject 0 days");
  } catch (error) {
    if (error.message.includes("between 1 and 180")) {
      console.log("  ✓ Rejects zero duration");
    } else {
      throw error;
    }
  }

  console.log("✓ validateDuration tests passed");
}

function testValidateRpNamespace() {
  // Valid RPs
  validateRpNamespace("Microsoft.Test");
  validateRpNamespace("Azure.Widget");
  validateRpNamespace("Contoso.Manager");

  // Invalid RPs
  try {
    validateRpNamespace("microsoft.Test");
    throw new Error("Should reject lowercase start");
  } catch (error) {
    if (error.message.includes("capital letter")) {
      console.log("  ✓ Rejects lowercase start");
    } else {
      throw error;
    }
  }

  console.log("✓ validateRpNamespace tests passed");
}

function testValidateOrgName() {
  // Valid org names
  validateOrgName("storage");
  validateOrgName("compute");
  validateOrgName("testservice123");
  validateOrgName("TestService"); // uppercase is now valid
  validateOrgName("BakeryRP");

  // Invalid org names (hyphen not allowed)
  try {
    validateOrgName("test-service");
    throw new Error("Should reject hyphen");
  } catch (error) {
    if (error.message.includes("alphanumeric")) {
      console.log("  ✓ Rejects hyphen");
    } else {
      throw error;
    }
  }

  console.log("✓ validateOrgName tests passed");
}

function testValidateReviewer() {
  // Valid reviewers (must start with @)
  assert(
    validateReviewer("@githubUser") === "@githubUser",
    "Valid @ reviewer should pass",
  );
  assert(
    validateReviewer("@johnDoe") === "@johnDoe",
    "Valid @ reviewer should pass",
  );
  assert(
    validateReviewer("  @trimmed  ") === "@trimmed",
    "Should trim whitespace",
  );

  // Invalid: missing @ prefix
  try {
    validateReviewer("githubUser");
    throw new Error("Should reject reviewer without @ prefix");
  } catch (error) {
    if (error.message.includes("@")) {
      console.log("  ✓ Rejects reviewer without @ prefix");
    } else {
      throw error;
    }
  }

  // Invalid: only @
  try {
    validateReviewer("@");
    throw new Error("Should reject @ only");
  } catch (error) {
    if (error.message.includes("@")) {
      console.log("  ✓ Rejects @ only");
    } else {
      throw error;
    }
  }

  // Invalid: empty string
  try {
    validateReviewer("");
    throw new Error("Should reject empty reviewer");
  } catch (error) {
    if (error.message.includes("required")) {
      console.log("  ✓ Rejects empty reviewer");
    } else {
      throw error;
    }
  }

  console.log("✓ validateReviewer tests passed");
}

function testGetTodayDate() {
  const today = getTodayDate();
  assert(
    /^\d{4}-\d{2}-\d{2}$/.test(today),
    "Today should be in YYYY-MM-DD format",
  );
  console.log(`✓ getTodayDate tests passed (today: ${today})`);
}

function runTests() {
  console.log("Running tests for generate-lease-files.js...\n");

  try {
    testParseInputLine();
    testGenerateLeaseYaml();
    testGetLeasePath();
    testValidateStartDate();
    testValidateDuration();
    testValidateRpNamespace();
    testValidateOrgName();
    testValidateReviewer();
    testGetTodayDate();

    console.log("\n✅ All tests passed!");
    return 0;
  } catch (error) {
    console.error(`\n❌ ${error.message}`);
    console.error(error.stack);
    return 1;
  }
}

if (require.main === module) {
  process.exit(runTests());
}

module.exports = { runTests };
