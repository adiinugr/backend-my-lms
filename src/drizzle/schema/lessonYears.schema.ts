import { relations } from 'drizzle-orm';
import { pgTable, serial, text } from 'drizzle-orm/pg-core';

// Schema
import { subjectGroups } from './subjectGroups.schema';

export const lessonYears = pgTable('lesson_years', {
  id: serial('id').primaryKey(),
  name: text('name').notNull().unique(),
});

// lesson years relations
export const lessonYearsRelations = relations(lessonYears, ({ many }) => ({
  subjectGroups: many(subjectGroups),
}));
