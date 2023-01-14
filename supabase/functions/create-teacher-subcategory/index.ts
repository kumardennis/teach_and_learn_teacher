// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';

console.log('Hello from Add teacher subcategory Functions!');

interface TeacherSubcategoryAddModel {
	teacherId: string;
	subcategoryId: string;
	feePerHour: number;
	levelFrom: number;
	levelUpto: number;
	otherDetails: string;
}

serve(async (req) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			teacherId,
			subcategoryId,
			feePerHour,
			levelFrom,
			levelUpto,
			otherDetails,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				teacherId,
				subcategoryId,
				feePerHour,
				levelFrom,
				levelUpto,
				otherDetails,
			])
		) {
			return new Response(
				JSON.stringify(errorResponseData),
				{ headers: { 'Content-Type': 'application/json' } },
			);
		}

		const createTeacherSubcategoryData: TeacherSubcategoryAddModel = {
			teacherId,
			subcategoryId,
			feePerHour,
			levelFrom,
			levelUpto,
			otherDetails,
		};

		const { data, error } = await supabase.from('Teachers_Subcategories')
			.insert(createTeacherSubcategoryData).select();

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
		responseData.isRequestSuccessful = false;
		responseData.data = null;
		responseData.error = err;

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	}
});
