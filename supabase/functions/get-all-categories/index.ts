// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';

import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';

console.log('Hello from Categories Functions!');

serve(async (req) => {
	const supabase = createSupabase(req);

	try {
		const { data, error } = await supabase.from('Categories').select(
			'id, name, description, picture, Subcategories(id, name, description, picture)',
		);

		const responseData: ResponseModel = {
			isRequestSuccessful: error === null,
			data,
			error,
		};

		return new Response(
			JSON.stringify(responseData),
			{ headers: { 'Content-Type': 'application/json' } },
		);
	} catch (err) {
		const responseData: ResponseModel = {
			isRequestSuccessful: false,
			data: null,
			error: err,
		};

		return new Response(
			JSON.stringify(responseData),
			{ headers: { 'Content-Type': 'application/json' } },
		);
	}
});
