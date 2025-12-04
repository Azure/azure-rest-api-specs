import { execSync } from 'child_process';
import { mkdtempSync, rmSync, writeFileSync, mkdirSync } from 'fs';
import { tmpdir } from 'os';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Test configuration
let totalTests = 0;
let passedTests = 0;
let failedTests = 0;

// Colors for console output
const colors = {
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  reset: '\x1b[0m'
};

console.log('=========================================');
console.log('Testing validate-lease.js');
console.log('=========================================\n');

// Helper function to setup test git repo
function setupTestRepo() {
  const testDir = mkdtempSync(join(tmpdir(), 'lease-test-'));
  process.chdir(testDir);
  
  execSync('git init', { stdio: 'ignore' });
  execSync('git config user.name "Test User"', { stdio: 'ignore' });
  execSync('git config user.email "test@example.com"', { stdio: 'ignore' });
  execSync('git checkout -b main', { stdio: 'ignore' });
  
  writeFileSync('README.md', '# Test Repo');
  execSync('git add README.md', { stdio: 'ignore' });
  execSync('git commit -m "Initial commit"', { stdio: 'ignore' });
  execSync('git checkout -b test-branch', { stdio: 'ignore' });
  
  return testDir;
}

// Helper function to get tomorrow's date in YYYY-MM-DD format
function getTomorrowDate() {
  const tomorrow = new Date();
  tomorrow.setDate(tomorrow.getDate() + 1);
  return tomorrow.toISOString().split('T')[0];
}

// Helper function to get today's date in YYYY-MM-DD format
function getTodayDate() {
  return new Date().toISOString().split('T')[0];
}

// Test runner
function runTest(testName, expectedResult, setupFn) {
  totalTests++;
  process.stdout.write(`Test ${totalTests}: ${testName} ... `);
  
  let testDir;
  let originalDir = process.cwd();
  
  try {
    testDir = setupTestRepo();
    setupFn();
    
    execSync('git add .', { stdio: 'ignore' });
    execSync('git commit -m "Test commit"', { stdio: 'ignore' });
    
    // Get the script path
    const scriptPath = join(__dirname, '../src/validate-lease.js');
    const nodeModulesPath = join(__dirname, '../..');
    
    try {
      const output = execSync(`node "${scriptPath}" main`, { 
        encoding: 'utf-8',
        cwd: testDir,
        env: { ...process.env, NODE_PATH: nodeModulesPath }
      });
      var actualResult = 'pass';
    } catch (error) {
      var actualResult = 'fail';
      // Debug output
      if (expectedResult === 'pass' && actualResult === 'fail') {
        console.log('\n--- Debug Output ---');
        console.log(error.stdout?.toString() || error.message);
        console.log('-------------------');
      }
    }
    
    if (actualResult === expectedResult) {
      console.log(`${colors.green}✓ PASSED${colors.reset}`);
      passedTests++;
    } else {
      console.log(`${colors.red}✗ FAILED${colors.reset} (expected: ${expectedResult}, got: ${actualResult})`);
      failedTests++;
    }
  } catch (error) {
    console.log(`${colors.red}✗ ERROR${colors.reset}: ${error.message}`);
    failedTests++;
  } finally {
    if (testDir) {
      process.chdir(originalDir);
      try {
        rmSync(testDir, { recursive: true, force: true });
      } catch (e) {
        // Ignore cleanup errors
      }
    }
  }
}

// Test 1: Valid lease file with correct structure
runTest('Valid lease file with correct structure', 'pass', () => {
  mkdirSync('lease/Microsoft.Test/TestService', { recursive: true });
  writeFileSync('lease/Microsoft.Test/TestService/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test
  startdate: ${getTomorrowDate()}
  duration: 180 days
  reviewer: Test User
`);
});

// Test 2: Invalid folder structure (missing service folder)
runTest('Invalid folder structure (missing service folder)', 'fail', () => {
  mkdirSync('lease/Microsoft.Test', { recursive: true });
  writeFileSync('lease/Microsoft.Test/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test
  startdate: ${getTomorrowDate()}
  duration: 180 days
  reviewer: Test User
`);
});

// Test 3: Resource provider name mismatch
runTest('Resource provider name mismatch', 'fail', () => {
  mkdirSync('lease/Microsoft.Test/TestService', { recursive: true });
  writeFileSync('lease/Microsoft.Test/TestService/lease.yaml', 
`lease:
  resource-provider: Microsoft.Wrong
  startdate: ${getTomorrowDate()}
  duration: 180 days
  reviewer: Test User
`);
});

// Test 4: Invalid date format
runTest('Invalid date format (MM/DD/YYYY)', 'fail', () => {
  mkdirSync('lease/Microsoft.Test/TestService', { recursive: true });
  writeFileSync('lease/Microsoft.Test/TestService/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test
  startdate: 12/03/2025
  duration: 180 days
  reviewer: Test User
`);
});

// Test 5: Past date
runTest('Startdate in the past', 'fail', () => {
  mkdirSync('lease/Microsoft.Test/TestService', { recursive: true });
  writeFileSync('lease/Microsoft.Test/TestService/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test
  startdate: 2020-01-01
  duration: 180 days
  reviewer: Test User
`);
});

// Test 6: Files outside lease directory
runTest('Files outside lease directory', 'fail', () => {
  mkdirSync('lease/Microsoft.Test/TestService', { recursive: true });
  writeFileSync('lease/Microsoft.Test/TestService/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test
  startdate: ${getTomorrowDate()}
  duration: 180 days
  reviewer: Test User
`);
  writeFileSync('random-file.txt', 'Some content');
});

// Test 7: Multiple valid lease files
runTest('Multiple valid lease files', 'pass', () => {
  mkdirSync('lease/Microsoft.Test1/TestService1', { recursive: true });
  writeFileSync('lease/Microsoft.Test1/TestService1/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test1
  startdate: ${getTomorrowDate()}
  duration: 180 days
  reviewer: Test User
`);
  
  mkdirSync('lease/Microsoft.Test2/TestService2', { recursive: true });
  writeFileSync('lease/Microsoft.Test2/TestService2/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test2
  startdate: ${getTomorrowDate()}
  duration: 90 days
  reviewer: Test User
`);
});

// Test 8: Today's date (should pass)
runTest("Startdate is today (should pass)", 'pass', () => {
  mkdirSync('lease/Microsoft.Test/TestService', { recursive: true });
  writeFileSync('lease/Microsoft.Test/TestService/lease.yaml', 
`lease:
  resource-provider: Microsoft.Test
  startdate: ${getTodayDate()}
  duration: 180 days
  reviewer: Test User
`);
});

// Summary
console.log('\n=========================================');
console.log('Test Summary');
console.log('=========================================');
console.log(`Total tests: ${totalTests}`);
console.log(`${colors.green}Passed: ${passedTests}${colors.reset}`);
console.log(`${colors.red}Failed: ${failedTests}${colors.reset}\n`);

if (failedTests === 0) {
  console.log(`${colors.green}All tests passed!${colors.reset}`);
  process.exit(0);
} else {
  console.log(`${colors.red}Some tests failed!${colors.reset}`);
  process.exit(1);
}
