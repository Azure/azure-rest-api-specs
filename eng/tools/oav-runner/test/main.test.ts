import { describe, it, expect } from 'vitest';
import { greet } from '../src/main.js';

describe('greet', () => {
  it('should return greeting message', () => {
    const result = greet('World');
    expect(result).toBe('Hello, World!');
  });
});
