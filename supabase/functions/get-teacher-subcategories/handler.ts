import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { corsHeaders } from '../_shared/cors.ts';
import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const { teacherId } = await req.json();

		if (!confirmedRequiredParams([teacherId])) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase
			.from('Teachers_Subcategories')
			.select(
				'Subcategories(id, name, description, picture, categoryId)',
			)
			.eq('teacherId', teacherId);

		if (error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = null;
			responseData.error = error;

			return new Response(JSON.stringify(responseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		responseData.isRequestSuccessful = true;
		responseData.data = data;
		responseData.error = error;

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	} catch (err) {
		console.log(err);
		responseData.isRequestSuccessful = false;
		responseData.data = null;
		responseData.error = err;

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	}
};
