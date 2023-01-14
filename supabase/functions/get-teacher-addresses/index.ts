// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import {
  confirmedRequiredParams,
  errorResponseData,
} from "../_shared/confirmedRequiredParams.ts";
import { ResponseModel } from "../_shared/ResponseModel.ts";
import { createSupabase } from "../_shared/supabaseClient.ts";

console.log("Hello from Functions!");

serve(async (req) => {
  const supabase = createSupabase(req);
  const responseData: ResponseModel = {} as ResponseModel;

  try {
    const { teacherId } = await req.json();

    if (!confirmedRequiredParams([teacherId]))
      return new Response(JSON.stringify(errorResponseData), {
        headers: { "Content-Type": "application/json" },
      });

    const { data, error } = await supabase
      .from("Teachers")
      .select("Addresses(*)")
      .eq("id", teacherId);

    if (error !== null) {
      responseData.isRequestSuccceful = false;
      responseData.data = null;
      responseData.error = error;

      return new Response(JSON.stringify(responseData), {
        headers: { "Content-Type": "application/json" },
      });
    }

    responseData.isRequestSuccceful = true;
    responseData.data = data;
    responseData.error = error;

    return new Response(JSON.stringify(responseData), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    console.log(err);
    responseData.isRequestSuccceful = false;
    responseData.data = null;
    responseData.error = err;

    return new Response(JSON.stringify(responseData), {
      headers: { "Content-Type": "application/json" },
    });
  }
});
