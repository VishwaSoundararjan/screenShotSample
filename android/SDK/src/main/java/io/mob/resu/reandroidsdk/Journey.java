package io.mob.resu.reandroidsdk;

import org.json.JSONObject;

public interface Journey {

    void onJourneyData(JSONObject data, String actionName);
}
