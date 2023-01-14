import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.1.0';
import { corsHeaders } from './cors.ts';

export const createSupabase = (req: Request) =>
	createClient(
		Deno.env.get('SUPABASE_URL') ?? '',
		Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
		{
			global: {
				headers: {
					...corsHeaders,
					//  Authorization: req.headers.get('Authorization')!
				},
			},
		},
	);
