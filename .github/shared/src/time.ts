export interface DurationType {
  Millisecond: number;
  Second: number;
  Minute: number;
  Hour: number;
  Day: number;
  Week: number;
}
/**
 * Common time duration constants in milliseconds.
 */
export const Duration: DurationType = Object.freeze({
  Millisecond: 1,
  Second: 1000,
  Minute: 60 * 1000,
  Hour: 60 * 60 * 1000,
  Day: 24 * 60 * 60 * 1000,
  Week: 7 * 24 * 60 * 60 * 1000,
});

/**
 * Add milliseconds to a date.
 */
export function add(date: Date, ms: number): Date {
  return new Date(date.getTime() + ms);
}

/**
 * Formats a duration of milliseconds as hh:mm:ss (always zero-padded).
 */
export function formatDuration(ms: number): string {
  let totalSeconds = Math.floor(ms / Duration.Second);

  const hours = Math.floor(totalSeconds / 3600);
  totalSeconds %= 3600;

  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;

  const pad = (n: number) => String(n).padStart(2, "0");

  return `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
}

/**
 * Returns the number of milliseconds between two dates (always non-negative)
 */
export function getDuration(from: Date, to: Date): number {
  return Math.abs(from.getTime() - to.getTime());
}

/**
 * Subtract milliseconds from a date.
 */
export function subtract(date: Date, ms: number): Date {
  return new Date(date.getTime() - ms);
}
