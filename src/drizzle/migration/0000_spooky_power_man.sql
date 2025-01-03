CREATE TABLE IF NOT EXISTS "classrooms" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"grade_id" integer NOT NULL,
	CONSTRAINT "classrooms_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "grades" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	CONSTRAINT "grades_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "lesson_years" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	CONSTRAINT "lesson_years_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "marks" (
	"id" serial PRIMARY KEY NOT NULL,
	"student_id" integer NOT NULL,
	"subject_id" integer NOT NULL,
	"subject_group_id" integer NOT NULL,
	"semester" text NOT NULL,
	"mark" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "students" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"nis" text NOT NULL,
	"nisn" text NOT NULL,
	"place_of_birth" text NOT NULL,
	"date_of_birth" timestamp NOT NULL,
	"email" text NOT NULL,
	"password" text,
	CONSTRAINT "students_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "subject_groups" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"grade_id" integer NOT NULL,
	"lesson_year_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "subject_groups_to_classrooms_to_students" (
	"subject_group_id" integer NOT NULL,
	"classroom_id" integer NOT NULL,
	"student_id" integer NOT NULL,
	CONSTRAINT "subject_groups_to_classrooms_to_students_subject_group_id_classroom_id_student_id_pk" PRIMARY KEY("subject_group_id","classroom_id","student_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "subjects" (
	"id" serial PRIMARY KEY NOT NULL,
	"code" text NOT NULL,
	"name" text NOT NULL,
	CONSTRAINT "subjects_code_unique" UNIQUE("code"),
	CONSTRAINT "subjects_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "subject_to_subject_groups" (
	"subject_order" integer NOT NULL,
	"subject_id" integer NOT NULL,
	"subject_group_id" integer NOT NULL,
	CONSTRAINT "subject_to_subject_groups_subject_id_subject_group_id_pk" PRIMARY KEY("subject_id","subject_group_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "subject_groups_to_classrooms_to_students" ADD CONSTRAINT "subject_groups_to_classrooms_to_students_subject_group_id_subject_groups_id_fk" FOREIGN KEY ("subject_group_id") REFERENCES "public"."subject_groups"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "subject_groups_to_classrooms_to_students" ADD CONSTRAINT "subject_groups_to_classrooms_to_students_classroom_id_classrooms_id_fk" FOREIGN KEY ("classroom_id") REFERENCES "public"."classrooms"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "subject_groups_to_classrooms_to_students" ADD CONSTRAINT "subject_groups_to_classrooms_to_students_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "subject_to_subject_groups" ADD CONSTRAINT "subject_to_subject_groups_subject_id_subjects_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "subject_to_subject_groups" ADD CONSTRAINT "subject_to_subject_groups_subject_group_id_subject_groups_id_fk" FOREIGN KEY ("subject_group_id") REFERENCES "public"."subject_groups"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
