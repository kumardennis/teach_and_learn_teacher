REVOKE ALL ON TABLE public."LessonSchedules" FROM anon;
REVOKE ALL ON TABLE public."LessonSchedules" FROM authenticated;
REVOKE ALL ON TABLE public."LessonSchedules" FROM postgres;
REVOKE ALL ON TABLE public."LessonSchedules" FROM service_role;
REVOKE ALL ON TABLE public."LessonSchedules" FROM supabase_admin;
GRANT ALL ON TABLE public."LessonSchedules" TO supabase_admin;

GRANT ALL ON TABLE public."LessonSchedules" TO authenticated;

GRANT ALL ON TABLE public."LessonSchedules" TO anon;

GRANT ALL ON TABLE public."LessonSchedules" TO postgres;

GRANT ALL ON TABLE public."LessonSchedules" TO service_role;

ALTER TABLE IF EXISTS public."LessonSchedules"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Children" FROM anon;
REVOKE ALL ON TABLE public."Children" FROM authenticated;
REVOKE ALL ON TABLE public."Children" FROM service_role;
REVOKE ALL ON TABLE public."Children" FROM supabase_admin;
GRANT ALL ON TABLE public."Children" TO anon;

GRANT ALL ON TABLE public."Children" TO supabase_admin;

GRANT ALL ON TABLE public."Children" TO authenticated;

GRANT ALL ON TABLE public."Children" TO service_role;

ALTER TABLE IF EXISTS public."Children"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Addresses_Schools" FROM anon;
REVOKE ALL ON TABLE public."Addresses_Schools" FROM authenticated;
REVOKE ALL ON TABLE public."Addresses_Schools" FROM service_role;
REVOKE ALL ON TABLE public."Addresses_Schools" FROM supabase_admin;
GRANT ALL ON TABLE public."Addresses_Schools" TO anon;

GRANT ALL ON TABLE public."Addresses_Schools" TO supabase_admin;

GRANT ALL ON TABLE public."Addresses_Schools" TO authenticated;

GRANT ALL ON TABLE public."Addresses_Schools" TO service_role;

ALTER TABLE IF EXISTS public."Addresses_Schools"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Addresses_LessonSchedules" FROM anon;
REVOKE ALL ON TABLE public."Addresses_LessonSchedules" FROM authenticated;
REVOKE ALL ON TABLE public."Addresses_LessonSchedules" FROM service_role;
REVOKE ALL ON TABLE public."Addresses_LessonSchedules" FROM supabase_admin;
GRANT ALL ON TABLE public."Addresses_LessonSchedules" TO anon;

GRANT ALL ON TABLE public."Addresses_LessonSchedules" TO supabase_admin;

GRANT ALL ON TABLE public."Addresses_LessonSchedules" TO authenticated;

GRANT ALL ON TABLE public."Addresses_LessonSchedules" TO service_role;

ALTER TABLE IF EXISTS public."Addresses_LessonSchedules"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Students_Schools" FROM anon;
REVOKE ALL ON TABLE public."Students_Schools" FROM authenticated;
REVOKE ALL ON TABLE public."Students_Schools" FROM service_role;
REVOKE ALL ON TABLE public."Students_Schools" FROM supabase_admin;
GRANT ALL ON TABLE public."Students_Schools" TO anon;

GRANT ALL ON TABLE public."Students_Schools" TO supabase_admin;

GRANT ALL ON TABLE public."Students_Schools" TO authenticated;

GRANT ALL ON TABLE public."Students_Schools" TO service_role;

-- ALTER TABLE IF EXISTS public."Students_Schools"
--     RENAME created_at TO id;

ALTER TABLE public."Students_Schools"
    ALTER COLUMN id TYPE uuid;
ALTER TABLE IF EXISTS public."Students_Schools"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

ALTER TABLE IF EXISTS public."Students_Schools"
    ALTER COLUMN id SET NOT NULL;

REVOKE ALL ON TABLE public."Groups_Students" FROM anon;
REVOKE ALL ON TABLE public."Groups_Students" FROM authenticated;
REVOKE ALL ON TABLE public."Groups_Students" FROM postgres;
REVOKE ALL ON TABLE public."Groups_Students" FROM service_role;
REVOKE ALL ON TABLE public."Groups_Students" FROM supabase_admin;
GRANT ALL ON TABLE public."Groups_Students" TO supabase_admin;

GRANT ALL ON TABLE public."Groups_Students" TO authenticated;

GRANT ALL ON TABLE public."Groups_Students" TO anon;

GRANT ALL ON TABLE public."Groups_Students" TO postgres;

GRANT ALL ON TABLE public."Groups_Students" TO service_role;

ALTER TABLE IF EXISTS public."Groups_Students"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

-- ALTER TABLE IF EXISTS public."Groups_Students"
--     RENAME id TO "schoolId";

ALTER TABLE IF EXISTS public."Groups_Students"
    ALTER COLUMN "schoolId" SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."LobbySchedules" FROM anon;
REVOKE ALL ON TABLE public."LobbySchedules" FROM authenticated;
REVOKE ALL ON TABLE public."LobbySchedules" FROM service_role;
REVOKE ALL ON TABLE public."LobbySchedules" FROM supabase_admin;
GRANT ALL ON TABLE public."LobbySchedules" TO anon;

GRANT ALL ON TABLE public."LobbySchedules" TO supabase_admin;

GRANT ALL ON TABLE public."LobbySchedules" TO authenticated;

GRANT ALL ON TABLE public."LobbySchedules" TO service_role;

ALTER TABLE IF EXISTS public."LobbySchedules" DROP COLUMN IF EXISTS "schedulaTimeEnd";

ALTER TABLE IF EXISTS public."LobbySchedules"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

-- ALTER TABLE IF EXISTS public."LobbySchedules"
--     ADD COLUMN "scheduleTimeEnd" time without time zone;

ALTER TABLE IF EXISTS public."LobbyScheduleTimes"
    OWNER TO supabase_admin;

REVOKE ALL ON TABLE public."LobbyScheduleTimes" FROM anon;
REVOKE ALL ON TABLE public."LobbyScheduleTimes" FROM authenticated;
REVOKE ALL ON TABLE public."LobbyScheduleTimes" FROM postgres;
REVOKE ALL ON TABLE public."LobbyScheduleTimes" FROM service_role;
GRANT ALL ON TABLE public."LobbyScheduleTimes" TO anon;

GRANT ALL ON TABLE public."LobbyScheduleTimes" TO postgres;

GRANT ALL ON TABLE public."LobbyScheduleTimes" TO supabase_admin;

GRANT ALL ON TABLE public."LobbyScheduleTimes" TO authenticated;

GRANT ALL ON TABLE public."LobbyScheduleTimes" TO service_role;

ALTER TABLE public."LobbyScheduleTimes"
    ALTER COLUMN id TYPE uuid;
ALTER TABLE IF EXISTS public."LobbyScheduleTimes"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

-- ALTER TABLE IF EXISTS public."LobbyScheduleTimes"
--     ALTER COLUMN id DROP IDENTITY;

ALTER TABLE IF EXISTS public."LobbyScheduleTimes"
    ADD COLUMN "isBooked" boolean;

REVOKE ALL ON TABLE public."Addresses_LobbySchedules" FROM anon;
REVOKE ALL ON TABLE public."Addresses_LobbySchedules" FROM authenticated;
REVOKE ALL ON TABLE public."Addresses_LobbySchedules" FROM service_role;
REVOKE ALL ON TABLE public."Addresses_LobbySchedules" FROM supabase_admin;
GRANT ALL ON TABLE public."Addresses_LobbySchedules" TO anon;

GRANT ALL ON TABLE public."Addresses_LobbySchedules" TO supabase_admin;

GRANT ALL ON TABLE public."Addresses_LobbySchedules" TO authenticated;

GRANT ALL ON TABLE public."Addresses_LobbySchedules" TO service_role;

ALTER TABLE IF EXISTS public."Addresses_LobbySchedules"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Teachers_Schools" FROM anon;
REVOKE ALL ON TABLE public."Teachers_Schools" FROM authenticated;
REVOKE ALL ON TABLE public."Teachers_Schools" FROM service_role;
REVOKE ALL ON TABLE public."Teachers_Schools" FROM supabase_admin;
GRANT ALL ON TABLE public."Teachers_Schools" TO anon;

GRANT ALL ON TABLE public."Teachers_Schools" TO supabase_admin;

GRANT ALL ON TABLE public."Teachers_Schools" TO authenticated;

GRANT ALL ON TABLE public."Teachers_Schools" TO service_role;

-- ALTER TABLE IF EXISTS public."Teachers_Schools"
--     RENAME created_at TO id;

ALTER TABLE public."Teachers_Schools"
    ALTER COLUMN id TYPE uuid;
ALTER TABLE IF EXISTS public."Teachers_Schools"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

ALTER TABLE IF EXISTS public."Teachers_Schools"
    ALTER COLUMN id SET NOT NULL;

REVOKE ALL ON TABLE public."TestTable" FROM anon;
REVOKE ALL ON TABLE public."TestTable" FROM authenticated;
REVOKE ALL ON TABLE public."TestTable" FROM service_role;
REVOKE ALL ON TABLE public."TestTable" FROM supabase_admin;
GRANT ALL ON TABLE public."TestTable" TO anon;

GRANT ALL ON TABLE public."TestTable" TO supabase_admin;

GRANT ALL ON TABLE public."TestTable" TO authenticated;

GRANT ALL ON TABLE public."TestTable" TO service_role;

REVOKE ALL ON TABLE public."Schools" FROM anon;
REVOKE ALL ON TABLE public."Schools" FROM authenticated;
REVOKE ALL ON TABLE public."Schools" FROM service_role;
REVOKE ALL ON TABLE public."Schools" FROM supabase_admin;
GRANT ALL ON TABLE public."Schools" TO anon;

GRANT ALL ON TABLE public."Schools" TO supabase_admin;

GRANT ALL ON TABLE public."Schools" TO authenticated;

GRANT ALL ON TABLE public."Schools" TO service_role;

-- ALTER TABLE IF EXISTS public."Schools"
--     RENAME created_at TO id;

ALTER TABLE public."Schools"
    ALTER COLUMN id TYPE uuid;
ALTER TABLE IF EXISTS public."Schools"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

ALTER TABLE IF EXISTS public."Schools"
    ALTER COLUMN id SET NOT NULL;

REVOKE ALL ON TABLE public."Lobbies" FROM anon;
REVOKE ALL ON TABLE public."Lobbies" FROM authenticated;
REVOKE ALL ON TABLE public."Lobbies" FROM postgres;
REVOKE ALL ON TABLE public."Lobbies" FROM service_role;
REVOKE ALL ON TABLE public."Lobbies" FROM supabase_admin;
GRANT ALL ON TABLE public."Lobbies" TO supabase_admin;

GRANT ALL ON TABLE public."Lobbies" TO authenticated;

GRANT ALL ON TABLE public."Lobbies" TO anon;

GRANT ALL ON TABLE public."Lobbies" TO postgres;

GRANT ALL ON TABLE public."Lobbies" TO service_role;

ALTER TABLE IF EXISTS public."Lobbies"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Schools_Subcategories" FROM anon;
REVOKE ALL ON TABLE public."Schools_Subcategories" FROM authenticated;
REVOKE ALL ON TABLE public."Schools_Subcategories" FROM service_role;
REVOKE ALL ON TABLE public."Schools_Subcategories" FROM supabase_admin;
GRANT ALL ON TABLE public."Schools_Subcategories" TO anon;

GRANT ALL ON TABLE public."Schools_Subcategories" TO supabase_admin;

GRANT ALL ON TABLE public."Schools_Subcategories" TO authenticated;

GRANT ALL ON TABLE public."Schools_Subcategories" TO service_role;

ALTER TABLE IF EXISTS public."Schools_Subcategories"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Teachers_Subcategories" FROM anon;
REVOKE ALL ON TABLE public."Teachers_Subcategories" FROM authenticated;
REVOKE ALL ON TABLE public."Teachers_Subcategories" FROM service_role;
REVOKE ALL ON TABLE public."Teachers_Subcategories" FROM supabase_admin;
GRANT ALL ON TABLE public."Teachers_Subcategories" TO anon;

GRANT ALL ON TABLE public."Teachers_Subcategories" TO supabase_admin;

GRANT ALL ON TABLE public."Teachers_Subcategories" TO authenticated;

GRANT ALL ON TABLE public."Teachers_Subcategories" TO service_role;

ALTER TABLE IF EXISTS public."Teachers_Subcategories"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Addresses_Teachers" FROM anon;
REVOKE ALL ON TABLE public."Addresses_Teachers" FROM authenticated;
REVOKE ALL ON TABLE public."Addresses_Teachers" FROM service_role;
REVOKE ALL ON TABLE public."Addresses_Teachers" FROM supabase_admin;
GRANT ALL ON TABLE public."Addresses_Teachers" TO anon;

GRANT ALL ON TABLE public."Addresses_Teachers" TO supabase_admin;

GRANT ALL ON TABLE public."Addresses_Teachers" TO authenticated;

GRANT ALL ON TABLE public."Addresses_Teachers" TO service_role;

ALTER TABLE IF EXISTS public."Addresses_Teachers"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."LessonScheduleTimes" FROM anon;
REVOKE ALL ON TABLE public."LessonScheduleTimes" FROM postgres;
REVOKE ALL ON TABLE public."LessonScheduleTimes" FROM service_role;
GRANT ALL ON TABLE public."LessonScheduleTimes" TO postgres;

GRANT ALL ON TABLE public."LessonScheduleTimes" TO anon;

GRANT ALL ON TABLE public."LessonScheduleTimes" TO service_role;

ALTER TABLE public."LessonScheduleTimes"
    ALTER COLUMN id TYPE uuid;
ALTER TABLE IF EXISTS public."LessonScheduleTimes"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

-- ALTER TABLE IF EXISTS public."LessonScheduleTimes"
--     ALTER COLUMN id DROP IDENTITY;

REVOKE ALL ON TABLE public."Categories" FROM anon;
REVOKE ALL ON TABLE public."Categories" FROM authenticated;
REVOKE ALL ON TABLE public."Categories" FROM service_role;
REVOKE ALL ON TABLE public."Categories" FROM supabase_admin;
GRANT ALL ON TABLE public."Categories" TO anon;

GRANT ALL ON TABLE public."Categories" TO supabase_admin;

GRANT ALL ON TABLE public."Categories" TO authenticated;

GRANT ALL ON TABLE public."Categories" TO service_role;

ALTER TABLE IF EXISTS public."Categories"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Students" FROM anon;
REVOKE ALL ON TABLE public."Students" FROM authenticated;
REVOKE ALL ON TABLE public."Students" FROM service_role;
REVOKE ALL ON TABLE public."Students" FROM supabase_admin;
GRANT ALL ON TABLE public."Students" TO anon;

GRANT ALL ON TABLE public."Students" TO supabase_admin;

GRANT ALL ON TABLE public."Students" TO authenticated;

GRANT ALL ON TABLE public."Students" TO service_role;

ALTER TABLE IF EXISTS public."Students"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Addresses_Groups" FROM anon;
REVOKE ALL ON TABLE public."Addresses_Groups" FROM authenticated;
REVOKE ALL ON TABLE public."Addresses_Groups" FROM service_role;
REVOKE ALL ON TABLE public."Addresses_Groups" FROM supabase_admin;
GRANT ALL ON TABLE public."Addresses_Groups" TO anon;

GRANT ALL ON TABLE public."Addresses_Groups" TO supabase_admin;

GRANT ALL ON TABLE public."Addresses_Groups" TO authenticated;

GRANT ALL ON TABLE public."Addresses_Groups" TO service_role;

ALTER TABLE IF EXISTS public."Addresses_Groups"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Subcategories" FROM anon;
REVOKE ALL ON TABLE public."Subcategories" FROM authenticated;
REVOKE ALL ON TABLE public."Subcategories" FROM service_role;
REVOKE ALL ON TABLE public."Subcategories" FROM supabase_admin;
GRANT ALL ON TABLE public."Subcategories" TO anon;

GRANT ALL ON TABLE public."Subcategories" TO supabase_admin;

GRANT ALL ON TABLE public."Subcategories" TO authenticated;

GRANT ALL ON TABLE public."Subcategories" TO service_role;

ALTER TABLE IF EXISTS public."Subcategories"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Addresses" FROM anon;
REVOKE ALL ON TABLE public."Addresses" FROM authenticated;
REVOKE ALL ON TABLE public."Addresses" FROM service_role;
REVOKE ALL ON TABLE public."Addresses" FROM supabase_admin;
GRANT ALL ON TABLE public."Addresses" TO anon;

GRANT ALL ON TABLE public."Addresses" TO supabase_admin;

GRANT ALL ON TABLE public."Addresses" TO authenticated;

GRANT ALL ON TABLE public."Addresses" TO service_role;

-- ALTER TABLE IF EXISTS public."Addresses"
--     RENAME created_at TO id;

ALTER TABLE public."Addresses"
    ALTER COLUMN id TYPE uuid;
ALTER TABLE IF EXISTS public."Addresses"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

ALTER TABLE IF EXISTS public."Addresses"
    ALTER COLUMN id SET NOT NULL;

REVOKE ALL ON TABLE public."Groups" FROM anon;
REVOKE ALL ON TABLE public."Groups" FROM authenticated;
REVOKE ALL ON TABLE public."Groups" FROM postgres;
REVOKE ALL ON TABLE public."Groups" FROM service_role;
REVOKE ALL ON TABLE public."Groups" FROM supabase_admin;
GRANT ALL ON TABLE public."Groups" TO supabase_admin;

GRANT ALL ON TABLE public."Groups" TO authenticated;

GRANT ALL ON TABLE public."Groups" TO anon;

GRANT ALL ON TABLE public."Groups" TO postgres;

GRANT ALL ON TABLE public."Groups" TO service_role;

ALTER TABLE IF EXISTS public."Groups"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

REVOKE ALL ON TABLE public."Teachers" FROM anon;
REVOKE ALL ON TABLE public."Teachers" FROM authenticated;
REVOKE ALL ON TABLE public."Teachers" FROM service_role;
REVOKE ALL ON TABLE public."Teachers" FROM supabase_admin;
GRANT ALL ON TABLE public."Teachers" TO anon;

GRANT ALL ON TABLE public."Teachers" TO supabase_admin;

GRANT ALL ON TABLE public."Teachers" TO authenticated;

GRANT ALL ON TABLE public."Teachers" TO service_role;

ALTER TABLE IF EXISTS public."Teachers"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();

-- ALTER TABLE IF EXISTS public."Teachers"
--     ADD COLUMN "userId" uuid;
-- ALTER TABLE IF EXISTS public."Teachers"
--     ADD CONSTRAINT "Teachers_userId_fkey" FOREIGN KEY ("userId")
--     REFERENCES public.users (id) MATCH SIMPLE
--     ON UPDATE NO ACTION
--     ON DELETE NO ACTION;

REVOKE ALL ON TABLE public."Lessons" FROM anon;
REVOKE ALL ON TABLE public."Lessons" FROM authenticated;
REVOKE ALL ON TABLE public."Lessons" FROM postgres;
REVOKE ALL ON TABLE public."Lessons" FROM service_role;
REVOKE ALL ON TABLE public."Lessons" FROM supabase_admin;
GRANT ALL ON TABLE public."Lessons" TO supabase_admin;

GRANT ALL ON TABLE public."Lessons" TO authenticated;

GRANT ALL ON TABLE public."Lessons" TO anon;

GRANT ALL ON TABLE public."Lessons" TO postgres;

GRANT ALL ON TABLE public."Lessons" TO service_role;

ALTER TABLE IF EXISTS public."Lessons"
    ALTER COLUMN id SET DEFAULT uuid_generate_v4();