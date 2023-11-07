package io.mob.resu.reandroidsdk;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class ModelResponseData {

    private String response;
    private int responseCode;
    private ArrayList<JSONObject> jsonObjects;


    public JSONArray getFieldTrackValues() throws JSONException {
        jsonObjects = new ArrayList<>();
        JSONObject jsonObject = new JSONObject(response);
        JSONArray jsonArray = jsonObject.optJSONArray("fieldCapture");
        return jsonArray;
    }


    public ModelResponseData(String response, int responseCode) {
        this.response = response;
        this.responseCode = responseCode;
    }

    public ModelResponseData() {
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public int getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(int responseCode) {
        this.responseCode = responseCode;
    }
}
