// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';

import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';

console.log('Hello from Address Teacher Functions!');

interface AddressModel {
	line1: string;
	line2: string | null;
	city: string;
	stateCountyProvince: string;
	zipCode: string;
	countryName: string;
	countryCode: string;
	geoPoint: string;
	name: string;
	otherDetails: string;
}

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);

	try {
		const {
			line1,
			line2,
			city,
			stateCountyProvince,
			zipCode,
			countryName,
			countryCode,
			geoPoint,
			name,
			otherDetails,
			teacherId,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				teacherId,
				line1,
				line2,
				city,
				stateCountyProvince,
				zipCode,
				countryName,
				countryCode,
				geoPoint,
				name,
			])
		) {
			return new Response(
				JSON.stringify(errorResponseData),
				{ headers: { 'Content-Type': 'application/json' } },
			);
		}

		const addressReq: AddressModel = {
			line1,
			line2,
			city,
			stateCountyProvince,
			zipCode,
			countryName,
			countryCode,
			geoPoint,
			name,
			otherDetails,
		};

		const { data, error } = await supabase.from('Addresses').insert(
			addressReq,
		).select();

		if (error !== null) {
			const responseData: ResponseModel = {
				isRequestSuccessful: false,
				data: null,
				error: error,
			};

			return new Response(
				JSON.stringify(responseData),
				{ headers: { 'Content-Type': 'application/json' } },
			);
		}

		const createdAddressTeacherData = await supabase.from(
			'Addresses_Teachers',
		).insert({ addressId: data[0].id, teacherId }).select();

		const responseData: ResponseModel = {
			isRequestSuccessful: error === null,
			data: {
				createdAddressData: data,
				createdAddressTeacherData: createdAddressTeacherData.data,
			},
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
};
