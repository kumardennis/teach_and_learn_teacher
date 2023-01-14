create table "public"."Addresses" (
    "created_at" timestamp with time zone default now(),
    "schoolId" uuid,
    "teacherId" uuid,
    "line1" text,
    "line2" text,
    "city" text,
    "stateCountyProvince" text,
    "zipCode" text,
    "countryName" text,
    "countryCode" text,
    "geoPoint" text,
    "name" text,
    "id" uuid not null default uuid_generate_v4(),
    "otherDetails" text
);


alter table "public"."Addresses" enable row level security;

create table "public"."Addresses_Groups" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "groupId" uuid not null default uuid_generate_v4(),
    "addressId" uuid not null default uuid_generate_v4()
);


alter table "public"."Addresses_Groups" enable row level security;

create table "public"."Addresses_LessonSchedules" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "scheduleId" uuid not null default uuid_generate_v4(),
    "addressId" uuid not null default uuid_generate_v4()
);


alter table "public"."Addresses_LessonSchedules" enable row level security;

create table "public"."Addresses_LobbySchedules" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "scheduleId" uuid,
    "addressId" uuid
);


alter table "public"."Addresses_LobbySchedules" enable row level security;

create table "public"."Addresses_Schools" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "schoolId" uuid not null default uuid_generate_v4(),
    "addressId" uuid not null default uuid_generate_v4()
);


alter table "public"."Addresses_Schools" enable row level security;

create table "public"."Addresses_Teachers" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "teacherId" uuid not null default uuid_generate_v4(),
    "addressId" uuid not null default uuid_generate_v4()
);


alter table "public"."Addresses_Teachers" enable row level security;

create table "public"."Categories" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "name" text,
    "picture" text
);


alter table "public"."Categories" enable row level security;

create table "public"."Children" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "schoolId" uuid,
    "firstName" text,
    "lastName" text,
    "profileImage" text,
    "rating" real,
    "proofOfIdentity" text,
    "parentId" uuid
);


alter table "public"."Children" enable row level security;

create table "public"."Groups" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "time" time without time zone,
    "dayOfWeek" numeric,
    "frequency" text,
    "schoolId" uuid,
    "teacherId" uuid,
    "maxOccupancy" numeric,
    "subcategoryId" uuid,
    "canBeSeenBy" text,
    "otherDetails" text,
    "levelFrom" numeric,
    "levelUpto" numeric
);


alter table "public"."Groups" enable row level security;

create table "public"."Groups_Students" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "groupId" uuid not null default uuid_generate_v4(),
    "studentId" uuid not null default uuid_generate_v4(),
    "schoolId" uuid not null default uuid_generate_v4(),
    "trainingLoadBalance" numeric,
    "isInWaitingList" boolean,
    "isAccepted" boolean,
    "reasonForRejection" text
);


alter table "public"."Groups_Students" enable row level security;

create table "public"."LessonScheduleTimes" (
    "created_at" timestamp with time zone default now(),
    "scheduleId" uuid,
    "time" time without time zone,
    "isBooked" boolean,
    "id" uuid not null default uuid_generate_v4()
);


alter table "public"."LessonScheduleTimes" enable row level security;

create table "public"."LessonSchedules" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "scheduleTimeStart" time without time zone,
    "scheduleDate" date,
    "isBooked" boolean,
    "teacherId" uuid,
    "maxOccupancy" numeric,
    "subcategoryId" uuid,
    "isRegularGroup" boolean,
    "groupId" uuid,
    "canBeSeenBy" text,
    "durationInMins" numeric,
    "feeForTheLesson" numeric,
    "feePerOccupant" numeric,
    "lateCancellationPenalty" numeric,
    "levelFrom" numeric,
    "levelUpto" numeric,
    "autoAddWaitingStudents" boolean,
    "scheduleTimeEnd" time without time zone
);


alter table "public"."LessonSchedules" enable row level security;

create table "public"."Lessons" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "studentId" uuid,
    "teacherId" uuid,
    "fee" numeric,
    "studentComment" text,
    "teacherComment" text,
    "paymentId" uuid,
    "studentRating" numeric,
    "teacherRating" numeric,
    "studentSkillLevelRating" numeric,
    "scheduleId" uuid,
    "hasLessonEnded" boolean,
    "hasLessonEndedEarly" boolean,
    "hasLessonStarted" boolean,
    "isCancelledByStudent" boolean,
    "isCancelledByTeacher" boolean,
    "IDealWithBooking" boolean,
    "isInWaitingList" boolean,
    "isAccepted" boolean,
    "isChild" boolean
);


alter table "public"."Lessons" enable row level security;

create table "public"."Lobbies" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "studentId" uuid,
    "creatorStudentId" uuid,
    "fee" numeric,
    "studentComment" text,
    "paymentId" uuid,
    "studentRating" numeric,
    "studentSkillLevelRating" numeric,
    "scheduleId" uuid,
    "hasLobbyEnded" boolean,
    "hasLobbyStarted" boolean,
    "isCancelledByCreator" boolean,
    "isCancelledByParticipant" boolean,
    "isInWaitingList" boolean,
    "isAccepted" boolean
);


alter table "public"."Lobbies" enable row level security;

create table "public"."LobbyScheduleTimes" (
    "created_at" timestamp with time zone default now(),
    "time" time without time zone,
    "scheduleId" uuid,
    "id" uuid not null default uuid_generate_v4(),
    "isBooked" boolean
);


alter table "public"."LobbyScheduleTimes" enable row level security;

create table "public"."LobbySchedules" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "scheduleTimeStart" time without time zone,
    "scheduleDate" date,
    "creatorStudentId" uuid,
    "maxOccupancy" numeric,
    "subcategoryId" uuid,
    "canBeSeenBy" text,
    "durationInMins" numeric,
    "feeForTheLesson" numeric,
    "feePerOccupant" numeric,
    "lateCancelationPenalty" numeric,
    "levelFrom" numeric,
    "levelUpto" numeric,
    "autoAddWaitingStudents" boolean,
    "scheduleTimeEnd" time without time zone
);


alter table "public"."LobbySchedules" enable row level security;

create table "public"."Schools" (
    "created_at" timestamp with time zone default now(),
    "name" text,
    "id" uuid not null default uuid_generate_v4(),
    "profileImage" text,
    "initials" text
);


alter table "public"."Schools" enable row level security;

create table "public"."Schools_Subcategories" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "subcategoryId" uuid not null default uuid_generate_v4(),
    "schoolId" uuid not null default uuid_generate_v4(),
    "otherDetails" text
);


alter table "public"."Schools_Subcategories" enable row level security;

create table "public"."Students" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "firstName" text,
    "lastName" text,
    "profileImage" text,
    "rating" real,
    "proofOfIdentity" text
);


alter table "public"."Students" enable row level security;

create table "public"."Students_Schools" (
    "created_at" timestamp with time zone default now(),
    "studentId" uuid not null default uuid_generate_v4(),
    "invitationAccepted" boolean,
    "isInvitationFromSchool" boolean,
    "isInvitationFromTeacher" boolean,
    "schoolId" uuid not null default uuid_generate_v4(),
    "id" uuid not null default uuid_generate_v4()
);


alter table "public"."Students_Schools" enable row level security;

create table "public"."Subcategories" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "categoryId" uuid,
    "name" text,
    "description" text,
    "picture" text
);


alter table "public"."Subcategories" enable row level security;

create table "public"."Teachers" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "firstName" text,
    "lastName" text,
    "profileImage" text,
    "rating" real,
    "proofOfAuthenticity" text,
    "proofOfIdentity" text,
    "allEarnings" numeric,
    "amountToBePaid" numeric,
    "userId" uuid
);


alter table "public"."Teachers" enable row level security;

create table "public"."Teachers_Schools" (
    "created_at" timestamp with time zone default now(),
    "teacherId" uuid not null default uuid_generate_v4(),
    "invitationAccepted" boolean,
    "isInvitationFromSchool" boolean,
    "isInvitationFromTeacher" boolean,
    "schoolId" uuid not null default uuid_generate_v4(),
    "id" uuid not null default uuid_generate_v4()
);


alter table "public"."Teachers_Schools" enable row level security;

create table "public"."Teachers_Subcategories" (
    "id" uuid not null default uuid_generate_v4(),
    "created_at" timestamp with time zone default now(),
    "subcategoryId" uuid not null default uuid_generate_v4(),
    "teacherId" uuid not null default uuid_generate_v4(),
    "feePerHour" numeric,
    "levelFrom" numeric,
    "levelUpto" numeric,
    "otherDetails" text
);


alter table "public"."Teachers_Subcategories" enable row level security;

create table "public"."TestTable" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone default now(),
    "field" text default 'value1'::text
);


CREATE UNIQUE INDEX "Addresses_Groups_pkey" ON public."Addresses_Groups" USING btree ("groupId", "addressId");

CREATE UNIQUE INDEX "Addresses_LessonSchedules_pkey" ON public."Addresses_LessonSchedules" USING btree ("scheduleId", "addressId");

CREATE UNIQUE INDEX "Addresses_Lobbies_pkey" ON public."Addresses_LobbySchedules" USING btree (id);

CREATE UNIQUE INDEX "Addresses_Schools_pkey" ON public."Addresses_Schools" USING btree ("schoolId", "addressId");

CREATE UNIQUE INDEX "Addresses_Teachers_pkey" ON public."Addresses_Teachers" USING btree ("teacherId", "addressId");

CREATE UNIQUE INDEX "Addresses_pkey" ON public."Addresses" USING btree (id);

CREATE UNIQUE INDEX "Categories_pkey" ON public."Categories" USING btree (id);

CREATE UNIQUE INDEX "Children_pkey" ON public."Children" USING btree (id);

CREATE UNIQUE INDEX "Groups_Students_pkey" ON public."Groups_Students" USING btree ("groupId", "studentId", "schoolId");

CREATE UNIQUE INDEX "Groups_pkey" ON public."Groups" USING btree (id);

CREATE UNIQUE INDEX "LessenSchedule_pkey" ON public."LessonSchedules" USING btree (id);

CREATE UNIQUE INDEX "LessonScheduleTimes_pkey" ON public."LessonScheduleTimes" USING btree (id);

CREATE UNIQUE INDEX "Lessons_pkey" ON public."Lessons" USING btree (id);

CREATE UNIQUE INDEX "Lobbies_pkey" ON public."Lobbies" USING btree (id);

CREATE UNIQUE INDEX "LobbyScheduleTimes_pkey" ON public."LobbyScheduleTimes" USING btree (id);

CREATE UNIQUE INDEX "LobbySchedule_pkey" ON public."LobbySchedules" USING btree (id);

CREATE UNIQUE INDEX "Schools_Subcategories_pkey" ON public."Schools_Subcategories" USING btree ("subcategoryId", "schoolId");

CREATE UNIQUE INDEX "Schools_pkey" ON public."Schools" USING btree (id);

CREATE UNIQUE INDEX "Students_Schools_pkey" ON public."Students_Schools" USING btree ("studentId", "schoolId");

CREATE UNIQUE INDEX "Students_pkey" ON public."Students" USING btree (id);

CREATE UNIQUE INDEX "Subcategories_pkey" ON public."Subcategories" USING btree (id);

CREATE UNIQUE INDEX "Teachers_Schools_pkey" ON public."Teachers_Schools" USING btree ("teacherId", "schoolId");

CREATE UNIQUE INDEX "Teachers_Subcategories_pkey" ON public."Teachers_Subcategories" USING btree ("subcategoryId", "teacherId");

CREATE UNIQUE INDEX "Teachers_pkey" ON public."Teachers" USING btree (id);

CREATE UNIQUE INDEX "TestTable_pkey" ON public."TestTable" USING btree (id);

alter table "public"."Addresses" add constraint "Addresses_pkey" PRIMARY KEY using index "Addresses_pkey";

alter table "public"."Addresses_Groups" add constraint "Addresses_Groups_pkey" PRIMARY KEY using index "Addresses_Groups_pkey";

alter table "public"."Addresses_LessonSchedules" add constraint "Addresses_LessonSchedules_pkey" PRIMARY KEY using index "Addresses_LessonSchedules_pkey";

alter table "public"."Addresses_LobbySchedules" add constraint "Addresses_Lobbies_pkey" PRIMARY KEY using index "Addresses_Lobbies_pkey";

alter table "public"."Addresses_Schools" add constraint "Addresses_Schools_pkey" PRIMARY KEY using index "Addresses_Schools_pkey";

alter table "public"."Addresses_Teachers" add constraint "Addresses_Teachers_pkey" PRIMARY KEY using index "Addresses_Teachers_pkey";

alter table "public"."Categories" add constraint "Categories_pkey" PRIMARY KEY using index "Categories_pkey";

alter table "public"."Children" add constraint "Children_pkey" PRIMARY KEY using index "Children_pkey";

alter table "public"."Groups" add constraint "Groups_pkey" PRIMARY KEY using index "Groups_pkey";

alter table "public"."Groups_Students" add constraint "Groups_Students_pkey" PRIMARY KEY using index "Groups_Students_pkey";

alter table "public"."LessonScheduleTimes" add constraint "LessonScheduleTimes_pkey" PRIMARY KEY using index "LessonScheduleTimes_pkey";

alter table "public"."LessonSchedules" add constraint "LessenSchedule_pkey" PRIMARY KEY using index "LessenSchedule_pkey";

alter table "public"."Lessons" add constraint "Lessons_pkey" PRIMARY KEY using index "Lessons_pkey";

alter table "public"."Lobbies" add constraint "Lobbies_pkey" PRIMARY KEY using index "Lobbies_pkey";

alter table "public"."LobbyScheduleTimes" add constraint "LobbyScheduleTimes_pkey" PRIMARY KEY using index "LobbyScheduleTimes_pkey";

alter table "public"."LobbySchedules" add constraint "LobbySchedule_pkey" PRIMARY KEY using index "LobbySchedule_pkey";

alter table "public"."Schools" add constraint "Schools_pkey" PRIMARY KEY using index "Schools_pkey";

alter table "public"."Schools_Subcategories" add constraint "Schools_Subcategories_pkey" PRIMARY KEY using index "Schools_Subcategories_pkey";

alter table "public"."Students" add constraint "Students_pkey" PRIMARY KEY using index "Students_pkey";

alter table "public"."Students_Schools" add constraint "Students_Schools_pkey" PRIMARY KEY using index "Students_Schools_pkey";

alter table "public"."Subcategories" add constraint "Subcategories_pkey" PRIMARY KEY using index "Subcategories_pkey";

alter table "public"."Teachers" add constraint "Teachers_pkey" PRIMARY KEY using index "Teachers_pkey";

alter table "public"."Teachers_Schools" add constraint "Teachers_Schools_pkey" PRIMARY KEY using index "Teachers_Schools_pkey";

alter table "public"."Teachers_Subcategories" add constraint "Teachers_Subcategories_pkey" PRIMARY KEY using index "Teachers_Subcategories_pkey";

alter table "public"."TestTable" add constraint "TestTable_pkey" PRIMARY KEY using index "TestTable_pkey";

alter table "public"."Addresses_Groups" add constraint "Addresses_Groups_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Addresses"(id) not valid;

alter table "public"."Addresses_Groups" validate constraint "Addresses_Groups_addressId_fkey";

alter table "public"."Addresses_Groups" add constraint "Addresses_Groups_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Groups"(id) not valid;

alter table "public"."Addresses_Groups" validate constraint "Addresses_Groups_groupId_fkey";

alter table "public"."Addresses_LessonSchedules" add constraint "Addresses_LessonSchedules_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Addresses"(id) not valid;

alter table "public"."Addresses_LessonSchedules" validate constraint "Addresses_LessonSchedules_addressId_fkey";

alter table "public"."Addresses_LessonSchedules" add constraint "Addresses_LessonSchedules_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "LessonSchedules"(id) not valid;

alter table "public"."Addresses_LessonSchedules" validate constraint "Addresses_LessonSchedules_scheduleId_fkey";

alter table "public"."Addresses_LobbySchedules" add constraint "Addresses_LobbySchedules_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Addresses"(id) not valid;

alter table "public"."Addresses_LobbySchedules" validate constraint "Addresses_LobbySchedules_addressId_fkey";

alter table "public"."Addresses_LobbySchedules" add constraint "Addresses_LobbySchedules_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "LobbySchedules"(id) not valid;

alter table "public"."Addresses_LobbySchedules" validate constraint "Addresses_LobbySchedules_scheduleId_fkey";

alter table "public"."Addresses_Schools" add constraint "Addresses_Schools_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Addresses"(id) not valid;

alter table "public"."Addresses_Schools" validate constraint "Addresses_Schools_addressId_fkey";

alter table "public"."Addresses_Schools" add constraint "Addresses_Schools_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "Schools"(id) not valid;

alter table "public"."Addresses_Schools" validate constraint "Addresses_Schools_schoolId_fkey";

alter table "public"."Addresses_Teachers" add constraint "Addresses_Teachers_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Addresses"(id) not valid;

alter table "public"."Addresses_Teachers" validate constraint "Addresses_Teachers_addressId_fkey";

alter table "public"."Addresses_Teachers" add constraint "Addresses_Teachers_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"(id) not valid;

alter table "public"."Addresses_Teachers" validate constraint "Addresses_Teachers_teacherId_fkey";

alter table "public"."Children" add constraint "Children_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Students"(id) not valid;

alter table "public"."Children" validate constraint "Children_parentId_fkey";

alter table "public"."Groups" add constraint "Groups_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "Schools"(id) not valid;

alter table "public"."Groups" validate constraint "Groups_schoolId_fkey";

alter table "public"."Groups" add constraint "Groups_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategories"(id) not valid;

alter table "public"."Groups" validate constraint "Groups_subcategoryId_fkey";

alter table "public"."Groups" add constraint "Groups_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"(id) not valid;

alter table "public"."Groups" validate constraint "Groups_teacherId_fkey";

alter table "public"."Groups_Students" add constraint "Groups_Students_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Groups"(id) not valid;

alter table "public"."Groups_Students" validate constraint "Groups_Students_groupId_fkey";

alter table "public"."Groups_Students" add constraint "Groups_Students_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "Schools"(id) not valid;

alter table "public"."Groups_Students" validate constraint "Groups_Students_schoolId_fkey";

alter table "public"."Groups_Students" add constraint "Groups_Students_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"(id) not valid;

alter table "public"."Groups_Students" validate constraint "Groups_Students_studentId_fkey";

alter table "public"."LessonScheduleTimes" add constraint "LessonScheduleTimes_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "LessonSchedules"(id) not valid;

alter table "public"."LessonScheduleTimes" validate constraint "LessonScheduleTimes_scheduleId_fkey";

alter table "public"."LessonSchedules" add constraint "LessonSchedules_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Groups"(id) not valid;

alter table "public"."LessonSchedules" validate constraint "LessonSchedules_groupId_fkey";

alter table "public"."LessonSchedules" add constraint "LessonSchedules_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategories"(id) not valid;

alter table "public"."LessonSchedules" validate constraint "LessonSchedules_subcategoryId_fkey";

alter table "public"."LessonSchedules" add constraint "LessonSchedules_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"(id) not valid;

alter table "public"."LessonSchedules" validate constraint "LessonSchedules_teacherId_fkey";

alter table "public"."Lessons" add constraint "Lessons_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "LessonSchedules"(id) not valid;

alter table "public"."Lessons" validate constraint "Lessons_scheduleId_fkey";

alter table "public"."Lessons" add constraint "Lessons_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"(id) not valid;

alter table "public"."Lessons" validate constraint "Lessons_studentId_fkey";

alter table "public"."Lessons" add constraint "Lessons_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"(id) not valid;

alter table "public"."Lessons" validate constraint "Lessons_teacherId_fkey";

alter table "public"."Lobbies" add constraint "Lobbies_creatorStudentId_fkey" FOREIGN KEY ("creatorStudentId") REFERENCES "Students"(id) not valid;

alter table "public"."Lobbies" validate constraint "Lobbies_creatorStudentId_fkey";

alter table "public"."Lobbies" add constraint "Lobbies_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "LobbySchedules"(id) not valid;

alter table "public"."Lobbies" validate constraint "Lobbies_scheduleId_fkey";

alter table "public"."Lobbies" add constraint "Lobbies_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"(id) not valid;

alter table "public"."Lobbies" validate constraint "Lobbies_studentId_fkey";

alter table "public"."LobbyScheduleTimes" add constraint "LobbyScheduleTimes_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "LobbySchedules"(id) not valid;

alter table "public"."LobbyScheduleTimes" validate constraint "LobbyScheduleTimes_scheduleId_fkey";

alter table "public"."LobbySchedules" add constraint "LobbySchedules_creatorStudentId_fkey" FOREIGN KEY ("creatorStudentId") REFERENCES "Students"(id) not valid;

alter table "public"."LobbySchedules" validate constraint "LobbySchedules_creatorStudentId_fkey";

alter table "public"."LobbySchedules" add constraint "LobbySchedules_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategories"(id) not valid;

alter table "public"."LobbySchedules" validate constraint "LobbySchedules_subcategoryId_fkey";

alter table "public"."Schools_Subcategories" add constraint "Schools_Subcategories_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "Schools"(id) not valid;

alter table "public"."Schools_Subcategories" validate constraint "Schools_Subcategories_schoolId_fkey";

alter table "public"."Schools_Subcategories" add constraint "Schools_Subcategories_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategories"(id) not valid;

alter table "public"."Schools_Subcategories" validate constraint "Schools_Subcategories_subcategoryId_fkey";

alter table "public"."Students_Schools" add constraint "Students_Schools_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "Schools"(id) not valid;

alter table "public"."Students_Schools" validate constraint "Students_Schools_schoolId_fkey";

alter table "public"."Students_Schools" add constraint "Students_Schools_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"(id) not valid;

alter table "public"."Students_Schools" validate constraint "Students_Schools_studentId_fkey";

alter table "public"."Subcategories" add constraint "Subcategories_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Categories"(id) not valid;

alter table "public"."Subcategories" validate constraint "Subcategories_categoryId_fkey";

alter table "public"."Teachers" add constraint "Teachers_userId_fkey" FOREIGN KEY ("userId") REFERENCES auth.users(id) not valid;

alter table "public"."Teachers" validate constraint "Teachers_userId_fkey";

alter table "public"."Teachers_Schools" add constraint "Teachers_Schools_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "Schools"(id) not valid;

alter table "public"."Teachers_Schools" validate constraint "Teachers_Schools_schoolId_fkey";

alter table "public"."Teachers_Schools" add constraint "Teachers_Schools_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"(id) not valid;

alter table "public"."Teachers_Schools" validate constraint "Teachers_Schools_teacherId_fkey";

alter table "public"."Teachers_Subcategories" add constraint "Teachers_Subcategories_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategories"(id) not valid;

alter table "public"."Teachers_Subcategories" validate constraint "Teachers_Subcategories_subcategoryId_fkey";

alter table "public"."Teachers_Subcategories" add constraint "Teachers_Subcategories_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"(id) not valid;

alter table "public"."Teachers_Subcategories" validate constraint "Teachers_Subcategories_teacherId_fkey";


